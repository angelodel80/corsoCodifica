<?xml version="1.0"?>
<!-- starts-with.xsl -->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;A test of the starts-with() </xsl:text>
    <xsl:text>function:&#xA;&#xA;</xsl:text>
    <xsl:for-each select="list/listitem[starts-with(., 'The')]">
      <xsl:number count="listitem" format="1. "/> 
      <xsl:value-of select="."/>
      <xsl:text>&#xA;</xsl:text>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
