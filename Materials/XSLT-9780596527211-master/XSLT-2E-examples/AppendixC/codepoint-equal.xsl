<?xml version="1.0"?>
<!-- codepoint-equal.xsl -->
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Tests of the codepoint-equal() function:&#xA;</xsl:text>

    <xsl:text>&#xA;  codepoint-equal('A', 'A') = </xsl:text>
    <xsl:value-of select="codepoint-equal('A', 'A')"/>

    <xsl:text>&#xA;  codepoint-equal('A', '&amp;#x41;') = </xsl:text>
    <xsl:value-of select="codepoint-equal('A', '&#x41;')"/>

    <xsl:text>&#xA;  codepoint-equal('A', '&amp;#65;') = </xsl:text>
    <xsl:value-of select="codepoint-equal('A', '&#65;')"/>

    <xsl:text>&#xA;  codepoint-equal('Strasse', 'Stra&amp;#xDF;e') = </xsl:text>
    <xsl:value-of select="codepoint-equal('Strasse', 'Stra&#xDF;e')"/>
  </xsl:template>

</xsl:stylesheet>
