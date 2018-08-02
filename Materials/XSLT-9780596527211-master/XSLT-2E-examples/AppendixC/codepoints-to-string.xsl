<?xml version="1.0"?>
<!-- codepoints-to-string.xsl -->
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Tests of the codepoints-to-string() </xsl:text>
    <xsl:text>function:&#xA;</xsl:text>

    <xsl:text>&#xA;  codepoints-to-string</xsl:text>
    <xsl:text>((76, 105, 108, 121)) = </xsl:text>
    <xsl:value-of 
      select="codepoints-to-string((76, 105, 108, 121))"/>

    <xsl:text>&#xA;  codepoints-to-string</xsl:text>
    <xsl:text>((83, 116, 114, 97, 223, 101)) = </xsl:text>
    <xsl:value-of 
      select="codepoints-to-string((83, 116, 114, 97, 223, 101))"/>
  </xsl:template>

</xsl:stylesheet>
