<?xml version="1.0"?>
<!-- boolean.xsl -->
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Tests of the boolean() function:</xsl:text>

    <xsl:text>&#xA;&#xA;  boolean(true()) = </xsl:text>
    <xsl:value-of select="boolean(true())"/>

    <xsl:text>&#xA;  boolean(true) = </xsl:text>
    <xsl:value-of select="boolean(true)"/>

    <xsl:text>&#xA;  boolean('false') = </xsl:text>
    <xsl:value-of select="boolean('false')"/>

    <xsl:text>&#xA;  boolean('7') = </xsl:text>
    <xsl:value-of select="boolean('7')"/>

    <xsl:text>&#xA;  boolean(7) = </xsl:text>
    <xsl:value-of select="boolean(7)"/>

    <xsl:text>&#xA;  boolean(/report/brand/units[. > 20000]) = </xsl:text>
    <xsl:value-of select="boolean(/report/brand/units[. > 20000])"/>
  </xsl:template>

</xsl:stylesheet>
