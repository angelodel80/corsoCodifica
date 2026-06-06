<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" version="2.0">
   <!-- Called from [htm|txt]-teiref.xsl -->

   <xsl:template name="reprint-text">
      <xsl:param name="direction"/>

      <xsl:text>[</xsl:text>
      <xsl:text>Reprinted </xsl:text>
      <xsl:value-of select="$direction"/>
      <xsl:text>: </xsl:text>
      <xsl:call-template name="divide-links">
         <xsl:with-param name="val" select="@n"/>
      </xsl:call-template>
      <xsl:text>] </xsl:text>
      <xsl:apply-templates/>
   </xsl:template>



   <!-- Templates used for reprint in ddbdp -->
   <xsl:template name="divide-links">
      <xsl:param name="val"/>
      <xsl:variable name="cur-string">
         <xsl:choose>
            <xsl:when test="contains($val, '|')">
               <xsl:value-of select="substring-before(normalize-space($val), '|')"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="$val"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="pass-string" select="substring-after(normalize-space($val), '|')"/>

      <xsl:call-template name="build-path">
         <xsl:with-param name="val" select="$cur-string"/>
         <xsl:with-param name="fol-val">
            <xsl:if test="string($pass-string)">
               <xsl:text>yes</xsl:text>
            </xsl:if>
         </xsl:with-param>
      </xsl:call-template>

      <xsl:if test="string($pass-string)">
         <xsl:call-template name="divide-links">
            <xsl:with-param name="val" select="$pass-string"/>
         </xsl:call-template>
      </xsl:if>
   </xsl:template>

   <xsl:template name="build-path">
      <xsl:param name="val"/>
      <xsl:param name="fol-val"/>

      <xsl:variable name="cur-file-vol-doc"
         select="substring-after(normalize-space(/t:TEI/@n), ';')"/>
      <xsl:variable name="cur-file-vol" select="substring-before($cur-file-vol-doc, ';')"/>

      <xsl:variable name="val-col" select="substring-before($val, ';')"/>
      <xsl:variable name="val-vol-doc" select="substring-after($val, ';')"/>
      <xsl:variable name="val-vol" select="substring-before($val-vol-doc, ';')"/>
      <xsl:variable name="val-doc">
         <xsl:value-of select="$val-col"/>
         <xsl:text>.</xsl:text>
         <xsl:if test="string(normalize-space($val-vol))">
            <xsl:value-of select="$val-vol"/>
            <xsl:text>.</xsl:text>
         </xsl:if>
         <xsl:value-of select="substring-after($val-vol-doc, ';')"/>
      </xsl:variable>

      <xsl:variable name="href-link" select="concat('/ddbdp/',$val)"/>

      <!-- Found in [htm|txt]-teiref.xsl -->
      <xsl:call-template name="link-text">
         <xsl:with-param name="href-link" select="$href-link"/>
         <xsl:with-param name="val-doc" select="$val-doc"/>
      </xsl:call-template>

      <xsl:if test="$fol-val = 'yes'">
         <xsl:text> | </xsl:text>
      </xsl:if>
   </xsl:template>
</xsl:stylesheet>
