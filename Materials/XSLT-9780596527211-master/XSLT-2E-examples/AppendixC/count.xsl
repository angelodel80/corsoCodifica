<?xml version="1.0"?>
<!-- count.xsl -->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Tests of the count() function:&#xA;&#xA;</xsl:text>

    <xsl:text>  Our store sells </xsl:text>
    <xsl:value-of select="count(/report/brand)"/>
    <xsl:text> different brands of chocolate.</xsl:text>
    <xsl:text>&#xA;&#xA;  For the last month, </xsl:text>
    <xsl:value-of select="count(/report/brand[units > 20000])"/>
    <xsl:text> brand(s) sold more than 20,000 units,</xsl:text>
    <xsl:text>&#xA;    and all but </xsl:text>
    <xsl:value-of select="count(/report/brand[units &lt; 10000])"/>
    <xsl:text> brand(s) sold 10,000 units or more.</xsl:text>

    <xsl:text>&#xA;&#xA;  Here are the brands we sell: </xsl:text>
    <xsl:for-each select="/report/brand">
      <xsl:text>&#xA;    Brand </xsl:text>
      <xsl:value-of select="position()"/>
      <xsl:text> of </xsl:text>
      <xsl:value-of select="count(/report/brand)"/>
      <xsl:text>: </xsl:text>
      <xsl:value-of select="name"/>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
