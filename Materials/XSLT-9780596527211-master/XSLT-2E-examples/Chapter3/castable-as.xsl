<?xml version="1.0"?>
<!-- castable-as.xsl -->
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Some tests of the "castable as" operator:</xsl:text>

    <xsl:text>&#xA;&#xA;  '1995-04-21' castable as xs:date: </xsl:text>
    <xsl:value-of select="'1995-04-21' castable as xs:date"/>
    <xsl:text>&#xA;  '3' castable as xs:integer: </xsl:text>
    <xsl:value-of select="'3' castable as xs:integer"/>
    <xsl:text>&#xA;  3 castable as xs:integer: </xsl:text>
    <xsl:value-of select="3 castable as xs:integer"/>
    <xsl:text>&#xA;  'e' castable as xs:integer: </xsl:text>
    <xsl:value-of select="'e' castable as xs:integer"/>

  </xsl:template>
</xsl:stylesheet>
