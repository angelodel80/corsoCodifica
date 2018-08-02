<?xml version="1.0" encoding="utf-8"?>
<!-- ends-with1.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:variable name="string1" select="'Have a nice day'"/>
    <xsl:variable name="string2" select="'Have a nice day!'"/>
    <xsl:variable name="string3" select="'day'"/>

    <xsl:text>&#xA;A test of the ends-with() function:&#xA;</xsl:text>
    
    <xsl:text>  ends-with('</xsl:text>
    <xsl:value-of select="$string1"/>
    <xsl:text>', '</xsl:text>
    <xsl:value-of select="$string3"/>
    <xsl:text>') = </xsl:text>
    <xsl:value-of select="ends-with($string1, $string3)"/>
    <xsl:text>&#xA;</xsl:text>

    <xsl:text>  ends-with('</xsl:text>
    <xsl:value-of select="$string2"/>
    <xsl:text>', '</xsl:text>
    <xsl:value-of select="$string3"/>
    <xsl:text>') = </xsl:text>
    <xsl:value-of select="ends-with($string2, $string3)"/>
    <xsl:text>&#xA;</xsl:text>
  </xsl:template>

</xsl:stylesheet>
