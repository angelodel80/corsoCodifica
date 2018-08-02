<?xml version="1.0"?>
<!-- in-scope-prefixes.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;A test of the in-scope-prefixes() function:</xsl:text>

    <xsl:for-each select="//*">
      <xsl:text>&#xA;    In-scope prefixes for &lt;</xsl:text>
      <xsl:value-of select="name()"/>
      <xsl:text>&gt;: </xsl:text>
      <xsl:value-of select="in-scope-prefixes(.)" separator=", "/>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
