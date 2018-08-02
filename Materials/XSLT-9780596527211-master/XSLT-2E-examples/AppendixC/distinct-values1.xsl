<?xml version="1.0"?>
<!-- distinct-values1.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Here is a test of the distinct-values() </xsl:text>
    <xsl:text>function:&#xA;</xsl:text>

    <xsl:text>&#xA;  The states in the source </xsl:text>
    <xsl:text>document are:&#xA;    </xsl:text>
    <xsl:value-of 
      select="/addressbook/address/state"
      separator=", "/>

    <xsl:text>&#xA;&#xA;  The unique states </xsl:text>
    <xsl:text>is:&#xA;    </xsl:text>
    <xsl:value-of 
      select="distinct-values(/addressbook/address/state)"
      separator=", "/>
  </xsl:template>

</xsl:stylesheet>
