<?xml version="1.0"?>
<!-- not.xsl -->
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Tests of the not() function:</xsl:text>

    <xsl:text>&#xA;&#xA;  not((true()) = </xsl:text>
    <xsl:value-of select="not(true())"/>

    <xsl:text>&#xA;  not(true) = </xsl:text>
    <xsl:value-of select="not(true)"/>

    <xsl:text>&#xA;  not('false') = </xsl:text>
    <xsl:value-of select="not('false')"/>

    <xsl:text>&#xA;  not('7') = </xsl:text>
    <xsl:value-of select="not('7')"/>

    <xsl:text>&#xA;  not(/report/brand/units[. > 20000]) = </xsl:text>
    <xsl:value-of select="not(/report/brand/units[. > 20000])"/>
  </xsl:template>

</xsl:stylesheet>
