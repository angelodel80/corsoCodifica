<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xpath-default-namespace="http://www.w3.org/2005/Atom">

   <xsl:output method="xhtml" encoding="UTF-8"
      doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
      doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"/>

   <xsl:param name="style">reference.css</xsl:param>
   <xsl:param name="find">xrx</xsl:param>

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

   <xsl:key name="category" match="entry" use="category/@term"/>

   <xsl:template match="/">
      <html>
         <xsl:call-template name="head">
            <xsl:with-param name="title" select="feed/title"/>
            <xsl:with-param name="style" select="$style"/>
         </xsl:call-template>
         <body>
            <h1>
               <xsl:value-of select="feed/title"/>
            </h1>
            <table cellspacing="0">
               <tr>
                  <th xsl:use-attribute-sets="th_first">Author</th>
                  <th xsl:use-attribute-sets="col">Title</th>
                  <th xsl:use-attribute-sets="col">Date</th>
                  <th xsl:use-attribute-sets="col">Categories</th>
               </tr>
               <xsl:variable name="cat" select="key('category',$find)"/>
               <xsl:for-each select="$cat">
                 <xsl:sort select="author/name"/>
                  <xsl:sort select="updated"/>
                  <tr>
                     <th xsl:use-attribute-sets="td_first">
                        <xsl:value-of select="author/name"/>
                     </th>
                     <td xsl:use-attribute-sets="row">
                        <xsl:apply-templates select="title"/>
                     </td>
                     <td xsl:use-attribute-sets="row">
                        <xsl:apply-templates select="updated"/>
                     </td>
                     <td xsl:use-attribute-sets="row">
                        <xsl:for-each select="category">
                           <xsl:value-of select="@term"/>
                           <xsl:if test="position() ne last()">, </xsl:if>
                        </xsl:for-each>

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
