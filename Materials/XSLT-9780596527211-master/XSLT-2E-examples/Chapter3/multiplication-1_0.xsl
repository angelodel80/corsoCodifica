<?xml version="1.0"?>
<!-- multiplication-1_0.xsl -->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>Tests of XPath multiplication in XPath 1.0&#xA;</xsl:text>
    <xsl:text>&#xA;  9 * 3 = </xsl:text>
    <xsl:value-of select="9 * 3"/>
    <xsl:text>&#xA;  9 * 3.8 = </xsl:text>
    <xsl:value-of select="9 * 3.8"/>
    <xsl:text>&#xA;  9 * '4' = </xsl:text>
    <xsl:value-of select="9 * '4'"/>
    <xsl:text>&#xA;  9 * 'Q' = </xsl:text>
    <xsl:value-of select="9 * 'Q'"/>
    <xsl:text>&#xA;  9 * true() = </xsl:text>
    <xsl:value-of select="9 * true()"/>
    <xsl:text>&#xA;  9 * false() = </xsl:text>
    <xsl:value-of select="9 * false()"/>
  </xsl:template>
</xsl:stylesheet>
