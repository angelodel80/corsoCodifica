<?xml version="1.0"?>
<!-- max.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:variable name="seq1" select="(3, 5, 18)"/>
    <xsl:variable name="seq2" select="(3, 5, 48.273, 2.9e3)"/>

    <xsl:variable name="value1" as="xs:integer" select="42"/>
    <xsl:variable name="value2" as="xs:double" select="2718.28E-3"/>
    <xsl:variable name="value3" as="xs:float" select="98.6"/>
    <xsl:variable name="value4" as="xs:decimal" select="2.54"/>
    <xsl:variable name="seq3" 
      select="($value1, $value2, $value3, $value4)"/>

    <xsl:variable name="seq4" 
      select="(xs:yearMonthDuration('P3Y8M'), 
              xs:yearMonthDuration('P4Y2M'), 
              xs:yearMonthDuration('P6Y4M'))"/>
    <xsl:variable name="seq5"
      select="(xs:dayTimeDuration('P2DT4H23M12.2S'),
              xs:dayTimeDuration('P3DT8H17M'),
              xs:dayTimeDuration('P3D'))"/>
    <xsl:variable name="seq6"
      select="('red', 'white', 'blue')"/>

    <xsl:text>&#xA;Here are some tests of the max() function:&#xA;</xsl:text>

    <xsl:text>&#xA;  max(</xsl:text>
    <xsl:value-of select="$seq1" separator=", "/>
    <xsl:text>) = </xsl:text>
    <xsl:value-of select="format-number(max($seq1), '#.###')"/>

    <xsl:text>&#xA;&#xA;  max(</xsl:text>
    <xsl:value-of select="$seq2" separator=", "/>
    <xsl:text>) = </xsl:text>
    <xsl:value-of select="format-number(max($seq2), '#.###')"/>

    <xsl:text>&#xA;&#xA;  max(</xsl:text>
    <xsl:value-of select="$seq3" separator=", "/>
    <xsl:text>) = </xsl:text>
    <xsl:value-of select="format-number(max($seq3), '#.###')"/>

    <xsl:text>&#xA;&#xA;  max(</xsl:text>
    <xsl:value-of select="$seq4" separator=", "/>
    <xsl:text>) = </xsl:text>
    <xsl:value-of select="max($seq4)"/>

    <xsl:text>&#xA;&#xA;    In text, the maximum of</xsl:text> 
    <xsl:for-each select="$seq4">
      <xsl:text>&#xA;      </xsl:text>
      <xsl:value-of select="years-from-duration(.)"/>
      <xsl:text> years and </xsl:text>
      <xsl:value-of select="months-from-duration(.)"/>
      <xsl:text> months (</xsl:text>
      <xsl:value-of select="."/>
      <xsl:text>)</xsl:text>
    </xsl:for-each>

    <xsl:text>&#xA;    is </xsl:text>
    <xsl:value-of select="years-from-duration(max($seq4))"/>
    <xsl:text> years and </xsl:text>
    <xsl:value-of select="months-from-duration(max($seq4))"/>
    <xsl:text> months (</xsl:text>
    <xsl:value-of select="max($seq4)"/>
    <xsl:text>).</xsl:text>

    <xsl:text>&#xA;&#xA;  max(</xsl:text>
    <xsl:value-of select="$seq5" separator=", "/>
    <xsl:text>) = </xsl:text>
    <xsl:variable name="max5" select="max($seq5)"/>
    <xsl:value-of select="$max5"/>

    <xsl:text>&#xA;&#xA;    In text, the maximum of</xsl:text>
    <xsl:for-each select="$seq5">
      <xsl:text>&#xA;      </xsl:text>
      <xsl:value-of select="days-from-duration(.)"/>
      <xsl:text> days, </xsl:text>
      <xsl:value-of select="hours-from-duration(.)"/>
      <xsl:text> hours, </xsl:text>
      <xsl:value-of select="minutes-from-duration(.)"/>
      <xsl:text> minutes and </xsl:text>
      <xsl:value-of 
        select="format-number(seconds-from-duration(.), '#.##')"/>
      <xsl:text> seconds (</xsl:text>
      <xsl:value-of select="."/>
      <xsl:text>)</xsl:text>
    </xsl:for-each>

    <xsl:text>&#xA;    is </xsl:text>
    <xsl:value-of select="days-from-duration($max5)"/>
    <xsl:text> days, </xsl:text>
    <xsl:value-of select="hours-from-duration($max5)"/>
    <xsl:text> hours, </xsl:text>
    <xsl:value-of select="minutes-from-duration($max5)"/>
    <xsl:text> minutes and </xsl:text>
    <xsl:value-of 
      select="format-number(seconds-from-duration($max5), '#.##')"/>
    <xsl:text> seconds.</xsl:text>
    
    <xsl:text>&#xA;&#xA;  max(</xsl:text>
    <xsl:value-of select="$seq6" separator=", "/>
    <xsl:text>) = </xsl:text>
    <xsl:value-of select="max($seq6)"/>

  </xsl:template>

</xsl:stylesheet>
