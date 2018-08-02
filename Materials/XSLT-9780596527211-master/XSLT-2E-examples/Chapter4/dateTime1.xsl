<?xml version="1.0" encoding="utf-8"?>
<!-- datetime1.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Tests of date and time formatting:&#xA;</xsl:text>
    <xsl:text>&#xA;  The current date is </xsl:text>
    <xsl:value-of select="format-date(current-date(), 
                          '[M01]/[D01]/[Y0001]')"/>
    <xsl:text>&#xA;  The current time is </xsl:text>
    <xsl:value-of select="format-time(current-time(), 
                          '[H01]:[m01] [z]')"/>
    <xsl:text>&#xA;  It's currently </xsl:text>
    <xsl:value-of select="format-dateTime(current-dateTime(),
                          '[h1]:[m01] [P] on [MNn] [D].')"/>
  </xsl:template>

</xsl:stylesheet>
