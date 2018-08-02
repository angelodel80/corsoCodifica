<?xml version="1.0"?>
<!-- if.xsl -->
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;</xsl:text>
    <xsl:text>Here are the odd-numbered items from the list:</xsl:text>
    <xsl:text>&#xA;</xsl:text>
    <xsl:for-each select="list/listitem">
      <xsl:if test="(position() mod 2) = 1">
        <xsl:number format="1. "/>
        <xsl:value-of select="."/>
        <xsl:text>&#xA;</xsl:text>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>
  
</xsl:stylesheet>
