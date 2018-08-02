<?xml version="1.0"?>
<!-- name.xsl -->
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:auth="http://www.authors.com/">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;A test of the name() function:&#xA;</xsl:text>

    <xsl:for-each select="//*">
      <xsl:text>&#xA;  Element </xsl:text>
      <xsl:number level="any" count="*"/>
      <xsl:text>: </xsl:text>
      <xsl:value-of select="name()"/>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
