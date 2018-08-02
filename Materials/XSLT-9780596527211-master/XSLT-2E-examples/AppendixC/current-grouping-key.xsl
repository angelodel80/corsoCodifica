<?xml version="1.0"?>
<!-- current-grouping-key.xsl -->
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Here's a test of the </xsl:text>
    <xsl:text>current-grouping-key() function:&#xA;</xsl:text>
    <xsl:text>&#xA;  Customers grouped by state:</xsl:text>

    <xsl:for-each-group select="//address" group-by="state">
      <xsl:sort select="state"/>
      <xsl:text>&#xA;&#xA;    Customers in </xsl:text>
      <xsl:value-of select="current-grouping-key()"/>
      <xsl:text>:</xsl:text>
      
      <xsl:for-each select="current-group()">
        <xsl:text>&#xA;      </xsl:text>
        <xsl:value-of select="name"/>
        <xsl:text> of </xsl:text>
        <xsl:value-of select="city"/>
      </xsl:for-each>
    </xsl:for-each-group>
  </xsl:template>

</xsl:stylesheet>
