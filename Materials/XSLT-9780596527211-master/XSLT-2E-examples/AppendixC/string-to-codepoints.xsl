<?xml version="1.0" encoding="UTF-8"?>
<!-- string-to-codepoints.xsl -->
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Tests of the string-to-codepoints() </xsl:text>
    <xsl:text>function:&#xA;</xsl:text>

    <xsl:text>&#xA;  string-to-codepoints('Lily') = </xsl:text>
    <xsl:value-of 
      select="string-to-codepoints('Lily')" separator=", " />

    <xsl:text>&#xA;  string-to-codepoints('Stra&#xDF;e') = </xsl:text>
    <xsl:value-of 
      select="string-to-codepoints('Stra&#xDF;e')" separator=", "/>
  </xsl:template>

</xsl:stylesheet>
