<?xml version="1.0"?>
<!-- format-date.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Tests of the format-date() function:&#xA;</xsl:text>

    <xsl:variable name="today" select="current-date()"/>
    <xsl:text>&#xA;  The current date is: </xsl:text>
    <xsl:value-of select="$today"/>
    <xsl:variable name="longFormat"
      select="concat('Today is [FNn], [MNn] [D1], [Y], &#xA;      ',
              'the [D1o] day of the [W1o] week of the year,',
              '&#xA;      the [w1o] week of the month,',
              '&#xA;      in the [zWw] time zone.')"/>

    <xsl:text>&#xA;&#xA;    The year - format-date</xsl:text>
    <xsl:text>($today, '[Y]'): </xsl:text>
    <xsl:value-of select="format-date($today, '[Y1111]')"/>
    <xsl:text>&#xA;&#xA;    The two-digit year - </xsl:text>
    <xsl:text>format-date($today, '[Y11]'): </xsl:text>
    <xsl:value-of select="format-date($today, '[Y11]')"/>
    <xsl:text>&#xA;&#xA;    The month - format-date(</xsl:text>
    <xsl:text>$today, '[M11]'): </xsl:text>
    <xsl:value-of select="format-date($today, '[M11]')"/>
    <xsl:text>&#xA;&#xA;    The month in German words - </xsl:text>
    <xsl:text>format-date($today, '[MWw]', 'de', (), ()): </xsl:text>
    <xsl:text>&#xA;      </xsl:text>
    <xsl:value-of 
      select="format-date($today, '[MWw]', 'de', (), ())"/>
    <xsl:text>&#xA;&#xA;    The day in words - format-date(</xsl:text>
    <xsl:text>$today, '[DWw]'): &#xA;      </xsl:text>
    <xsl:value-of select="format-date($today, '[DWw]')"/>
    <xsl:text>&#xA;&#xA;    The day in German words - </xsl:text>
    <xsl:text>format-date($today, '[Dw]', 'de', (), ()): </xsl:text>
    <xsl:text>&#xA;      </xsl:text>
    <xsl:value-of select="format-date($today, '[Dw]', 'de', (), ())"/>
    <xsl:text>&#xA;&#xA;    Using format-date($today, '[dwo]'):</xsl:text>
    <xsl:text>&#xA;      It's the </xsl:text>
    <xsl:value-of select="format-date($today, '[dwo]')"/>
    <xsl:text> day of the year.</xsl:text>
    <xsl:text>&#xA;&#xA;    Using format-date($today, '[d1o]'):</xsl:text>
    <xsl:text>&#xA;      It's the </xsl:text>
    <xsl:value-of select="format-date($today, '[d1o]')"/>
    <xsl:text> day of the year.</xsl:text>

    <xsl:text>&#xA;&#xA;  The grand finale:</xsl:text>
    <xsl:text>&#xA;    </xsl:text>
    <xsl:value-of select="format-date($today, $longFormat)"/>
  </xsl:template>

</xsl:stylesheet>
