<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema">

   <xsl:output method="text"/>
   <xsl:strip-space elements="*"/>

   <xsl:param name="delimiter" select="','"/>

   <xsl:variable name="headers">
      <header>SKU</header>
      <header>Color</header>
      <header>Units</header>
      <header>Store</header>
   </xsl:variable>

   <xsl:template match="/">
      <xsl:value-of select="$headers/header" separator="{$delimiter}"/>
      <xsl:text>&#xa;</xsl:text>
      <xsl:apply-templates/>
   </xsl:template>

   <xsl:template match="product">
      <xsl:value-of select="@sku"/>
      <xsl:text>,</xsl:text>
      <xsl:value-of select="@color"/>
      <xsl:text>,</xsl:text>
      <xsl:value-of select="@units"/>
      <xsl:text>,</xsl:text>
      <xsl:value-of select="@store"/>
      <xsl:text>&#xa;</xsl:text>
   </xsl:template>
</xsl:stylesheet>
