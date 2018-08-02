<?xml version="1.0" encoding="utf-8"?>
<!-- datetime2.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;More tests of date and time formatting:&#xA;</xsl:text>
    <xsl:text>&#xA;  Today is the </xsl:text>
    <xsl:value-of select="format-date(current-date(), 
                          '[Dwo] day of [MNn], [Y0001]')"/>
    <xsl:text>&#xA;  Right now is the </xsl:text>
    <xsl:value-of select="format-time(current-time(), 
                          '[m1o] minute of the [Hwo] hour of the day.')"/>
    <xsl:text>&#xA;  It's currently </xsl:text>
    <xsl:value-of select="format-dateTime(current-dateTime(),
                          '[h01]:[m01] [P] on [FNn] the [D1o].')"/>
    <xsl:text>&#xA;  Today is the </xsl:text>
    <xsl:value-of select="format-date(current-date(),
                          '[dwo]')"/>
    <xsl:text> day of the year. </xsl:text>
    <xsl:text>&#xA;  December 25, 1960 in German: </xsl:text>
    <xsl:value-of select="format-date(xs:date('1960-12-25'), 
                          '[D] [MNn,3-3] [Y0001]', 'de', 
                          'AD', 'DE')"/>
  </xsl:template>

</xsl:stylesheet>
