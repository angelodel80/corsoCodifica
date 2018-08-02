<?xml version="1.0"?>
<!-- unparsed-text-available.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:output method="text"/>

  <xsl:template match="/">

    <xsl:text>&#xA;Here are some tests of the </xsl:text>
    <xsl:text>unparsed-text-available() function:</xsl:text>

    <xsl:text>&#xA;&#xA;  unparsed-text-available</xsl:text>
    <xsl:text>('header.html') = </xsl:text>
    <xsl:value-of 
      select="unparsed-text-available('header.html')"/>

    <xsl:text>&#xA;&#xA;  unparsed-text-available</xsl:text>
    <xsl:text>('disclaimer.html') = </xsl:text>
    <xsl:value-of 
      select="unparsed-text-available('disclaimer.html')"/>

    <xsl:text>&#xA;&#xA;  unparsed-text-available</xsl:text>
    <xsl:text>('footer.html') = </xsl:text>
    <xsl:value-of 
      select="unparsed-text-available('footer.html')"/>

  </xsl:template>

</xsl:stylesheet>
