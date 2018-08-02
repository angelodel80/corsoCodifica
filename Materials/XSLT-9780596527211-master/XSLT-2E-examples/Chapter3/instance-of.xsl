<?xml version="1.0"?>
<!-- instance-of.xsl -->
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Some tests of the "instance of" operator:</xsl:text>

    <xsl:text>&#xA;&#xA;  '1995-04-21' instance of xs:date: </xsl:text>
    <xsl:value-of select="'1995-04-21' instance of xs:date"/>
    <xsl:text>&#xA;  xs:date('1995-04-21') instance of xs:date: </xsl:text>
    <xsl:value-of select="xs:date('1995-04-21') instance of xs:date"/>
    <xsl:text>&#xA;&#xA;  3 instance of xs:integer: </xsl:text>
    <xsl:value-of select="3 instance of xs:integer"/>
    <xsl:text>&#xA;  '3' instance of xs:integer: </xsl:text>
    <xsl:value-of select="'3' instance of xs:integer"/>
    <xsl:text>&#xA;  number('3') instance of xs:integer: </xsl:text>
    <xsl:value-of select="number('3') instance of xs:integer"/>
    <xsl:text>&#xA;  number('3') instance of xs:double: </xsl:text>
    <xsl:value-of select="number('3') instance of xs:double"/>
    <xsl:text>&#xA;  xs:integer('3') instance of xs:integer: </xsl:text>
    <xsl:value-of select="xs:integer('3') instance of xs:integer"/>
    <xsl:text>&#xA;  '3' cast as xs:integer instance of xs:integer: </xsl:text>
    <xsl:value-of select="'3' cast as xs:integer instance of xs:integer"/>
    <xsl:text>&#xA;  'e' instance of xs:integer: </xsl:text>
    <xsl:value-of select="'e' instance of xs:integer"/>

  </xsl:template>
</xsl:stylesheet>
