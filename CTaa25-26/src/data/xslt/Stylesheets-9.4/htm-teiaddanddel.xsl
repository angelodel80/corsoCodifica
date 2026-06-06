<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t"  version="2.0">
   <!-- main templates for subst, add and del found in teiaddanddel.xsl-->
   <xsl:import href="teiaddanddel.xsl"/>

   <xsl:template match="t:subst">
      <xsl:param name="location" tunnel="yes" required="no"/>
      <xsl:apply-imports/>
   </xsl:template>


   <xsl:template match="t:add">
       <xsl:param name="location" tunnel="yes" required="no"/>
       <xsl:param name="parm-leiden-style" tunnel="yes" required="no"></xsl:param>
       <xsl:choose>
          <xsl:when test="($parm-leiden-style = ('ddbdp','dclp','sammelbuch')) and @place='interlinear'">
            <span style="font-size:smaller;">
               <xsl:apply-imports/>
            </span>
         </xsl:when>
         <xsl:otherwise>
            <xsl:apply-imports/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>


   <xsl:template match="t:del">
      <xsl:param name="location" tunnel="yes" required="no"/>
      <xsl:apply-imports/>
   </xsl:template>

</xsl:stylesheet>
