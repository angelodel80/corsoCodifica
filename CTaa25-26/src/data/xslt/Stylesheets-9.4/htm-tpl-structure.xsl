<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" 
                version="2.0">
  <!-- Contains named templates for default file structure (aka "metadata" aka "supporting data") -->  
   
  <!-- Specific named templates for HGV, InsLib, RIB, IOSPE, EDH, etc. are found in:
               htm-tpl-struct-hgv.xsl
               htm-tpl-struct-inslib.xsl
               htm-tpl-struct-rib.xsl
               htm-tpl-struct-iospe.xsl
               htm-tpl-struct-edh.xsl
               etc.
  -->
   
   <xsl:template name="london-structure">
      <xsl:call-template name="default-structure"/>
   </xsl:template>
   
   <xsl:template name="default-structure">
      <html>
         <head>
            <title>
               <xsl:call-template name="default-title" />
            </title>
            <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
            <!-- Found in htm-tpl-cssandscripts.xsl -->
            <xsl:call-template name="css-script"/>
         </head>
         <body>
           <xsl:call-template name="default-body-structure"/>
         </body>
      </html>
   </xsl:template>

   <xsl:template name="default-body-structure">
       <xsl:param name="parm-leiden-style" tunnel="yes" required="no"></xsl:param>
       <!-- Heading for a ddb style file -->
      <xsl:if test="($parm-leiden-style = ('ddbdp','dclp','sammelbuch'))">
         <h1>
            <xsl:choose>
               <xsl:when test="//t:sourceDesc//t:bibl/text()">
                  <xsl:value-of select="//t:sourceDesc//t:bibl"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:value-of select="//t:idno[@type='filename']"/>
               </xsl:otherwise>
            </xsl:choose>
         </h1>
      </xsl:if>
      
      <!-- Main text output -->
      <xsl:variable name="maintxt">
         <xsl:apply-templates/>
      </xsl:variable>
      <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
      <xsl:variable name="maintxt2">
      <xsl:apply-templates select="$maintxt" mode="sqbrackets"/>
      </xsl:variable>
      <xsl:apply-templates select="$maintxt2" mode="sqbrackets"/>
      
      <!-- Found in htm-tpl-license.xsl -->
      <xsl:call-template name="license"/>
   </xsl:template>

   <xsl:template name="default-title">
      <xsl:param name="parm-leiden-style" tunnel="yes" required="no"></xsl:param>
      <xsl:choose>
         <xsl:when test="$parm-leiden-style = ('ddbdp','dclp','sammelbuch')">
            <xsl:choose>
               <xsl:when test="//t:sourceDesc//t:bibl/text()">
                  <xsl:value-of select="//t:sourceDesc//t:bibl"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:value-of select="//t:idno[@type='filename']"/>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:when>
         <xsl:when test="//t:titleStmt/t:title/text()">
            <xsl:if test="//t:idno[@type='filename']/text()">
               <xsl:value-of select="//t:idno[@type='filename']"/>
               <xsl:text>. </xsl:text>
            </xsl:if>
            <xsl:value-of select="//t:titleStmt/t:title"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text>EpiDoc example output, default style</xsl:text>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

</xsl:stylesheet>
