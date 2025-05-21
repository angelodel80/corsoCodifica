<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0"
                version="2.0">

  <xsl:template match="t:app">
     <xsl:param name="parm-internal-app-style" tunnel="yes" required="no"></xsl:param>
     <xsl:param name="location" tunnel="yes" required="no"/>
      <xsl:apply-templates/>
     <xsl:if test="$parm-internal-app-style = 'ddbdp'">
      <!-- Found in txt-tpl-apparatus -->
         <xsl:call-template name="app-link">
            <xsl:with-param name="location">
               <xsl:choose>
                  <xsl:when test="$location = 'apparatus'">apparatus</xsl:when>
                  <xsl:otherwise>text</xsl:otherwise>
               </xsl:choose>
            </xsl:with-param>
         </xsl:call-template>
      </xsl:if>
  </xsl:template>


  <xsl:template match="t:rdg">
      <xsl:param name="parm-edition-type" tunnel="yes" required="no"></xsl:param>
      <xsl:choose>
          <xsl:when test="$parm-edition-type = 'diplomatic'">
            <xsl:choose>
               <xsl:when test="@resp='previous'"/>
               <xsl:when test="@resp='autopsy'">
                  <xsl:apply-templates/>
               </xsl:when>
               <xsl:otherwise/>
            </xsl:choose>
         </xsl:when>
         <xsl:otherwise>
            <xsl:choose>
               <xsl:when test="@resp='previous'">
                  <xsl:apply-templates/>
               </xsl:when>
               <xsl:when test="@resp='autopsy'"/>
               <xsl:otherwise/>
            </xsl:choose>
         </xsl:otherwise>
      </xsl:choose>
  </xsl:template>


  <xsl:template match="t:wit">
      <xsl:choose>
      <!-- Temporary -->
      <xsl:when test="parent::t:app"/>

         <xsl:otherwise>
            <xsl:apply-templates/>
         </xsl:otherwise>
      </xsl:choose>
  </xsl:template>


</xsl:stylesheet>
