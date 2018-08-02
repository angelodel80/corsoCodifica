<?xml version="1.0"?>
<!-- normalize-space2.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;A test of the normalize-space() function:</xsl:text>

    <xsl:text>&#xA;&#xA;  normalize-space(())="</xsl:text>
    <xsl:value-of select="normalize-space(())"/>
    <xsl:text>"</xsl:text>
  </xsl:template>

</xsl:stylesheet>
