<?xml version="1.0"?>
<!-- round-half-to-even.xsl -->
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Tests of the round-half-to-even() function:&#xA;</xsl:text>

    <xsl:text>&#xA;  round-half-to-even(-0.5) = </xsl:text>
    <xsl:value-of select="round-half-to-even(-0.5)"/>

    <xsl:text>&#xA;  round-half-to-even(0.5) = </xsl:text>
    <xsl:value-of select="round-half-to-even(0.5)"/>

    <xsl:text>&#xA;  round-half-to-even(1.5) = </xsl:text>
    <xsl:value-of select="round-half-to-even(1.5)"/>

    <xsl:text>&#xA;  round-half-to-even(2.5) = </xsl:text>
    <xsl:value-of select="round-half-to-even(2.5)"/>

    <xsl:text>&#xA;  round-half-to-even(number('NaN')) = </xsl:text>
    <xsl:value-of select="round-half-to-even(number('NaN'))"/>

    <xsl:text>&#xA;  round-half-to-even</xsl:text>
    <xsl:text>(avg(/report/brand/units)) = </xsl:text>
    <xsl:value-of select="round-half-to-even(avg(/report/brand/units))"/>

    <xsl:text>&#xA;  round-half-to-even</xsl:text>
    <xsl:text>(avg(/report/brand/units), -2) = </xsl:text>
    <xsl:value-of 
      select="round-half-to-even(avg(/report/brand/units), -2)"/>
  </xsl:template>

</xsl:stylesheet>
