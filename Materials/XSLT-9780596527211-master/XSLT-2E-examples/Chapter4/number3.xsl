<?xml version="1.0" encoding="utf-8"?>
<!-- number3.xsl -->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>Automobile manufacturers and their cars&#xA;</xsl:text>
    <xsl:for-each select="cars/manufacturer">
      <xsl:number count="manufacturer" format="1. "/>
      <xsl:value-of select="@name"/>
      <xsl:text>&#xA;</xsl:text>
      <xsl:for-each select="car">
        <xsl:number count="manufacturer|car" level="multiple" 
          format="1.1. "/>
        <xsl:value-of select="."/>
        <xsl:text>&#xA;</xsl:text>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
