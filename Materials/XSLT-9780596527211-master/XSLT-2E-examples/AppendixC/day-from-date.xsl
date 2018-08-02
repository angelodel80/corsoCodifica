<?xml version="1.0"?>
<!-- day-from-date.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Extracting the day from an xs:date:</xsl:text>
    <xsl:variable name="currentDate" as="xs:date" select="current-date()"/>
    <xsl:text>&#xA;&#xA;The current date is: </xsl:text>
    <xsl:value-of select="$currentDate"/>

    <xsl:text>&#xA;&#xA;  The current day: </xsl:text>
    <xsl:value-of select="day-from-date($currentDate)"/>
    <xsl:text>&#xA;    In words: </xsl:text>
    <xsl:value-of select="format-date($currentDate, '[DWw]')"/>
    <xsl:text>&#xA;    In German: </xsl:text>
    <xsl:value-of select="format-date($currentDate, '[Dw]', 'de', (), ())"/>
    <xsl:text>&#xA;    It's the </xsl:text>
    <xsl:value-of select="format-date($currentDate, '[dwo]')"/>
    <xsl:text> day of the year.</xsl:text>
  </xsl:template>

</xsl:stylesheet>
