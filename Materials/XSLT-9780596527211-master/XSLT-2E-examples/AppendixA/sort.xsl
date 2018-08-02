<?xml version="1.0"?>
<!-- sort.xsl -->
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;</xsl:text>
    <xsl:call-template name="ascending-alpha-sort">
      <xsl:with-param name="items" select="/sample/textlist/listitem"/>
    </xsl:call-template>
    <xsl:call-template name="ascending-alpha-sort">
      <xsl:with-param name="items" select="/sample/numericlist/listitem"/>
    </xsl:call-template>
    <xsl:call-template name="ascending-numeric-sort">
      <xsl:with-param name="items" select="/sample/numericlist/listitem"/>
    </xsl:call-template> 
    <xsl:call-template name="descending-alpha-sort">
      <xsl:with-param name="items" select="/sample/textlist/listitem"/>
    </xsl:call-template>
    <xsl:call-template name="category-sort">
      <xsl:with-param name="items" select="/sample/textlist/listitem"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="ascending-alpha-sort">
    <xsl:param name="items"/>
    <xsl:text>Ascending text sort:</xsl:text>
    <xsl:text>&#xA;</xsl:text>
    <xsl:for-each select="$items">
      <xsl:sort select="."/>
      <xsl:value-of select="."/>
      <xsl:text>&#xA;</xsl:text>
    </xsl:for-each>
    <xsl:text>&#xA;</xsl:text>
  </xsl:template>

  <xsl:template name="descending-alpha-sort">
    <xsl:param name="items"/>
    <xsl:text>Descending text sort:</xsl:text>
    <xsl:text>&#xA;</xsl:text>
    <xsl:for-each select="$items">
      <xsl:sort select="." order="descending"/>
      <xsl:value-of select="."/>
      <xsl:text>&#xA;</xsl:text>
    </xsl:for-each>
    <xsl:text>&#xA;</xsl:text>
  </xsl:template>

  <xsl:template name="ascending-numeric-sort">
    <xsl:param name="items"/>
    <xsl:text>Ascending numeric sort:</xsl:text>
    <xsl:text>&#xA;</xsl:text>
    <xsl:for-each select="$items">
      <xsl:sort select="." data-type="number"/>
      <xsl:value-of select="."/>
      <xsl:text>&#xA;</xsl:text>
    </xsl:for-each>
    <xsl:text>&#xA;</xsl:text>
  </xsl:template>

  <xsl:template name="category-sort">
    <xsl:param name="items"/>
    <xsl:text>Ascending category sort:</xsl:text>
    <xsl:text>&#xA;</xsl:text>
    <xsl:for-each select="$items">
      <xsl:sort select="@category"/>
      <xsl:sort select="."/>
      <xsl:value-of select="."/>
      <xsl:text>&#xA;</xsl:text>
    </xsl:for-each>
    <xsl:text>&#xA;</xsl:text>
  </xsl:template>

</xsl:stylesheet>
