<?xml version="1.0"?>
<!-- seconds-from-time.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Extracting the seconds component from an xs:time:</xsl:text>
    <xsl:variable name="currentTime" as="xs:time" select="current-time()"/>
    <xsl:text>&#xA;&#xA;  The current time is: </xsl:text>
    <xsl:value-of select="$currentTime"/>

    <xsl:text>&#xA;&#xA;  The current seconds are: </xsl:text>
    <xsl:value-of select="seconds-from-time($currentTime)"/>
    <xsl:text>, &#xA;    usually written as a whole number (</xsl:text>
    <xsl:value-of select="format-time($currentTime, '[s01]')"/>
    <xsl:text>)</xsl:text>
  </xsl:template>

</xsl:stylesheet>
