<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema">

   <xsl:output method="xhtml"/>

   <xsl:param name="style">reference.css</xsl:param>
   <xsl:param name="title">Stock report</xsl:param>

   <xsl:attribute-set name="col">
      <xsl:attribute name="scope">col</xsl:attribute>
   </xsl:attribute-set>

   <xsl:attribute-set name="row">
      <xsl:attribute name="scope">row</xsl:attribute>
   </xsl:attribute-set>

   <xsl:attribute-set name="th_first" use-attribute-sets="col">
      <xsl:attribute name="class">firsthdr</xsl:attribute>
   </xsl:attribute-set>

   <xsl:attribute-set name="td_first" use-attribute-sets="row">
      <xsl:attribute name="class">firstcell</xsl:attribute>
   </xsl:attribute-set>
   <xsl:template match="/">
      <html>
         <xsl:call-template name="head">
            <xsl:with-param name="title" select="title"/>
            <xsl:with-param name="style" select="$style"/>
         </xsl:call-template>
         <body>
            <h1>
               <xsl:value-of select="$title"/>
            </h1>
            <table cellspacing="0" width="50%">
               <tr>
                  <th xsl:use-attribute-sets="th_first">SKU</th>
                  <th xsl:use-attribute-sets="col">Units</th>
                  <th xsl:use-attribute-sets="col">Color</th>
                  <th xsl:use-attribute-sets="col">Store</th>
               </tr>
               <xsl:for-each select="//product">
                 <!-- <xsl:sort select="@sku"/>-->
                  <xsl:sort select="@units"/>
                  <tr>
                     <th xsl:use-attribute-sets="td_first">
                        <xsl:value-of select="@sku"/>
                     </th>
                     <td xsl:use-attribute-sets="row">
                        <xsl:value-of select="@units"/>
                     </td>
                     <td xsl:use-attribute-sets="row">
                        <xsl:value-of select="@color"/>
                     </td>
                     <td xsl:use-attribute-sets="row">
                        <xsl:value-of select="@store"/>
                     </td>
                  </tr>
               </xsl:for-each>
            </table>
         </body>
      </html>
   </xsl:template>
   <xsl:template name="head">
      <xsl:param name="title"/>
      <xsl:param name="style"/>
      <head>
         <meta http-equiv="Content-Type" content="text/xml;charset=UTF-8"/>
         <title>
            <xsl:value-of select="$title"/>
         </title>
         <link rel="stylesheet" type="text/css">
            <xsl:attribute name="href">
               <xsl:value-of select="$style"/>
            </xsl:attribute>
         </link>
      </head>
   </xsl:template>
</xsl:stylesheet>
