<?xml version="1.0"?>
<!-- sum.xsl -->
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;A test of the sum() function:&#xA;&#xA;</xsl:text>

    <xsl:text>  Total chocolate bar sales this quarter: </xsl:text>
    <xsl:value-of 
      select="format-number(sum(/report/brand/units), '###,###')"/>
  </xsl:template>

</xsl:stylesheet>
