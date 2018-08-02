<?xml version="1.0"?>
<!-- count2.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Tests of the count() function:&#xA;&#xA;</xsl:text>

    <xsl:variable name="salesFigures" as="xs:integer*">
      <xsl:sequence select="/report/brand/units"/> 
    </xsl:variable>

    <xsl:text>  Our store sells </xsl:text>
    <xsl:value-of select="count($salesFigures)"/>
    <xsl:text> different brands of chocolate.</xsl:text>
    <xsl:text>&#xA;&#xA;  For the last month, </xsl:text>
    <xsl:value-of select="count($salesFigures[. > 20000])"/>
    <xsl:text> brand(s) sold more than 20,000 units,</xsl:text>
    <xsl:text>&#xA;    and all but </xsl:text>
    <xsl:value-of select="count($salesFigures[. &lt; 10000])"/>
    <xsl:text> brand(s) sold 10,000 units or more.</xsl:text>
  </xsl:template>

</xsl:stylesheet>
