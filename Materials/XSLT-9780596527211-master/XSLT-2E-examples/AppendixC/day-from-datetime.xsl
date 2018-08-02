<?xml version="1.0"?>
<!-- day-from-datetime.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Extracting the day from an xs:dateTime:</xsl:text>
    <xsl:variable name="currentDateTime" as="xs:dateTime" 
      select="current-dateTime()"/>
    <xsl:text>&#xA;&#xA;The current date and time is: </xsl:text>
    <xsl:value-of select="$currentDateTime"/>

    <xsl:text>&#xA;&#xA;  The current day: </xsl:text>
    <xsl:value-of select="day-from-dateTime($currentDateTime)"/>
    <xsl:text>&#xA;    In words: </xsl:text>
    <xsl:value-of select="format-dateTime($currentDateTime, '[DWw]')"/>
    <xsl:text>&#xA;    In German words: </xsl:text>
    <xsl:value-of 
      select="format-dateTime($currentDateTime, '[Dw]', 'de', (), ())"/>
    <xsl:text>&#xA;    It's the </xsl:text>
    <xsl:value-of select="format-dateTime($currentDateTime, '[dwo]')"/>
    <xsl:text> day of the year.</xsl:text>
  </xsl:template>

</xsl:stylesheet>
