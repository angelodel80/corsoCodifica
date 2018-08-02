<?xml version="1.0"?>
<!-- number5.xsl -->
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="book">
    <xsl:for-each select=".//sect3">
      <xsl:number level="any" from="book" count="chapter" format="1."/>
      <xsl:number level="any" from="chapter" count="sect1" format="1."/>
      <xsl:number level="any" from="sect1" count="sect2" format="1."/>
      <xsl:number level="any" from="sect2" count="sect3" format="1. "/>
      <xsl:value-of select="title"/>
      <xsl:text>&#xA;</xsl:text>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
