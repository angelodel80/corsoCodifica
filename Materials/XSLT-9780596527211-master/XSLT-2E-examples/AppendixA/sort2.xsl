<?xml version="1.0"?>
<!-- sort2.xsl -->
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;</xsl:text>
    <xsl:variable name="date-sequence" as="xs:date*">
      <xsl:for-each select="/sample/datelist/listitem">
        <xsl:value-of select="xs:date(.)"/>
      </xsl:for-each>
    </xsl:variable>
    <xsl:call-template name="ascending-date-sort">
      <xsl:with-param name="items" select="$date-sequence"/>
    </xsl:call-template>
    <xsl:call-template name="spanish-alpha-sort">
      <xsl:with-param name="items" select="/sample/spanishlist/listitem"/>
    </xsl:call-template>
    <xsl:call-template name="ascending-alpha-sort">
      <xsl:with-param name="items" select="/sample/spanishlist/listitem"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="ascending-date-sort">
    <xsl:param name="items" as="xs:date*"/>
    <xsl:text>Ascending date sort:</xsl:text>
    <xsl:text>&#xA;</xsl:text>
    <xsl:for-each select="$items">
      <xsl:sort/>
      <xsl:value-of select="."/>
      <xsl:text>&#xA;</xsl:text>
    </xsl:for-each>
    <xsl:text>&#xA;</xsl:text>
  </xsl:template>

  <xsl:template name="spanish-alpha-sort">
    <xsl:param name="items"/>
    <xsl:text>Spanish alpha sort:</xsl:text>
    <xsl:text>&#xA;</xsl:text>
    <xsl:for-each select="$items">
      <xsl:sort
        collation="{concat('http://saxon.sf.net/collation?', 
                   'class=com.oreilly.xslt.SpanishCollation;')}"/>
      <xsl:value-of select="."/>
      <xsl:text>&#xA;</xsl:text>
    </xsl:for-each>
    <xsl:text>&#xA;</xsl:text>
  </xsl:template>

  <xsl:template name="ascending-alpha-sort">
    <xsl:param name="items"/>
    <xsl:text>Ascending text sort:</xsl:text>
    <xsl:text>&#xA;</xsl:text>
    <xsl:for-each select="$items">
      <xsl:sort/>
      <xsl:value-of select="."/>
      <xsl:text>&#xA;</xsl:text>
    </xsl:for-each>
    <xsl:text>&#xA;</xsl:text>
  </xsl:template>

</xsl:stylesheet>
