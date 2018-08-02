<?xml version="1.0"?>
<!-- for-each-group1.xsl -->
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>Customers grouped by state&#xA;&#xA;</xsl:text>
    <xsl:for-each-group select="/addressbook/address" group-by="state">
      <xsl:sort select="state"/>
      <xsl:text>  State = </xsl:text>
      <xsl:value-of select="current-grouping-key()"/>
      <xsl:text>&#xA;</xsl:text>
      <xsl:for-each select="current-group()">
        <xsl:text>&#x9;</xsl:text>
        <xsl:value-of select="(first-name, last-name)"
          separator=" "/>
        <xsl:text>, </xsl:text>
        <xsl:value-of select="city"/>
        <xsl:text>&#xA;</xsl:text>
      </xsl:for-each>
    </xsl:for-each-group>
  </xsl:template>

</xsl:stylesheet>
