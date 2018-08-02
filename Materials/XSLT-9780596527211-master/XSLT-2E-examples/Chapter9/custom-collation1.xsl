<?xml version="1.0"?>
<!-- custom-collation1.xsl -->
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>Test of sorting with custom collations:&#xA;&#xA;</xsl:text>
    <xsl:variable name="items" as="xs:string*" select="wordlist/word"/>
    <xsl:text>Word list in original order:&#xA;&#xA;</xsl:text>
    <xsl:value-of select="$items" separator="&#xA;"/>
    <xsl:text>&#xA;</xsl:text>
    <xsl:call-template name="ascending-alpha-sort">
      <xsl:with-param name="items" select="$items"/>
    </xsl:call-template>
    <xsl:call-template name="spanish-alpha-sort">
      <xsl:with-param name="items" select="$items"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="ascending-alpha-sort">
    <xsl:param name="items"/>
    <xsl:text>&#xA;Ascending text sort:&#xA;</xsl:text>
    <xsl:for-each select="$items">
      <xsl:sort/>
      <xsl:value-of select="."/>
      <xsl:text>&#xA;</xsl:text>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="spanish-alpha-sort">
    <xsl:param name="items"/>
    <xsl:text>&#xA;Spanish alpha sort:&#xA;</xsl:text>
    <xsl:for-each select="$items">
      <xsl:sort
        collation="{concat('http://saxon.sf.net/collation?', 
                   'class=com.oreilly.xslt.SpanishCollation;')}"/>
      <xsl:value-of select="."/>
      <xsl:text>&#xA;</xsl:text>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
