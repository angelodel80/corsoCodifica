<?xml version="1.0"?>
<!-- format-number.xsl -->
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:decimal-format name="f1"
    decimal-separator=":"
    grouping-separator="/"/>

  <xsl:decimal-format name="f9"
    infinity="Really, really big"
    NaN="[not a number]"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Tests of the format-number() </xsl:text>
    <xsl:text>function:&#xA;&#xA;</xsl:text>

    <xsl:text>  1. format-number(528.3, '#.#;-#.#')=</xsl:text>
    <xsl:value-of 
      select="format-number(528.3, '#.#;-#.#')"/>
    <xsl:text>&#xA;  2. format-number(528.3, </xsl:text>
    <xsl:text>'0,000.00;-0,000.00')=</xsl:text>
    <xsl:value-of 
      select="format-number(528.3, '0,000.00;-0,000.00')"/>
    <xsl:text>&#xA;  3. format-number(-23528.3, </xsl:text>
    <xsl:text>'$#,###.00;($#,###.00)')=</xsl:text>
    <xsl:value-of 
      select="format-number(-23528.3, '$#,###.00;($#,###.00)')"/>
    <xsl:text>&#xA;  4. format-number(1528.3, </xsl:text>
    <xsl:text>'#/###:00', 'f1')=</xsl:text>
    <xsl:value-of 
      select="format-number(1528.3, '#/###:00;-#/###:00', 'f1')"/>
    <xsl:text>&#xA;  5. format-number(1 div 0, </xsl:text>
    <xsl:text>'###,###.00', 'f2')=</xsl:text>
    <xsl:value-of 
      select="format-number(1 div 0, '###,###.00', 'f2')"/>
    <xsl:text>&#xA;  6. format-number(blue div orange, </xsl:text>
    <xsl:text>'#.##', 'f2')=</xsl:text>
    <xsl:value-of 
      select="format-number(blue div orange, '#.##', 'f2')"/>
    <xsl:text>&#xA;&#xA;  </xsl:text>

    <xsl:value-of select="report/title"/>
    <xsl:text> - </xsl:text>
    <xsl:value-of select="report/@month"/>
    <xsl:text>/</xsl:text>
    <xsl:value-of select="report/@year"/>
    <xsl:text>&#xA;&#xA;</xsl:text>

    <xsl:variable name="totalSales" 
      select="sum(/report/brand/units)"/>

    <xsl:for-each select="report/brand">
      <xsl:text>    </xsl:text>
      <xsl:value-of select="name"/>
      <xsl:text> - </xsl:text>
      <xsl:value-of select="format-number(units, '##,###')"/>
      <xsl:text> bars sold, </xsl:text>
      <xsl:value-of 
        select="format-number(units div $totalSales, '##%')"/>
      <xsl:text> of all sales.&#xA;</xsl:text>
    </xsl:for-each> 

    <xsl:text>&#xA;  Total sales: </xsl:text>
    <xsl:value-of 
      select="format-number(sum(/report/brand/units), '##,###')"/>
  </xsl:template>

</xsl:stylesheet>
