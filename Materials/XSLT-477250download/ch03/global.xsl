<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

   <xsl:output method="xhtml" encoding="UTF-8"
      doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
      doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"/>

   <xsl:param name="identifier" select="reference/@xml:id"/>
   <xsl:param name="resourcelist"
      select="document(concat('reslist_',reference/@scheme,'.xml'))"/>
   <xsl:param name="meta"
      select="$resourcelist//entry[@xml:id eq $identifier]"/>
   <xsl:param name="title" select="$meta/title"/>
   <xsl:param name="style">reference.css</xsl:param>
   

   <xsl:template match="/">
      <html>
         <head>
            <title>
               <xsl:value-of select="reference/body/title"/>
            </title>
         </head>
         <body>
            <xsl:apply-templates select="reference/body"/>
         </body>
      </html>
   </xsl:template>
   
   <xsl:template match="title">
      <h1>
         <xsl:value-of select="."/>
      </h1>
   </xsl:template>

   <xsl:template match="purpose">
      <h2>Purpose</h2>
      <xsl:apply-templates select="p"/>
   </xsl:template>

   <xsl:template match="usage">
      <h2>Usage</h2>
      <xsl:apply-templates select="p"/>
   </xsl:template>

   <xsl:template match="contains | containedby">
      <h2>
         <xsl:choose>
            <xsl:when test="@label='contains'">Contains</xsl:when>
            <xsl:otherwise>Contained by</xsl:otherwise>
         </xsl:choose>
      </h2>
      <p>
         <xsl:for-each select="link">
            <xsl:apply-templates select="."/>
            <xsl:text> </xsl:text>
         </xsl:for-each>
      </p>
   </xsl:template>

   <xsl:template match="p">
      <p>
         <xsl:apply-templates/>
      </p>
   </xsl:template>

   <xsl:template match="attr | element">
      <code>
         <xsl:value-of select="."/>
      </code>
   </xsl:template>

   <xsl:template match="attr | element" mode="index">
      <code>
         <xsl:value-of select="."/>
      </code>
   </xsl:template>

   <xsl:template match="code">
      <xsl:copy-of select="."/>
   </xsl:template>

   <xsl:template match="link">
      <xsl:variable name="linkID" select="@href"/>
      <xsl:variable name="linkmeta"
         select="$resourcelist//entry[@xml:id=$linkID]"/>
      <a>
         <xsl:attribute name="href">
            <xsl:value-of
               select="concat($linkmeta/content/@src,$linkID,'.html')"/>
         </xsl:attribute>
         <xsl:value-of select="$linkmeta/title"/>
      </a>
   </xsl:template>
</xsl:stylesheet>
