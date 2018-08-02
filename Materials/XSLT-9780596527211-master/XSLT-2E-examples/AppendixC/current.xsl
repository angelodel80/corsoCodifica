<?xml version="1.0"?>
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:months="http://www.months.com">

  <months:name sequence="01">January</months:name>
  <months:name sequence="02">February</months:name>
  <months:name sequence="03">March</months:name>
  <months:name sequence="04">April</months:name>
  <months:name sequence="05">May</months:name>
  <months:name sequence="06">June</months:name>
  <months:name sequence="07">July</months:name>
  <months:name sequence="08">August</months:name>
  <months:name sequence="09">September</months:name>
  <months:name sequence="10">October</months:name>
  <months:name sequence="11">November</months:name>
  <months:name sequence="12">December</months:name>

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Tests of the current() function:&#xA;</xsl:text>

    <xsl:text>&#xA;  Using the current() function:&#xA;</xsl:text>
    <xsl:text>&#xA;    Chocolate bar sales for </xsl:text>
    <xsl:value-of select="/report/@year"/>
    <xsl:text>: &#xA;</xsl:text>
    
    <xsl:for-each select="/report/sales">
      <xsl:text>&#xA;      </xsl:text>
      <xsl:value-of 
        select="document('')/*/months:name[@sequence=current()/@month][1]"/>
      <xsl:text> - Total sales = </xsl:text>
      <xsl:value-of select="format-number(@total, '##,###')"/>
    </xsl:for-each>

    <xsl:text>&#xA;&#xA;  Without the current() function:&#xA;</xsl:text>
    <xsl:text>&#xA;    Chocolate bar sales for </xsl:text>
    <xsl:value-of select="/report/@year"/>
    <xsl:text>: &#xA;</xsl:text>

    <xsl:for-each select="/report/sales">
      <xsl:text>&#xA;      </xsl:text>
      <xsl:value-of 
        select="document('')/*/months:name[@sequence=./@month][1]"/>
      <xsl:text> - Total sales = </xsl:text>
      <xsl:value-of select="format-number(@total, '##,###')"/>
    </xsl:for-each>

    <xsl:text>&#xA;&#xA;  Another test without the current() </xsl:text>
    <xsl:text>function:&#xA;</xsl:text>
    <xsl:text>&#xA;    Chocolate bar sales for </xsl:text>
    <xsl:value-of select="/report/@year"/>
    <xsl:text>: &#xA;</xsl:text>

    <xsl:for-each select="/report/sales">
      <xsl:text>&#xA;      </xsl:text>
      <xsl:value-of 
        select="document('')/*/months:name[@sequence=./@sequence][1]"/>
      <xsl:text> - Total sales = </xsl:text>
      <xsl:value-of select="format-number(@total, '##,###')"/>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
