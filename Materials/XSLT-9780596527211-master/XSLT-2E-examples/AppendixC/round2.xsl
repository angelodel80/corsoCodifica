<?xml version="1.0"?>
<!-- round2.xsl -->
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Tests of the round() function:&#xA;&#xA;</xsl:text>

    <xsl:text>  round(7.983) = </xsl:text>
    <xsl:value-of select="round(7.983)"/>

    <xsl:text>&#xA;  round(-7.893) = </xsl:text>
    <xsl:value-of select="round(-7.893)"/>

    <xsl:text>&#xA;  round(avg(/report/brand/units)) = </xsl:text>
    <xsl:value-of select="round(avg(/report/brand/units))"/>

    <xsl:text>&#xA;  [1.0] round('blue') = </xsl:text>
    <xsl:value-of version="1.0" select="round('blue')"/>

    <xsl:text>&#xA;  round(number('blue')) = </xsl:text>
    <xsl:value-of select="round(number('blue'))"/>
  </xsl:template>

</xsl:stylesheet>
