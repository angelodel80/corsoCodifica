<?xml version="1.0" encoding="ISO-8859-1" ?>
<!-- decimal-format.xsl -->
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:decimal-format name="f1"
    decimal-separator=":"
    grouping-separator="/"/>

  <xsl:decimal-format name="f2"
    infinity="Really, really big"
    NaN="[not a number]"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Tests of the &lt;decimal-format&gt; element:</xsl:text>

    <xsl:text>&#xA;&#xA;    format-number(1528.3, '#/###:00', 'f1')=</xsl:text>
    <xsl:value-of select="format-number(1528.3, '#/###:00;-#/###:00', 'f1')"/>
    <xsl:text>&#xA;    format-number(1 div 0, '###,###.00', 'f2')=</xsl:text>
    <xsl:value-of select="format-number(1 div 0, '###,###.00', 'f2')"/>
    <xsl:text>&#xA;    format-number(blue div orange, '#.##', 'f2')=</xsl:text>
    <xsl:value-of select="format-number(blue div orange, '#.##', 'f2')"/>
    <xsl:text>&#xA;&#xA;***************************************</xsl:text>
    <xsl:text>&#xA;Sales report for </xsl:text>
    <xsl:value-of select="/report/@month"/>
    <xsl:text>/</xsl:text>
    <xsl:value-of select="/report/@year"/>
    <xsl:text>&#xA;&#xA;</xsl:text>
    <xsl:variable name="totalSales" select="sum(/report/brand/units)"/>
    <xsl:for-each select="report/brand">
      <xsl:value-of select="name"/>
      <xsl:text>: &#xA;    </xsl:text>
      <xsl:value-of select="format-number(units, '##,###')"/>
      <xsl:text> bars sold, </xsl:text>
      <xsl:value-of select="format-number(units div $totalSales, '##%')"/>
      <xsl:text> of all sales.</xsl:text>
      <xsl:text>&#xA;</xsl:text>
      <xsl:text>&#xA;</xsl:text>
    </xsl:for-each> 
    <xsl:text>Total sales: </xsl:text>
    <xsl:value-of select="format-number($totalSales, '##,###')"/>
    <xsl:text> bars.&#xA;</xsl:text>
  </xsl:template>

</xsl:stylesheet>
