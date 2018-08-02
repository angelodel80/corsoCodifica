<?xml version="1.0"?>
<!-- parameters-1_0.xsl -->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:call-template name="test">
      <xsl:with-param name="param1" select="'57'"/>
      <xsl:with-param name="param2" select="'93'"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="test">
    <xsl:param name="param1"/>
    <xsl:text>Value of $param1: </xsl:text>
    <xsl:value-of select="$param1"/>
  </xsl:template>

</xsl:stylesheet>
