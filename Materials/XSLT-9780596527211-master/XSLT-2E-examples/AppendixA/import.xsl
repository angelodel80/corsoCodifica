<?xml version="1.0"?>
<!-- import.xsl -->
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:import href="listitem.xsl"/>

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;</xsl:text>
    <xsl:apply-templates select="list/title"/>
    <xsl:apply-templates select="list/listitem"/>
  </xsl:template>

  <xsl:template match="listitem">
    <xsl:value-of select="position()"/>
    <xsl:text>.  </xsl:text>
    <xsl:value-of select="."/>
    <xsl:text>&#xA;</xsl:text>
  </xsl:template>

</xsl:stylesheet>
