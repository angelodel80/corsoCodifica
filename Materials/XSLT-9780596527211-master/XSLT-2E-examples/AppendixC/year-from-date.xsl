<?xml version="1.0"?>
<!-- year-from-date.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Extracting the year from an xs:date:</xsl:text>
    <xsl:variable name="currentDate" as="xs:date" select="current-date()"/>
    <xsl:text>&#xA;&#xA;  The current date is: </xsl:text>
    <xsl:value-of select="$currentDate"/>

    <xsl:text>&#xA;&#xA;  The current year: </xsl:text>
    <xsl:value-of select="year-from-date($currentDate)"/>
    <xsl:text>&#xA;    In words: </xsl:text>
    <xsl:value-of select="format-date($currentDate, '[YWw]')"/>
    <xsl:text>&#xA;    In German: </xsl:text>
    <xsl:value-of select="format-date($currentDate, '[YWw]', 'de', (), ())"/>
  </xsl:template>

</xsl:stylesheet>
