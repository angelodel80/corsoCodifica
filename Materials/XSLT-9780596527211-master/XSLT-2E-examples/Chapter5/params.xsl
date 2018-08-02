<?xml version="1.0"?>
<!-- params.xsl -->
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:param name="startX"/>
  <xsl:param name="baseColor"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Global parameters example&#xA;&#xA;</xsl:text>

    <xsl:text>The value of startX is: </xsl:text>
    <xsl:value-of select="$startX"/>
    <xsl:text>&#xA;The value of baseColor is: </xsl:text>
    <xsl:value-of select="$baseColor"/>
    <xsl:text>&#xA;</xsl:text>
  </xsl:template>

</xsl:stylesheet>
