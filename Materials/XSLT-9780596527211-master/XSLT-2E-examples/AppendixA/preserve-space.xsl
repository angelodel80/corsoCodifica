<?xml version="1.0"?>
<!-- preserve-space.xsl -->
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:strip-space elements="*"/>
  <xsl:preserve-space elements="listing"/>

  <xsl:template match="/">
    <xsl:text>&#xA;</xsl:text>
    <xsl:value-of select="/code-sample/title"/>
    <xsl:text>&#xA;</xsl:text>
    <xsl:for-each select="/code-sample/listing">
      <xsl:value-of select="."/>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
