<?xml version="1.0"?>
<!-- string2.xsl -->
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;More tests of the string() function:</xsl:text>

    <xsl:text>&#xA;&#xA;  string(xs:double(2718.28E-3)) = </xsl:text>
    <xsl:value-of select="string(xs:double(2718.28E-3))"/>

    <xsl:text>&#xA;&#xA;  string(current-dateTime()) = </xsl:text>
    <xsl:value-of select="string(current-dateTime())"/>

    <xsl:text>&#xA;&#xA;  string(xs:yearMonthDuration</xsl:text>
    <xsl:text>('P3Y8M')) = </xsl:text>
    <xsl:value-of 
      select="string(xs:yearMonthDuration('P3Y8M'))"/>

    <xsl:text>&#xA;&#xA;  string(xs:date('1995-04-21')) = </xsl:text>
    <xsl:value-of 
      select="string(xs:date('1995-04-21'))"/>

    <xsl:variable name="topBrands" as="xs:string*"
      select="/report/brand/units[. &gt; 15000]/../name/string()"/>
    <xsl:text>&#xA;&#xA;  Top-selling brands: &#xA;    </xsl:text>
    <xsl:value-of select="$topBrands" separator=", "/>
  </xsl:template>

</xsl:stylesheet>
