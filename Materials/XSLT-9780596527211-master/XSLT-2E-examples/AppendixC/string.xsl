<?xml version="1.0"?>
<!-- string.xsl -->
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Tests of the string() function:</xsl:text>

    <xsl:text>&#xA;&#xA;  string(count(/report/brand)) = </xsl:text>
    <xsl:value-of select="string(count(/report/brand))"/>

    <xsl:text>&#xA;&#xA;  string(true()) = </xsl:text>
    <xsl:value-of select="string(true())"/>

    <xsl:text>&#xA;&#xA;  string(count(/report</xsl:text>
    <xsl:text>/brand/units[. &gt; 20000])) = </xsl:text>
    <xsl:value-of 
      select="string(count(/report/brand/units[. &gt; 20000]))"/>

    <xsl:text>&#xA;&#xA;  string(/report/brand/units</xsl:text>
    <xsl:text>[. &gt; 20000][1]/../name) = </xsl:text>
    <xsl:value-of 
      select="string(/report/brand/units[. &gt; 20000][1]/../name)"/>
  </xsl:template>

</xsl:stylesheet>
