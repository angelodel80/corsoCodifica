<?xml version="1.0"?>
<!-- adjust-time-to-timezone.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:variable name="gmt" select="xs:dayTimeDuration('PT0H')"/>
    <xsl:variable name="est" select="xs:dayTimeDuration('-PT5H')"/>
    <xsl:variable name="cst" select="xs:dayTimeDuration('-PT6H')"/>
    <xsl:variable name="minusTen" select="xs:dayTimeDuration('-PT10H')"/>

    <xsl:variable name="LilysBirthday" as="xs:time"
      select="xs:time('00:43:00-05:00')"/>
    <xsl:variable name="format" 
      select="'[h1]:[m01]:[s01] [P]'"/>

    <xsl:text>&#xA;Here are some tests of the </xsl:text>
    <xsl:text>adjust-time-to-timezone() function:&#xA;</xsl:text>

    <xsl:text>&#xA;  My daughter was born at &#x9;</xsl:text>
    <xsl:value-of 
      select="format-time($LilysBirthday, $format)"/>
    <xsl:text>&#xA;    adjusted to GMT: &#x9;&#x9;</xsl:text>
    <xsl:value-of 
      select="format-time(
              adjust-time-to-timezone($LilysBirthday, $gmt), 
              $format)"/> 

    <xsl:text>&#xA;    adjusted to EST: &#x9;&#x9;</xsl:text>
    <xsl:value-of 
      select="format-time
              (adjust-time-to-timezone($LilysBirthday, $est), 
              $format)"/>

    <xsl:text>&#xA;    adjusted to CST: &#x9;&#x9;</xsl:text>
    <xsl:value-of 
      select="format-time
              (adjust-time-to-timezone($LilysBirthday, $cst), 
              $format)"/>

    <xsl:text>&#xA;&#xA;  </xsl:text>
    <xsl:text>The current time in the default timezone is: </xsl:text>
    <xsl:text>&#xA;  &#x9;&#x9;&#x9;&#x9;</xsl:text>
    <xsl:value-of 
      select="format-time(
              adjust-time-to-timezone(current-time()), 
              $format)"/>

    <xsl:text>&#xA;    adjusted to GMT: &#x9;&#x9;</xsl:text>
    <xsl:value-of 
      select="format-time
              (adjust-time-to-timezone(current-time(), $gmt), 
              $format)"/>

    <xsl:text>&#xA;    adjusted to GMT-10: &#x9;</xsl:text>
    <xsl:value-of 
      select="format-time(
              adjust-time-to-timezone(current-time(), $minusTen), 
              $format)"/>
  </xsl:template>

</xsl:stylesheet>
