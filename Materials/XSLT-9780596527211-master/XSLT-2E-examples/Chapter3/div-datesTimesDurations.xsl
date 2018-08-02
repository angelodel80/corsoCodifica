<?xml version="1.0"?>
<!-- div-datesTimesDurations.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:variable name="yMD1" as="xs:yearMonthDuration"
    select="xs:yearMonthDuration('P1Y8M')"/>
  <xsl:variable name="yMD2" as="xs:yearMonthDuration"
    select="xs:yearMonthDuration('P0Y5M')"/>
  <xsl:variable name="dTD1" as="xs:dayTimeDuration"
    select="xs:dayTimeDuration('P24DT08H00M00S')"/>
  <xsl:variable name="dTD2" as="xs:dayTimeDuration"
    select="xs:dayTimeDuration('P0DT4H00M00S')"/>

  <xsl:template match="/">
    <xsl:text>More tests of division in XPath 2.0:</xsl:text>
    <xsl:text>&#xA;&#xA;  A xs:yearMonthDuration divided </xsl:text>
    <xsl:text>by a number:&#xA;    </xsl:text>
    <xsl:value-of select="($yMD1, 'div 4 =', $yMD1 div 4)"/>
    <xsl:text>&#xA;&#xA;  One xs:yearMonthDuration divided </xsl:text>
    <xsl:text>by another:&#xA;    </xsl:text>
    <xsl:value-of select="($yMD1, 'div', $yMD2, '=', $yMD1 div $yMD2)"/>
    <xsl:text>&#xA;&#xA;  A xs:dayTimeDuration divided </xsl:text>
    <xsl:text>by a number:&#xA;    </xsl:text>
    <xsl:value-of select="($dTD1, 'div 4.5 =', $dTD1 div 4.5)"/>
    <xsl:text>&#xA;&#xA;  One xs:dayTimeDuration divided </xsl:text>
    <xsl:text>by another:&#xA;    </xsl:text>
    <xsl:value-of select="($dTD1, 'div', $dTD2, '=', $dTD1 div $dTD2)"/>
  </xsl:template>
</xsl:stylesheet>
