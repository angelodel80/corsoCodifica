<?xml version="1.0"?>
<!-- true.xsl -->
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;A test of the true() function:&#xA;&#xA;</xsl:text>

    <xsl:text>  true() returned </xsl:text>
    <xsl:value-of select="true()"/>
    <xsl:text>!</xsl:text>
  </xsl:template>
</xsl:stylesheet>
