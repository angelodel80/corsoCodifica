<?xml version="1.0"?>
<!-- hours-from-time.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Extracting the hours component from an xs:time:</xsl:text>
    <xsl:variable name="currentTime" as="xs:time" select="current-time()"/>
    <xsl:text>&#xA;&#xA;  The current time is: </xsl:text>
    <xsl:value-of select="$currentTime"/>

    <xsl:text>&#xA;&#xA;  The current hour is: </xsl:text>
    <xsl:value-of select="hours-from-time($currentTime)"/>
    <xsl:text>&#xA;    Also known as </xsl:text>
    <xsl:value-of select="format-time($currentTime, '[h] [Pn]')"/>
    <xsl:text>, </xsl:text>
    <xsl:value-of select="format-time($currentTime, '[H] [ZN]')"/>
    <xsl:text>, or </xsl:text>
    <xsl:value-of select="format-time($currentTime, '[H] [z]')"/>
  </xsl:template>

</xsl:stylesheet>
