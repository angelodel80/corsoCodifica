<?xml version="1.0"?>
<!-- current-time.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>The current time is </xsl:text>
    <xsl:value-of 
      select="format-time(current-time(), 
              '[h]:[m01] [Pn]')"/>
    <xsl:text>&#xA;&#xA;The implicit timezone for the </xsl:text>
    <xsl:text>current context is: </xsl:text>
    <xsl:value-of select="implicit-timezone()"/>
    <xsl:text>&#xA;&#xA;The timezone extracted from the </xsl:text>
    <xsl:text>current date and time is: </xsl:text>
    <xsl:value-of select="timezone-from-time(current-time())"/>
  </xsl:template>

</xsl:stylesheet>
