<?xml version="1.0"?>
<!-- addition-datesTimesDurations.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:auth="http://www.authors.com/">

  <xsl:output method="text"/>

  <xsl:variable name="yMD1" as="xs:yearMonthDuration"
    select="xs:yearMonthDuration('P1Y8M')"/>
  <xsl:variable name="yMD2" as="xs:yearMonthDuration"
    select="xs:yearMonthDuration('P2Y7M')"/>
  <xsl:variable name="dTD1" as="xs:dayTimeDuration"
    select="xs:dayTimeDuration('P5DT9H23M12S')"/>
  <xsl:variable name="dTD2" as="xs:dayTimeDuration"
    select="xs:dayTimeDuration('P3DT16H12M17S')"/>
  <xsl:variable name="dT" as="xs:dateTime"
    select="xs:dateTime('1995-04-21T00:47:00')"/>
  <xsl:variable name="d" as="xs:date" 
    select="xs:date('1995-04-21')"/>
  <xsl:variable name="t" as="xs:time" 
    select="xs:time('17:03:00')"/>

  <xsl:template match="/">
    <xsl:text>More tests of addition in XPath 2.0:</xsl:text>
    <xsl:text>&#xA;&#xA;  Two xs:yearMonthDurations:&#xA;    </xsl:text>
    <xsl:value-of select="($yMD1, '+', $yMD2, '=', $yMD1 + $yMD2)"/>
    <xsl:text>&#xA;&#xA;  Two xs:dayTimeDurations:&#xA;    </xsl:text>
    <xsl:value-of select="($dTD1, '+', $dTD2, '=', $dTD1 + $dTD2)"/>
    <xsl:text>&#xA;&#xA;  An xs:yearMonthDuration and an </xsl:text>
    <xsl:text>xs:dateTime:&#xA;    </xsl:text>
    <xsl:value-of select="($dT, '+', $yMD1, '=', $dT + $yMD1)"/>
    <xsl:text>&#xA;&#xA;  An xs:dayTimeDuration and an </xsl:text>
    <xsl:text>xs:dateTime:&#xA;    </xsl:text>
    <xsl:value-of select="($dT, '+', $dTD1, '=', $dT + $dTD1)"/>
    <xsl:text>&#xA;&#xA;  An xs:yearMonthDuration and an </xsl:text>
    <xsl:text>xs:date:&#xA;    </xsl:text>
    <xsl:value-of select="($d, '+', $yMD1, '=', $d + $yMD1)"/>
    <xsl:text>&#xA;&#xA;  An xs:dayTimeDuration and an </xsl:text>
    <xsl:text>xs:date:&#xA;    </xsl:text>
    <xsl:value-of select="($d, '+', $dTD1, '=', $d + $dTD1)"/>
    <xsl:text>&#xA;&#xA;  An xs:dayTimeDuration and an </xsl:text>
    <xsl:text>xs:time:&#xA;    </xsl:text>
    <xsl:value-of select="($t, '+', $dTD1, '=', $t + $dTD1)"/>
    <xsl:text>xs:time:&#xA;    </xsl:text>
    <xsl:value-of select="/sonnet/auth:author/year-of-death - 
                          /sonnet/auth:author/year-of-birth"/>
    <xsl:text>xs:time:&#xA;    </xsl:text>
    <xsl:value-of select="'1616' - '1564'"/>
  </xsl:template>
</xsl:stylesheet>
