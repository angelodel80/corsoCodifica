<?xml version="1.0"?>
<!-- param2.xsl -->
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:param name="favoriteNumber" 
    required="yes" as="xs:integer"/>

  <xsl:template match="/">
    <xsl:text>&#xA;</xsl:text>
    <xsl:value-of select="list/title"/>
    <xsl:text>&#xA;</xsl:text>
    <xsl:variable name="listitems" select="list/listitem"/>
    <xsl:call-template name="processListitems">
      <xsl:with-param name="items" select="$listitems"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="processListitems">
    <xsl:param name="items" required="yes"/>

    <xsl:for-each select="$items">
      <xsl:value-of select="position()"/>
      <xsl:text>.  </xsl:text>
      <xsl:value-of select="."/>
      <xsl:text>&#xA;</xsl:text>
    </xsl:for-each>

    <xsl:text>&#xA;</xsl:text>
    
    <xsl:text>Your favorite number is </xsl:text>
    <xsl:value-of select="$favoriteNumber"/>
    <xsl:text>.</xsl:text>
    <xsl:text>&#xA;</xsl:text>
  </xsl:template>

</xsl:stylesheet>
