<?xml version="1.0"?>
<!-- local-name.xsl -->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;A test of the local-name() function:&#xA;</xsl:text>

    <xsl:for-each select="//*">
      <xsl:text>&#xA;    The local name for &lt;</xsl:text>
      <xsl:value-of select="name()"/>
      <xsl:text>&gt;: </xsl:text>
      <xsl:value-of select="local-name(.)"/>
    </xsl:for-each>
  </xsl:template>
  
</xsl:stylesheet>
