<?xml version="1.0"?>
<!-- value-of.xsl -->
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>Your document contains </xsl:text>
    <xsl:value-of select="count(//*)"/>
    <xsl:text> elements and </xsl:text>
    <xsl:value-of select="count(//@*)"/>
    <xsl:text> attributes.&#xA;Have a great day!</xsl:text>
  </xsl:template>
  
</xsl:stylesheet>
