<?xml version="1.0"?>
<!-- floor.xsl -->
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Tests of the floor() function:&#xA;&#xA;</xsl:text>

    <xsl:text>  floor(7.983) = </xsl:text>
    <xsl:value-of select="floor(7.983)"/>

    <xsl:text>&#xA;  floor(-7.893) = </xsl:text>
    <xsl:value-of select="floor(-7.893)"/>

    <xsl:text>&#xA;  floor('blue') = </xsl:text>
    <xsl:value-of version="1.0" select="floor('blue')"/>

  </xsl:template>

</xsl:stylesheet>
