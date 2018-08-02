<?xml version="1.0"?>
<!-- variable2.xsl -->
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:variable name="numberOne" as="xs:integer" select="23"/>
  <xsl:variable name="numberTwo" as="xs:double" select="2.718281828459"/>
  <xsl:variable name="numberThree" as="xs:float" select="$numberTwo"/>
  <xsl:variable name="numberFour" as="xs:integer" 
    select="xs:integer($numberTwo)"/>
  <xsl:variable name="dateValue" as="xs:date" select="xs:date('1995-04-21')"/> 
  <xsl:variable name="whatever" as="xs:integer" select="xs:integer(42)"/>

  <xsl:template match="/">
    <xsl:call-template name="bob">
      <xsl:with-param name="whatever" select="xs:integer(8)"/>
    </xsl:call-template>
    <xsl:text>&#xA;whatever&#x9;</xsl:text>
    <xsl:value-of select="$whatever"/>
    <xsl:text>&#xA;</xsl:text>
  </xsl:template>

  <xsl:template name="bob">
    <xsl:param name="whatever" as="xs:integer"/>
    <xsl:variable name="whatever" as="xs:integer" select="xs:integer(4)"/>
    <xsl:variable name="whatever" as="xs:integer" select="xs:integer(98)"/>
    <xsl:text>Hello!  The values of your variables are:&#xA;</xsl:text>
    <xsl:text>&#xA;numberOne&#x9;</xsl:text>
    <xsl:value-of select="$numberOne"/>
    <xsl:text>&#xA;numberTwo&#x9;</xsl:text>
    <xsl:value-of select="$numberTwo"/>
    <xsl:text>&#xA;numberThree&#x9;</xsl:text>
    <xsl:value-of select="$numberThree"/>
    <xsl:text>&#xA;numberFour&#x9;</xsl:text>
    <xsl:value-of select="$numberFour"/>
    <xsl:text>&#xA;dateValue&#x9;</xsl:text>
    <xsl:value-of select="$dateValue"/>
    <xsl:text>&#xA;whatever&#x9;</xsl:text>
    <xsl:value-of select="$whatever"/>
    <xsl:text>&#xA;</xsl:text>
  </xsl:template>

</xsl:stylesheet>
