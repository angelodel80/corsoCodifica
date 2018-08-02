<?xml version="1.0"?>
<!-- ceiling.xsl -->
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Tests of the ceiling() function:&#xA;&#xA;</xsl:text>

    <xsl:text>  ceiling(7.983) = </xsl:text>
    <xsl:value-of select="ceiling(7.983)"/>

    <xsl:text>&#xA;  ceiling(-7.893) = </xsl:text>
    <xsl:value-of select="ceiling(-7.893)"/>

    <xsl:text>&#xA;  ceiling(avg(/report/brand/units)) = </xsl:text>
    <xsl:value-of select="ceiling(avg(/report/brand/units))"/>

    <xsl:text>&#xA;  ceiling('blue') = </xsl:text>
    <xsl:value-of version="1.0" select="ceiling('blue')"/>

  </xsl:template>

</xsl:stylesheet>
