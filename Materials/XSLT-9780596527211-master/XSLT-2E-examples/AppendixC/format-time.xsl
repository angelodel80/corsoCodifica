<?xml version="1.0"?>
<!-- format-time.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Tests of the format-time() function:&#xA;</xsl:text>

    <xsl:variable name="now" select="current-time()"/>
    <xsl:text>&#xA;  The current date and time is: </xsl:text>
    <xsl:value-of select="$now"/>
    <xsl:variable name="longFormat"
      select="concat('It''s [h1]:[m11]:[s11] [P] ',
              'in the [zWw] time zone.')"/>

    <xsl:text>&#xA;&#xA;    The hour (24-hour clock) - </xsl:text>
    <xsl:text>format-time($now, '[H]'): </xsl:text>
    <xsl:value-of select="format-time($now, '[H]')"/>
    <xsl:text>&#xA;&#xA;    The minutes - format-time(</xsl:text>
    <xsl:text>$now, '[m11]'): </xsl:text>
    <xsl:value-of select="format-time($now, '[m11]')"/>
    <xsl:text>&#xA;&#xA;    Using format-time(</xsl:text>
    <xsl:text>$now, '[mWwo]'): &#xA;      It's the </xsl:text>
    <xsl:value-of select="format-time($now, '[mWwo]')"/>
    <xsl:text> minute of the hour.</xsl:text>
    <xsl:text>&#xA;&#xA;    The time - format-time(</xsl:text>
    <xsl:text>$now, '[H]:[m11]'): &#xA;      </xsl:text>
    <xsl:value-of 
      select="format-time($now, '[H]:[m11]')"/>

    <xsl:text>&#xA;&#xA;  The grand finale:</xsl:text>
    <xsl:text>&#xA;    </xsl:text>
    <xsl:value-of select="format-time($now, $longFormat)"/> 
  </xsl:template>

</xsl:stylesheet>
