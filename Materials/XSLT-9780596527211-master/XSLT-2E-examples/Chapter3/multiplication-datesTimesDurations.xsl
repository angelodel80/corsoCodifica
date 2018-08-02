<?xml version="1.0"?>
<!-- multiplication-datesTimesDurations.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:variable name="yMD1" as="xs:yearMonthDuration"
    select="xs:yearMonthDuration('P1Y8M')"/>
  <xsl:variable name="dTD1" as="xs:dayTimeDuration"
    select="xs:dayTimeDuration('P24DT08H00M00S')"/>

  <xsl:template match="/">
    <xsl:text>More tests of multiplication in XPath 2.0:</xsl:text>
    <xsl:text>&#xA;&#xA;  A xs:yearMonthDuration multiplied </xsl:text>
    <xsl:text>by a number:&#xA;    </xsl:text>
    <xsl:value-of select="($yMD1, '* 3 =', $yMD1 * 3)"/>
    <xsl:text>&#xA;&#xA;  A xs:dayTimeDuration multiplied </xsl:text>
    <xsl:text>by a number:&#xA;    </xsl:text>
    <xsl:value-of select="($dTD1, '* 10.5 =', $dTD1 * 10.5)"/>
  </xsl:template>
</xsl:stylesheet>
