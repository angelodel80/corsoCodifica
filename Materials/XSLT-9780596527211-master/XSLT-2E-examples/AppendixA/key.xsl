<?xml version="1.0"?>
<!-- key.xsl -->
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:param name="searchState"/>

  <xsl:key name="customersByState" match="address" use="state"/>

  <xsl:template match="/">
    <xsl:text>All customers in </xsl:text>
    <xsl:value-of select="$searchState"/>
    <xsl:text>&#xA;&#xA;</xsl:text>
    <xsl:for-each select="key('customersByState', $searchState)">
      <xsl:value-of select="first-name"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="last-name"/>
      <xsl:text>, </xsl:text>
      <xsl:value-of select="city"/>
      <xsl:text>&#xA;</xsl:text>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
