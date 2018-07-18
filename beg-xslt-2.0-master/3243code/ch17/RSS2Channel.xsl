<?xml version="1.0"?>
<!-- NOTE: This has been written to get around Saxon 7.7 non-conformance;
     revisit in Author Review. -->
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:rss="http://purl.org/rss/1.0/"
                xmlns:dc="http://purl.org/dc/elements/1.1/"
                xmlns:rev="http://www.example.com/reviews"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xdt="http://www.w3.org/2005/02/xpath-datatypes"
                xmlns:tv="http://www.example.com/TVGuide"
                exclude-result-prefixes="rdf rss dc rev xs xdt tv">

<xsl:strip-space elements="*" />

<xsl:output indent="yes" encoding="ISO-8859-1" />

<xsl:variable name="reviews" as="document-node()" 
              select="document('reviews.rss')" />

<xsl:key name="reviews" match="rss:item" 
  use="substring-before(
         substring-after(rss:link, 'http://www.example.com/reviews/'),
         '.html')" />

<xsl:template match="rdf:RDF">
  <Channel>
    <xsl:apply-templates select="rss:channel" />
    <xsl:apply-templates select="reverse(rss:item)" />
  </Channel>
</xsl:template>

<xsl:template match="rss:channel">
  <xsl:apply-templates select="rss:title" />
</xsl:template>

<xsl:template match="rss:channel/rss:title">
  <Name><xsl:value-of select="." /></Name>
</xsl:template>

<xsl:template match="rss:item">
  <xsl:variable name="videoPlus" as="xs:string" select="dc:identifier" />
  <Program videoPlus="{$videoPlus}">
    <xsl:apply-templates 
      select="key('reviews', $videoPlus, $reviews)/rev:rating" />
    <xsl:apply-templates select="@rdf:about" />
    <xsl:apply-templates select="." mode="duration" />
    <xsl:apply-templates select="rss:title" />
    <Title />
    <xsl:apply-templates select="rss:description" />
  </Program>
</xsl:template>

<xsl:template match="rss:item/rss:title">
  <Series><xsl:value-of select="." /></Series>
</xsl:template>

<xsl:template match="rss:description">
  <Description><xsl:value-of select="." /></Description>
</xsl:template>

<xsl:template match="@rdf:about">
  <Start><xsl:value-of select="substring-after(., '#')" /></Start>
</xsl:template>

<xsl:template match="rss:item" mode="duration">
  <xsl:variable name="nextProgram" as="element(rss:item)?" 
                select="preceding-sibling::rss:item[1]" />
  <xsl:if test="$nextProgram">
    <Duration>
      <xsl:variable name="start" as="xs:dateTime" 
        select="xs:dateTime(substring-after(@rdf:about, '#'))" />
      <xsl:variable name="end" as="xs:dateTime" 
        select="xs:dateTime(substring-after($nextProgram/@rdf:about, '#'))" />
      <xsl:value-of select="$end - $start" />
    </Duration>
  </xsl:if>
</xsl:template>

<xsl:template match="rev:rating">
  <xsl:attribute name="rating" select="." />
</xsl:template>

</xsl:stylesheet>