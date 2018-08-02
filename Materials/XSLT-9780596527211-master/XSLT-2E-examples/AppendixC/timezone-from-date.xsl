<?xml version="1.0"?>
<!-- timezone-from-date.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Extracting the timezone from an xs:date:</xsl:text>
    <xsl:variable name="currentDate" as="xs:date" select="current-date()"/>
    <xsl:text>&#xA;&#xA;  The current date is: </xsl:text>
    <xsl:value-of select="$currentDate"/>

    <xsl:text>&#xA;&#xA;  The current timezone is: </xsl:text>
    <xsl:value-of select="timezone-from-date($currentDate)"/>
    <xsl:text>&#xA;    The timezone is also known as </xsl:text>
    <xsl:value-of select="format-date($currentDate, '[ZN]')"/>
  </xsl:template>

</xsl:stylesheet>
