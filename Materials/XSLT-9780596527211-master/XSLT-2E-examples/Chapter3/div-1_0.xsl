<?xml version="1.0"?>
<!-- div-1_0.xsl -->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>Tests of XPath div in XSLT 1.0&#xA;</xsl:text>
    <xsl:text>&#xA;  9 div 3 = </xsl:text>
    <xsl:value-of select="9 div 3"/>
    <xsl:text>&#xA;  9 div 3.8 = </xsl:text>
    <xsl:value-of select="9 div 3.8"/>
    <xsl:text>&#xA;  9 div '4' = </xsl:text>
    <xsl:value-of select="9 div '4'"/>
    <xsl:text>&#xA;  9 div 'Q' = </xsl:text>
    <xsl:value-of select="9 div 'Q'"/>
    <xsl:text>&#xA;  9 div true() = </xsl:text>
    <xsl:value-of select="9 div true()"/>
    <xsl:text>&#xA;  9 div false() = </xsl:text>
    <xsl:value-of select="9 div false()"/>
  </xsl:template>
</xsl:stylesheet>
