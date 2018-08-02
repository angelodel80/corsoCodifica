<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns="http://www.w3.org/1999/xhtml">

   <xsl:import-schema namespace="http://www.w3.org/1999/xhtml"
   schema-location="xhtml-strict.xsd"/>
   <xsl:import-schema schema-location="products.xsd"/>

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

      <xsl:result-document validation="strict">
         <html>
            <xsl:call-template name="head">
               <xsl:with-param name="title" select="$title"/>
               <xsl:with-param name="style" select="$style"/>
            </xsl:call-template>
            <body>
               <h1>
                  <xsl:value-of select="$title"/>
               </h1>
               <xsl:for-each-group select="//product" group-by="@store">
                  <h2 align="left">
                     <xsl:value-of select="current-grouping-key()"/>
                  </h2>
                  <table cellspacing="0" width="50%">
                     <tr>
                        <th xsl:use-attribute-sets="th_first">SKU</th>
                        <th xsl:use-attribute-sets="col">Color</th>
                        <th xsl:use-attribute-sets="col">Units</th>

                     </tr>
                     <xsl:for-each select="current-group()">
                        <tr>
                           <th xsl:use-attribute-sets="td_first">
                              <xsl:value-of select="@sku"/>
                           </th>
                           <td xsl:use-attribute-sets="row">
                              <xsl:value-of select="@color"/>
                           </td>
                           <td xsl:use-attribute-sets="row">
                              <xsl:value-of select="@units"/>
                           </td>
                        </tr>


                     </xsl:for-each>
                     <tr>
                        <th xsl:use-attribute-sets="td_first">
                           <strong>Total</strong>
                        </th>
                        <td xsl:use-attribute-sets="row">&#160;</td>
                        <td xsl:use-attribute-sets="row">
                           <xsl:value-of select="sum(current-group()/@units)"/>
                        </td>
                     </tr>
                  </table>
               </xsl:for-each-group>

            </body>
         </html>
      </xsl:result-document>
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
         <link rel="first" type="any"/>
      </head>
   </xsl:template>
</xsl:stylesheet>
