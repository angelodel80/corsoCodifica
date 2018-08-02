<?xml version="1.0"?>
<!-- doc-available.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Tests of the doc-available() function:&#xA;</xsl:text>

    <xsl:text>&#xA;  doc-available('polist.xml') = </xsl:text>
    <xsl:value-of select="doc-available('polist.xml')"/>

    <xsl:text>&#xA;&#xA;  doc-available('polist2.xml') = </xsl:text>
    <xsl:value-of select="doc-available('polist2.xml')"/>
  </xsl:template>

</xsl:stylesheet>
