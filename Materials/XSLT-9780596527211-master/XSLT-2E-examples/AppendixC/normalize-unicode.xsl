<?xml version="1.0"?>
<!-- normalize-unicode.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Here is a test of the normalize-</xsl:text>
    <xsl:text>unicode() function:&#xA;</xsl:text>

    <xsl:text>&#xA;  compare('&amp;#xC5', </xsl:text>
    <xsl:text>'&amp;#x41;&amp;#x30A;') = </xsl:text>
    <xsl:value-of select="compare('&#xC5;', '&#x41;&#x30A;')"/>

    <xsl:text>&#xA;&#xA;  compare(normalize-unicode</xsl:text>
    <xsl:text>('&amp;#xC5'),&#xA;          normalize-unicode(</xsl:text>
    <xsl:text>'&amp;#x41;&amp;#x30A;')) = </xsl:text>
    <xsl:value-of 
      select="compare(normalize-unicode('&#xC5;'), 
              normalize-unicode('&#x41;&#x30A;'))"/>
  </xsl:template>

</xsl:stylesheet>
