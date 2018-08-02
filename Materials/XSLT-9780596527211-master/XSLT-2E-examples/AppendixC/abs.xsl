<?xml version="1.0"?>
<!-- abs.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Here are some tests of the abs() function:&#xA;</xsl:text>
    <xsl:text>&#xA;  abs(7) = </xsl:text>
    <xsl:value-of select="abs(7)"/>
    <xsl:text>&#xA;  abs(-7) = </xsl:text>
    <xsl:value-of select="abs(-7)"/>
    <xsl:text>&#xA;  abs(0) = </xsl:text>
    <xsl:value-of select="abs(0)"/>
    <xsl:text>&#xA;  abs(-0) = </xsl:text>
    <xsl:value-of select="abs(-0)"/>

    <!-- An XSLT 2.0 processor won't run this example at all. -->
    <!-- <xsl:value-of select="abs('x')"/> -->

    <xsl:variable name="testSequence" as="xs:integer*" select="1 to 10"/>
    <xsl:text>&#xA;  $testSequence = </xsl:text>
    <xsl:value-of select="$testSequence" separator=", "/>
    <xsl:text>&#xA;  abs(count($testSequence)) = </xsl:text>
    <xsl:value-of select="abs(count($testSequence))"/>
  </xsl:template>

</xsl:stylesheet>
