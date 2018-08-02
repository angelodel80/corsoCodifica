<?xml version="1.0"?>
<!-- idiv.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>Tests of idiv in XPath 2.0&#xA;</xsl:text>
    <xsl:text>&#xA;  9 idiv 3 = </xsl:text>
    <xsl:value-of select="9 idiv 3"/>
    <xsl:text>&#xA;  9 idiv 3.8 = </xsl:text>
    <xsl:value-of select="9 idiv 3.8"/>
    <xsl:text>&#xA;  9 idiv number('4') = </xsl:text>
    <xsl:value-of select="9 idiv number('4')"/>
    <!-- Causes a fatal error -->
    <!-- <xsl:value-of select="9 idiv number('Q')"/> -->
    <xsl:text>&#xA;  9 idiv number(true()) = </xsl:text>
    <xsl:value-of select="9 idiv number(true())"/>
    <!-- Causes a fatal error -->
    <!-- <xsl:value-of select="9 idiv number(false())"/> -->
  </xsl:template>
</xsl:stylesheet>
