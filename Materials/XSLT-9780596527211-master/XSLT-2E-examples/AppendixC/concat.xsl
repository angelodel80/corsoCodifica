<?xml version="1.0"?>
<!-- concat.xsl -->
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Tests of the concat() function: &#xA;</xsl:text>
    <xsl:for-each select="list/listitem">
      <xsl:text>&#xA;  See the file </xsl:text>
      <xsl:value-of select="concat('album', position(), '.html')"/>
      <xsl:text> to see the details of &#xA;    the album "</xsl:text>
      <xsl:value-of select="."/>
      <xsl:text>."&#xA;</xsl:text>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
