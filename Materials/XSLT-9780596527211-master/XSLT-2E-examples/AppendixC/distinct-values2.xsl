<?xml version="1.0"?>
<!-- distinct-values2.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Here are some tests of the </xsl:text>
    <xsl:text>distinct-values() </xsl:text>
    <xsl:text>function:&#xA;</xsl:text>

    <xsl:text>&#xA;  A sequence of xs:time values:</xsl:text>
    <xsl:variable name="timeSequence" as="xs:time*">
      <xsl:sequence 
        select="(xs:time('00:43:00-06:00'),
                 xs:time('01:43:00-05:00'),
                 xs:time('02:43:00'), 
                 xs:time('07:35:00'),
                 current-time())"/>
    </xsl:variable>

    <xsl:text>&#xA;&#xA;    </xsl:text>
    <xsl:value-of 
      select="distinct-values($timeSequence)" 
      separator="&#xA;    "/>

    <xsl:text>&#xA;&#xA;  A sequence of integer values:</xsl:text>
    <xsl:variable name="numberSequence" as="xs:integer*">
      <xsl:sequence select="(3, 8, (2 + 1), -0, 0)"/>
    </xsl:variable>

    <xsl:text>&#xA;    </xsl:text>
    <xsl:value-of 
      select="distinct-values($numberSequence)" 
      separator=", "/>
  </xsl:template>

</xsl:stylesheet>
