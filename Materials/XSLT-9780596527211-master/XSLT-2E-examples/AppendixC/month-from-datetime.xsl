<?xml version="1.0"?>
<!-- month-from-datetime.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Extracting the month from an xs:dateTime:</xsl:text>
    <xsl:variable name="currentDateTime" as="xs:dateTime" 
      select="current-dateTime()"/>
    <xsl:text>&#xA;&#xA;The current date and time is: </xsl:text>
    <xsl:value-of select="$currentDateTime"/>

    <xsl:text>&#xA;&#xA;  The current month: </xsl:text>
    <xsl:value-of select="month-from-dateTime($currentDateTime)"/>
    <xsl:text>&#xA;    In English: </xsl:text>
    <xsl:value-of select="format-dateTime($currentDateTime, '[MNn]')"/>
    <xsl:text>&#xA;    In German: </xsl:text>
    <xsl:value-of select="format-dateTime($currentDateTime, '[MNn]', 'de', (), ())"/>
    <xsl:text>&#xA;    It's the </xsl:text>
    <xsl:value-of select="format-dateTime($currentDateTime, '[M1o]')"/>
    <xsl:text> month of the year.</xsl:text>
  </xsl:template>

</xsl:stylesheet>
