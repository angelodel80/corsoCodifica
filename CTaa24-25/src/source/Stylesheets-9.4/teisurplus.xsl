<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" 
                version="2.0">
  <!-- Contains template for surplus -->
   
    <xsl:template match="t:surplus">
        <xsl:param name="parm-edn-structure" tunnel="yes" required="no"></xsl:param>
        <xsl:param name="parm-leiden-style" tunnel="yes" required="no"></xsl:param>
        <xsl:param name="parm-edition-type" tunnel="yes" required="no"></xsl:param>
       <xsl:choose>
           <xsl:when test="$parm-edition-type = 'diplomatic'">
               <xsl:apply-templates/>
           </xsl:when>
           <xsl:when test="$parm-leiden-style = 'rib'">
               <xsl:text>&lt; </xsl:text><xsl:apply-templates/><xsl:text> &gt;</xsl:text>
           </xsl:when>
           <xsl:otherwise>
               <xsl:text>{</xsl:text>
               <xsl:apply-templates/>
               <!-- cert-low template found in tpl-certlow.xsl -->
               <xsl:call-template name="cert-low"/>
               <xsl:text>}</xsl:text>
           </xsl:otherwise>
       </xsl:choose>
   </xsl:template>

</xsl:stylesheet>