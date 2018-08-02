<?xml version="1.0"?>
<!-- hours-from-duration.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Extracting the hours component from durations:</xsl:text>

    <xsl:variable name="sampleDuration" as="xs:duration"
      select="xs:duration('P3Y8M2DT4H23M12.2S')"/>
    <xsl:variable name="sampleYearMonthDuration" as="xs:yearMonthDuration"
      select="xs:yearMonthDuration('P3Y8M')"/>
    <xsl:variable name="sampleDayTimeDuration" as="xs:dayTimeDuration"
      select="xs:dayTimeDuration('P2DT4H23M12.2S')"/>

    <xsl:text>&#xA;&#xA;  A sample xs:duration: </xsl:text>
    <xsl:value-of select="$sampleDuration"/>
    <xsl:text>&#xA;    The hours component of this duration is </xsl:text>
    <xsl:value-of select="hours-from-duration($sampleDuration)"/>
    <xsl:text>.</xsl:text>

    <xsl:text>&#xA;&#xA;  A sample xs:yearMonthDuration: </xsl:text>
    <xsl:value-of select="$sampleYearMonthDuration"/>
    <xsl:text>&#xA;    The hours component of this duration is </xsl:text>
    <xsl:value-of select="hours-from-duration($sampleYearMonthDuration)"/>
    <xsl:text>.</xsl:text>

    <xsl:text>&#xA;&#xA;  A sample xs:dayTimeDuration: </xsl:text>
    <xsl:value-of select="$sampleDayTimeDuration"/>
    <xsl:text>&#xA;    The hours component of this duration is </xsl:text>
    <xsl:value-of select="hours-from-duration($sampleDayTimeDuration)"/>
    <xsl:text>.</xsl:text>
  </xsl:template>

</xsl:stylesheet>
