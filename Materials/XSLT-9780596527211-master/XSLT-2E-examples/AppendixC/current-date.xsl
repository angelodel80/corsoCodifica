<?xml version="1.0"?>
<!-- current-date.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>The current date is </xsl:text>
    <xsl:value-of 
      select="format-date(current-date(), 
              '[FNn], the [D1o] of [MNn], [Y0001]')"/>
    <xsl:text>&#xA;&#xA;The implicit timezone for the </xsl:text>
    <xsl:text>current context is: </xsl:text>
    <xsl:value-of select="implicit-timezone()"/>
    <xsl:text>&#xA;&#xA;The timezone extracted from the </xsl:text>
    <xsl:text>current date is: </xsl:text>
    <xsl:value-of select="timezone-from-date(current-date())"/>
  </xsl:template>

</xsl:stylesheet>
