<?xml version="1.0"?>
<!-- include.xsl -->
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:include href="included-stylesheet.xsl"/>

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:value-of select="/report/title"/>
    <xsl:text>&#xA;&#xA;</xsl:text>
    <xsl:for-each select="report/brand">
      <xsl:text>  </xsl:text>
      <xsl:value-of select="name"/>
      <xsl:text> - </xsl:text>
      <xsl:value-of select="format-number(units, '##,###')"/>
      <xsl:text> bars sold. </xsl:text>
      <xsl:text>&#xA;</xsl:text>
    </xsl:for-each> 
    <xsl:text>&#xA;Total sales: </xsl:text>
    <xsl:value-of 
      select="format-number(sum(/report/brand/units), '##,###')"/>
    <xsl:text> bars.&#xA;&#xA;</xsl:text>
    <xsl:value-of select="$copyright"/>
  </xsl:template>

</xsl:stylesheet>
