<?xml version="1.0"?>
<!-- timezone-from-time.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Extracting the timezone from an xs:time:</xsl:text>
    <xsl:variable name="currentTime" as="xs:time" select="current-time()"/>
    <xsl:text>&#xA;&#xA;  The current time is: </xsl:text>
    <xsl:value-of select="$currentTime"/>

    <xsl:text>&#xA;&#xA;  The current timezone is: </xsl:text>
    <xsl:value-of select="timezone-from-time($currentTime)"/>
    <xsl:text>&#xA;    The timezone is also known as </xsl:text>
    <xsl:value-of select="format-time($currentTime, '[ZN]')"/>
  </xsl:template>

</xsl:stylesheet>
