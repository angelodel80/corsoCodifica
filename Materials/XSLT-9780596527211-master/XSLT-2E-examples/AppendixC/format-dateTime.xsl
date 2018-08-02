<?xml version="1.0"?>
<!-- format-dateTime.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Tests of the format-dateTime() function:&#xA;</xsl:text>

    <xsl:variable name="today" select="current-dateTime()"/>
    <xsl:text>&#xA;  The current date and time is: </xsl:text>
    <xsl:value-of select="$today"/>
    <xsl:variable name="longFormat"
      select="concat('It''s [h1]:[m11] [P] on ',
              '[FNn], [MNn] [D1], [Y], &#xA;      ',
              'the [D1o] day of the [W1o] week of the year,',
              '&#xA;      the [w1o] week of the month,',
              '&#xA;      in the [zWw] time zone.')"/>

    <xsl:text>&#xA;&#xA;    The year - format-dateTime</xsl:text>
    <xsl:text>($today, '[Y]'): </xsl:text>
    <xsl:value-of select="format-dateTime($today, '[Y]')"/>
    <xsl:text>&#xA;&#xA;    The hour (12-hour clock) - </xsl:text>
    <xsl:text>format-dateTime($today, '[h] [PN]'): </xsl:text>
    <xsl:value-of select="format-dateTime($today, '[h] [PN]')"/>
    <xsl:text>&#xA;&#xA;    The minutes - format-dateTime(</xsl:text>
    <xsl:text>$today, '[m11]'): </xsl:text>
    <xsl:value-of select="format-dateTime($today, '[m11]')"/>
    <xsl:text>&#xA;&#xA;    The seconds - format-dateTime(</xsl:text>
    <xsl:text>$today, '[s11].[f1111]): </xsl:text>
    <xsl:value-of select="format-dateTime($today, '[s11].[f1111]')"/>
    <xsl:text>&#xA;&#xA;    The complete time - format-dateTime(</xsl:text>
    <xsl:text>$today, '[h]:[m11]:[s11] [P]'): &#xA;      </xsl:text>
    <xsl:value-of 
      select="format-dateTime($today, '[h]:[m11]:[s11] [P]')"/>
    <xsl:text>&#xA;&#xA;    The day in words - format-dateTime(</xsl:text>
    <xsl:text>$today, '[FNn]'): &#xA;      </xsl:text>
    <xsl:value-of select="format-dateTime($today, '[FWw]')"/>
    <xsl:text>&#xA;</xsl:text>

    <xsl:text>&#xA;&#xA;  The grand finale:</xsl:text>
    <xsl:text>&#xA;    </xsl:text>
    <xsl:value-of select="format-dateTime($today, $longFormat)"/>
  </xsl:template>

</xsl:stylesheet>
