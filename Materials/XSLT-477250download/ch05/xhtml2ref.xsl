<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
   xpath-default-namespace="http://www.w3.org/1999/xhtml">

   <xsl:output method="xml" encoding="UTF-8"/>

   <xsl:template match="/">
      <reference>
         <title>
            <xsl:value-of select="html/body/h1"/>
         </title>
         <body>
            <xsl:apply-templates select="html/body"/>
         </body>
      </reference>
   </xsl:template>

   <xsl:template match="h1 | h2"/>

   <xsl:template match="body">
      <xsl:for-each-group select="*" group-starting-with="h2">
         <xsl:variable name="label" select="."/>
         <xsl:element name="{$label}">
            <xsl:apply-templates select="current-group()"/>
         </xsl:element>
      </xsl:for-each-group>
   </xsl:template>

   <xsl:template match="p">
      <p>
         <xsl:apply-templates/>
      </p>
   </xsl:template>

   <xsl:template match="code">
      <xsl:choose>
         <xsl:when test="@class='element'">
            <element>
               <xsl:value-of select="."/>
            </element>
         </xsl:when>
         <xsl:when test="@class='attr'">
            <attr>
               <xsl:value-of select="."/>
            </attr>
         </xsl:when>
         <xsl:otherwise>
            <code>
               <xsl:value-of select="."/>
            </code>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

</xsl:stylesheet>
