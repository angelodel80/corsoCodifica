<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:t="http://www.tei-c.org/ns/1.0"
   exclude-result-prefixes="t" version="2.0">

   <xsl:template name="space-content">
       <xsl:param name="parm-leiden-style" tunnel="yes" required="no"></xsl:param>
       <xsl:param name="vacat"/>
      <xsl:param name="extent"/>
      <xsl:choose>
          <xsl:when test="$parm-leiden-style = 'london'">
            <i dir="ltr">
               <!-- Found in teispace.xsl -->
               <xsl:call-template name="space-content-1">
                  <xsl:with-param name="vacat" select="$vacat"/>
               </xsl:call-template>
            </i>
         </xsl:when>
          <xsl:when test="$parm-leiden-style = 'panciera'">
            <!-- Found in teispace.xsl -->
            <span dir="ltr">
              <xsl:call-template name="space-content-2">
                <xsl:with-param name="vacat" select="$vacat"/>
                <xsl:with-param name="extent" select="$extent"/>
              </xsl:call-template>
            </span>
         </xsl:when>
         <xsl:otherwise>
            <!-- Found in teispace.xsl -->
           <span dir="ltr">
             <xsl:call-template name="space-content-2">
               <xsl:with-param name="vacat" select="$vacat"/>
               <xsl:with-param name="extent" select="$extent"/>
             </xsl:call-template>
           </span>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <xsl:template name="dip-space">
      <em dir="ltr">
         <span class="smaller">
            <xsl:call-template name="space-content-1">
               <xsl:with-param name="vacat" select="'vacat '"/>
            </xsl:call-template>
         </span>
      </em>
   </xsl:template>

</xsl:stylesheet>
