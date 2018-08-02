<?xml version="1.0"?>
<!-- number2.xsl -->
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Tests of the number() function:</xsl:text>

    <xsl:text>&#xA;&#xA;  number(true()) = </xsl:text>
    <xsl:value-of select="number(true())"/>
    <xsl:text>&#xA;&#xA;  number(false()) = </xsl:text>
    <xsl:value-of select="number(false())"/>
    <xsl:text>&#xA;&#xA;  number(/report/brand[2]/units) = </xsl:text>
    <xsl:value-of select="number(/report/brand[2]/units)"/>
    <xsl:text>&#xA;&#xA;  number((//units)[1]) = </xsl:text>
    <xsl:value-of select="number((//units)[1])"/>
    <xsl:text>&#xA;&#xA;  number(/report/title) = </xsl:text>
    <xsl:value-of select="number(/report/title)"/>
    <xsl:text>&#xA;&#xA;  number(current-date()) = </xsl:text>
    <xsl:value-of select="number(current-date())"/>
    <xsl:text>&#xA;&#xA;  number(current-time()) = </xsl:text>
    <xsl:value-of select="number(current-time())"/>
  </xsl:template>

</xsl:stylesheet>
