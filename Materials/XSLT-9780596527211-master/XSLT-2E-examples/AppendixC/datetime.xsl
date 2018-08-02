<?xml version="1.0"?>
<!-- datetime.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Creating an xs:dateTime with an </xsl:text>
    <xsl:text>xs:date and xs:time:</xsl:text>
    <xsl:variable name="currentDate" as="xs:date" select="current-date()"/>
    <xsl:variable name="currentTime" as="xs:time" select="current-time()"/>
    <xsl:text>&#xA;&#xA;  The current date is: </xsl:text>
    <xsl:value-of select="$currentDate"/>
    <xsl:text>&#xA;&#xA;  The current time is: </xsl:text>
    <xsl:value-of select="$currentTime"/>

    <xsl:variable name="currentDateTime" 
      select="dateTime($currentDate, $currentTime)"/>

    <xsl:text>&#xA;&#xA;  The new xs:dateTime is: </xsl:text>
    <xsl:value-of select="$currentDateTime"/>
    <xsl:text>&#xA;&#xA;  The new xs:dateTime value can be </xsl:text>
    <xsl:text>written as &#xA;    </xsl:text>
    <xsl:value-of 
      select="format-dateTime($currentDateTime, 
              '[h]:[m01] [Pn] on [FNn], the [D1o] of [MNn], [Y0001]')"/>
  </xsl:template>

</xsl:stylesheet>
