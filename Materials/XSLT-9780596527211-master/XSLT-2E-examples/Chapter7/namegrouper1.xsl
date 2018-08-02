<?xml version="1.0"?>
<!-- namegrouper1.xsl -->
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>Addresses grouped by zip code &#xA;</xsl:text>
    <xsl:for-each select="addressbook/address">
      <xsl:sort select="zip"/>
      <xsl:if test="zip!=preceding-sibling::address[1]/zip">
        <xsl:text>&#xA;Zip code </xsl:text>
        <xsl:value-of select="zip"/>
        <xsl:text> (</xsl:text>
        <xsl:value-of select="city"/>
        <xsl:text>, </xsl:text>
        <xsl:value-of select="state"/>
        <xsl:text>): &#xA;</xsl:text>
      </xsl:if>
      <xsl:if test="name/title">
        <xsl:value-of select="name/title"/>
        <xsl:text> </xsl:text>
      </xsl:if>
      <xsl:value-of select="name/first-name"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="name/last-name"/>
      <xsl:text>&#xA;</xsl:text>
      <xsl:value-of select="street"/>
      <xsl:text>&#xA;&#xA;</xsl:text>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
