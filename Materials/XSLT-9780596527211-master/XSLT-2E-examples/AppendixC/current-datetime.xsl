<?xml version="1.0"?>
<!-- current-datetime.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>The current date and time is </xsl:text>
    <xsl:value-of 
      select="format-dateTime(current-dateTime(), 
              '[h]:[m01] [Pn] on [FNn], the [D1o] of [MNn], [Y]')"/>
    <xsl:text>&#xA;&#xA;The implicit timezone for the </xsl:text>
    <xsl:text>current context is: </xsl:text>
    <xsl:value-of select="implicit-timezone()"/>
    <xsl:text>&#xA;&#xA;The timezone extracted from the </xsl:text>
    <xsl:text>current date and time is: </xsl:text>
    <xsl:value-of select="timezone-from-dateTime(current-dateTime())"/>
  </xsl:template>

</xsl:stylesheet>
