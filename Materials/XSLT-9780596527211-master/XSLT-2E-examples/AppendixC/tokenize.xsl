<?xml version="1.0"?>
<!-- tokenize.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:template match="/">

    <xsl:variable name="string1"
      select="concat('Now is the time for all good men&#xA;',
              'and women &#xA;',
              'to aid the party.')"/>

    <xsl:variable name="string2" as="xs:string"
      select="'Visa # 1234-5678-9101-1121'"/>

    <xsl:text>&#xA;Here are some tests of the </xsl:text>
    <xsl:text>tokenize() function:&#xA;</xsl:text>

    <xsl:text>&#xA;  $string1 = &#xA;</xsl:text>
    <xsl:value-of select="$string1"/>

    <xsl:text>&#xA;&#xA;  $string2 = &#xA;</xsl:text>
    <xsl:value-of select="$string2"/>

    <xsl:text>&#xA;&#xA;  tokenize($string1, </xsl:text>
    <xsl:text>'&amp;#xA;') = </xsl:text>
    <xsl:text>&#xA;    ('</xsl:text>
    <xsl:value-of select="tokenize($string1, '&#xA;')"
      separator="',&#xA;     '"/>
    <xsl:text>')&#xA;    count() = </xsl:text>
    <xsl:value-of select="count(tokenize($string1, '&#xA;'))"/>

    <xsl:text>&#xA;&#xA;  tokenize($string2, '-') = </xsl:text>
    <xsl:text>&#xA;    ('</xsl:text>
    <xsl:value-of 
      select="tokenize($string2, '-')" separator="', '"/>
    <xsl:text>')&#xA;    count() = </xsl:text>
    <xsl:value-of select="count(tokenize($string2, '-'))"/>

    <xsl:text>&#xA;&#xA;  tokenize($string2, </xsl:text>
    <xsl:text>'(Visa # )|-') = </xsl:text>
    <xsl:text>&#xA;    ('</xsl:text>
    <xsl:value-of 
      select="tokenize($string2, '(Visa # )|-')" separator="', '"/>
    <xsl:text>')&#xA;    count() = </xsl:text>
    <xsl:value-of select="count(tokenize($string2, '(Visa #)|-'))"/>

  </xsl:template>

</xsl:stylesheet>
