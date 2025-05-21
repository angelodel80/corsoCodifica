<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: htm-tpl-struct-hgv.xsl 2517 2017-03-10 19:53:37Z sarcanon $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" 
                version="2.0">
  <!-- Contains named templates for HGV file structure (aka "metadata" aka "supporting data") -->  
   
  <!-- Called from htm-tpl-structure.xsl -->
   
   <xsl:template name="hgv-structure">
       <xsl:param name="parm-leiden-style" tunnel="yes" required="no"></xsl:param>
       <html>
         <head>
            <title>
               <xsl:choose>
                  <xsl:when test="//t:sourceDesc//t:bibl/text()">
                     <xsl:value-of select="//t:sourceDesc//t:bibl"/>
                  </xsl:when>
                  <xsl:when test="//t:idno[@type='filename']/text()">
                     <xsl:value-of select="//t:idno[@type='filename']"/>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:text></xsl:text>
                  </xsl:otherwise>
               </xsl:choose>
            </title>
            <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
            <!-- Found in htm-tpl-cssandscripts.xsl -->
            <xsl:call-template name="css-script"/>
         </head>
         <body>
            
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
            <xsl:apply-templates select="//div[@type='edition']"/>
            
            <!-- Found in htm-tpl-license.xsl -->
            <xsl:call-template name="license"/>
            
         </body>
      </html>
   </xsl:template>
   
   </xsl:stylesheet>
