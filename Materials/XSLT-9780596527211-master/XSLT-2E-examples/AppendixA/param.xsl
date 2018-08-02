<?xml version="1.0"?>
<!-- param.xsl -->
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:param name="favoriteNumber" select="23"/>
  <xsl:param name="favoriteColor"/>

  <xsl:template match="/">
    <xsl:text>&#xA;</xsl:text>
    <xsl:value-of select="list/title"/>
    <xsl:text>&#xA;</xsl:text>
    <xsl:variable name="listitems" select="list/listitem"/>
    <xsl:call-template name="processListItems">
      <xsl:with-param name="items" select="$listitems"/>
      <xsl:with-param name="color" select="'yellow'"/>
      <xsl:with-param name="number" select="$favoriteNumber"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="processListItems">
    <xsl:param name="items"/>
    <xsl:param name="color" select="'blue'"/>

    <xsl:for-each select="$items">
      <xsl:value-of select="position()"/>
      <xsl:text>.  </xsl:text>
      <xsl:value-of select="."/>
      <xsl:text>&#xA;</xsl:text>
    </xsl:for-each>

    <xsl:text>&#xA;</xsl:text>
    
    <xsl:text>Your favorite color is </xsl:text>
    <xsl:value-of select="$favoriteColor"/>
    <xsl:text>.</xsl:text>
    <xsl:text>&#xA;</xsl:text>
    <xsl:text>The color passed to this template is </xsl:text>
    <xsl:value-of select="$color"/>
    <xsl:text>.</xsl:text>
    <xsl:text>&#xA;</xsl:text>
  </xsl:template>

</xsl:stylesheet>
