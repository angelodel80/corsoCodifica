<?xml version="1.0"?>
<!-- value-of2.xsl -->
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:value-of>
      <xsl:text>Here is a list of the </xsl:text>
      <xsl:value-of select="count(//*)"/>
      <xsl:text> elements in your document:&#xA;&#xA;</xsl:text>
    </xsl:value-of>
    <xsl:value-of select="//*/name()" separator="&#xA;"/>
  </xsl:template>
  
</xsl:stylesheet>
