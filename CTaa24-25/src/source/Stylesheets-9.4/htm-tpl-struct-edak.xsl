<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: htm-tpl-struct-edak.xsl 2561 2017-04-04 11:24:24Z gabrielbodard $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t"
                version="2.0">
   <!-- Contains named templates for EDAK file structure -->

   <xsl:template name="edak-body-structure">
      <p><b>Edition: </b>
      <xsl:apply-templates select="//t:div[@type='bibliography']/t:p/node()"/>
      <xsl:if test="//t:creation//text()">
         <br/>
         <b>Text constituted from: </b>
         <xsl:apply-templates select="//t:creation"/>
      </xsl:if>
      </p>

      <p><b>Description: </b>
      <xsl:choose>
         <xsl:when test="//t:support/t:p/text()">
            <xsl:apply-templates select="//t:support/t:p" mode="edak-dimensions"/>
         </xsl:when>
         <xsl:when test="//t:support//text()">
            <xsl:apply-templates select="//t:support" mode="edak-dimensions"/>
         </xsl:when>
         <xsl:otherwise>Unknown</xsl:otherwise>
      </xsl:choose>

      <br />
      <b>Text: </b>
      <xsl:choose>
         <xsl:when test="//t:layoutDesc/t:layout//text()">
            <xsl:value-of select="//t:layoutDesc/t:layout"/>
         </xsl:when>
         <xsl:otherwise>Unknown.</xsl:otherwise>
      </xsl:choose>
      <br />
      <b>Letters: </b>
      <xsl:if test="//t:handDesc/t:handNote/text()">
         <xsl:value-of select="//t:handDesc/t:handNote"/>
      </xsl:if>
      </p>

      <p><b>Date: </b>
      <xsl:choose>
         <xsl:when test="//t:origin/t:origDate/text()">
            <xsl:value-of select="//t:origin/t:origDate"/>
            <xsl:if test="//t:origin/t:origDate[@type='evidence']">
               <xsl:text>(</xsl:text>
               <xsl:for-each select="tokenize(//t:origin/t:origDate[@evidence],' ')">
                  <xsl:value-of select="translate(.,'-',' ')"/>
                  <xsl:if test="position()!=last()">
                     <xsl:text>, </xsl:text>
                  </xsl:if>
               </xsl:for-each>
               <xsl:text>)</xsl:text>
            </xsl:if>
         </xsl:when>
         <xsl:otherwise>Unknown.</xsl:otherwise>
      </xsl:choose>
      </p>

      <p><b>Findspot: </b>
      <xsl:choose>
         <xsl:when test="//t:provenance[@type='found'][string(translate(normalize-space(.),' ',''))]">
            <xsl:apply-templates select="//t:provenance[@type='found']" mode="edak-placename"/>
         </xsl:when>
         <xsl:otherwise>Unknown</xsl:otherwise>
      </xsl:choose>
      <br/>
      <b>Original location: </b>
      <xsl:choose>
         <xsl:when test="//t:origin/t:origPlace/text()">
            <xsl:apply-templates select="//t:origin/t:origPlace" mode="edak-placename"/>
         </xsl:when>
         <xsl:otherwise>Unknown</xsl:otherwise>
      </xsl:choose>
      <br/>
      <b>Last recorded location: </b>
      <xsl:choose>
         <xsl:when test="//t:provenance[@type='observed'][string(translate(normalize-space(.),' ',''))]">
            <xsl:apply-templates select="//t:provenance[@type='observed']" mode="edak-placename"/>
            <!-- Named template found below. -->
            <xsl:call-template name="edak-invno"/>
         </xsl:when>
         <xsl:when test="//t:msIdentifier//t:repository[string(translate(normalize-space(.),' ',''))]">
            <xsl:value-of select="//t:msIdentifier//t:repository[1]"/>
            <!-- Named template found below. -->
            <xsl:call-template name="edak-invno"/>
         </xsl:when>
         <xsl:otherwise>Unknown</xsl:otherwise>
      </xsl:choose>
      </p>

      <div id="edition">
         <p><b>Edition:</b></p>
         <!-- Edited text output -->
         <xsl:variable name="edtxt">
            <xsl:apply-templates select="//t:div[@type='edition']"/>
         </xsl:variable>
         <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
         <xsl:apply-templates select="$edtxt" mode="sqbrackets"/>
      </div>

      <div id="apparatus">
         <!-- Apparatus text output -->
         <xsl:variable name="apptxt">
            <xsl:apply-templates select="//t:div[@type='apparatus']"/>
         </xsl:variable>
         <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
         <xsl:apply-templates select="$apptxt" mode="sqbrackets"/>
      </div>

      <div id="translation">
         <h4 class="slimmer">Translation:</h4>
         <!-- Translation text output -->
         <xsl:variable name="transtxt">
            <xsl:apply-templates select="//t:div[@type='translation']//t:p"/>
         </xsl:variable>
         <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
         <xsl:apply-templates select="$transtxt" mode="sqbrackets"/>
      </div>

      <div id="commentary">
         <h4 class="slimmer">Commentary:</h4>
         <!-- Commentary text output -->
         <xsl:variable name="commtxt">
            <xsl:apply-templates select="//t:div[@type='commentary']//t:p"/>
         </xsl:variable>
         <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
         <xsl:apply-templates select="$commtxt" mode="sqbrackets"/>
      </div>
   </xsl:template>

   <!-- Called from htm-tpl-structure.xsl -->

   <xsl:template name="edak-structure">
      <xsl:variable name="title">
         <xsl:call-template name="edak-title" />
      </xsl:variable>

      <html>
         <head>
            <title>
               <xsl:value-of select="$title"/>
            </title>
            <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
            <!-- Found in htm-tpl-cssandscripts.xsl -->
            <xsl:call-template name="css-script"/>
         </head>

         <body>
            <h1>
               <xsl:value-of select="$title"/>
            </h1>

            <xsl:call-template name="edak-body-structure" />
         </body>
      </html>
   </xsl:template>

   <xsl:template match="t:dimensions" mode="edak-dimensions">
      <xsl:if test="//text()">
         <xsl:if test="t:width/text()">w: 
            <xsl:value-of select="t:width"/>
            <xsl:if test="t:height/text()">
               <xsl:text> x </xsl:text>
            </xsl:if>
         </xsl:if>
         <xsl:if test="t:height/text()">h: 
            <xsl:value-of select="t:height"/>
         </xsl:if>
         <xsl:if test="t:depth/text()">x d:
            <xsl:value-of select="t:depth"/>
         </xsl:if>
         <xsl:if test="t:dim[@type='diameter']/text()">x diam.:
            <xsl:value-of select="t:dim[@type='diameter']"/>
         </xsl:if>
      </xsl:if>
   </xsl:template>

   <xsl:template match="t:placeName|t:rs" mode="edak-placename">
      <xsl:choose>
         <xsl:when test="contains(@ref,'pleiades.stoa.org') or contains(@ref,'geonames.org')">
            <a>
               <xsl:attribute name="href">
                  <xsl:value-of select="@ref"/>
               </xsl:attribute>
               <xsl:apply-templates/>
            </a>
         </xsl:when>
         <xsl:otherwise>
            <xsl:apply-templates/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <xsl:template name="edak-invno">
      <xsl:if test="//t:idno[@type='invNo'][string(translate(normalize-space(.),' ',''))]">
         <xsl:text> (Inv. no. </xsl:text>
         <xsl:for-each select="//t:idno[@type='invNo'][string(translate(normalize-space(.),' ',''))]">
            <xsl:value-of select="."/>
            <xsl:if test="position()!=last()">
               <xsl:text>, </xsl:text>
            </xsl:if>
         </xsl:for-each>
         <xsl:text>)</xsl:text>
      </xsl:if>
   </xsl:template>

   <xsl:template name="edak-title">
      <xsl:choose>
         <xsl:when test="//t:titleStmt/t:title/text() and number(substring(//t:publicationStmt/t:idno[@type='filename']/text(),2,5))">
            <xsl:value-of select="substring(//t:publicationStmt/t:idno[@type='filename'],1,1)"/>
            <xsl:text>. </xsl:text>
            <xsl:value-of select="number(substring(//t:publicationStmt/t:idno[@type='filename'],2,5)) div 100"/>
            <xsl:text>. </xsl:text>
            <xsl:value-of select="//t:titleStmt/t:title"/>
         </xsl:when>
         <xsl:when test="//t:titleStmt/t:title/text()">
            <xsl:value-of select="//t:titleStmt/t:title"/>
         </xsl:when>
         <xsl:when test="//t:sourceDesc//t:bibl/text()">
            <xsl:value-of select="//t:sourceDesc//t:bibl"/>
         </xsl:when>
         <xsl:when test="//t:idno[@type='filename']/text()">
            <xsl:value-of select="//t:idno[@type='filename']"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text>EpiDoc example output, edak style</xsl:text>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

</xsl:stylesheet>
