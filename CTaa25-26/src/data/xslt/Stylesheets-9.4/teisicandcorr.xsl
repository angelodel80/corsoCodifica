<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:t="http://www.tei-c.org/ns/1.0"
   exclude-result-prefixes="t" version="2.0">
   <!-- Contains templates for choice/sic and choice/corr -->

   <xsl:template match="t:choice/t:sic">
       <xsl:param name="parm-edition-type" tunnel="yes" required="no"></xsl:param>
       <xsl:param name="parm-leiden-style" tunnel="yes" required="no"></xsl:param>
       <xsl:choose>
          <xsl:when test="$parm-edition-type='diplomatic' or $parm-leiden-style=('ddbdp','dclp','sammelbuch')">
            <xsl:apply-templates/>
            <!-- if context is inside the app-part of an app-like element... -->
            <xsl:if test="ancestor::t:*[local-name()=('reg','corr','rdg') 
               or self::t:del[@rend='corrected']]">
               <xsl:text> (i.e. </xsl:text>
               <xsl:apply-templates select="../t:corr/node()"/>
               <xsl:text>)</xsl:text>
            </xsl:if>
         </xsl:when>
         <xsl:otherwise/>
      </xsl:choose>
   </xsl:template>

   <xsl:template match="t:choice/t:corr">
       <xsl:param name="parm-edition-type" tunnel="yes" required="no"></xsl:param>
       <xsl:param name="parm-leiden-style" tunnel="yes" required="no"></xsl:param>
       <xsl:choose>
          <xsl:when test="$parm-edition-type='diplomatic' or $parm-leiden-style=('ddbdp','dclp','sammelbuch')"/>
         <xsl:otherwise>
            <xsl:choose>
                <xsl:when test="$parm-leiden-style = ('seg','iospe')">
                  <xsl:text>&lt;</xsl:text>
                  <xsl:apply-templates/>
                  <!-- cert-low template found in tpl-certlow.xsl -->
                  <xsl:call-template name="cert-low"/>
                  <xsl:text>&gt;</xsl:text>
               </xsl:when>
                <xsl:when test="starts-with($parm-leiden-style, 'edh')">
                  <xsl:apply-templates/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:text>&#x2e22;</xsl:text>
                  <xsl:apply-templates/>
                  <!-- cert-low template found in tpl-certlow.xsl -->
                  <xsl:call-template name="cert-low"/>
                  <xsl:text>&#x2e23;</xsl:text>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

<!-- creta specific template -->
   <xsl:template match="t:corr">
      <xsl:param name="parm-edn-structure" tunnel="yes" required="no"/>
      <xsl:if test="$parm-edn-structure = 'creta'">
         <xsl:text>⟨</xsl:text><xsl:apply-templates/><xsl:text>⟩</xsl:text>
         </xsl:if>
   </xsl:template>
</xsl:stylesheet>