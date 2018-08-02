<?xml version="1.0"?>
<!-- string-length.xsl -->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Tests of the string-length() function:</xsl:text>

    <xsl:text>&#xA;&#xA;   string-length() = </xsl:text>
    <xsl:value-of select="string-length()"/>
    <xsl:text>&#xA;   string-length(/report) = </xsl:text>
    <xsl:value-of select="string-length(/report)"/>
    <xsl:text>&#xA;   string-length(/report/brand[1]) = </xsl:text>
    <xsl:value-of select="string-length(/report/brand[1])"/>
    <xsl:text>&#xA;   string-length(/report/brand[1]/name) = </xsl:text>
    <xsl:value-of select="string-length(/report/brand[1]/name)"/>

    <xsl:text>&#xA;</xsl:text>
    <xsl:for-each select="/report/brand">
      <xsl:text>&#xA;   The name of brand #</xsl:text>
      <xsl:value-of select="position()"/>
      <xsl:text>, </xsl:text>
      <xsl:value-of select="name"/>
      <xsl:text>, has </xsl:text>
      <xsl:value-of select="string-length(name)"/>
      <xsl:text> characters.</xsl:text>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
