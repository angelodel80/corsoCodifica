<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t"  version="2.0">

   <xsl:template match="t:certainty">
       <xsl:param name="parm-leiden-style" tunnel="yes" required="no"></xsl:param>
       <xsl:choose>
          <xsl:when test="$parm-leiden-style=('ddbdp','dclp','sammelbuch','iospe')">
            <xsl:if test="@match='..'">
               <xsl:text>(?)</xsl:text>
            </xsl:if>
         </xsl:when>
         <xsl:when test="@match='..'">
            <xsl:text>?</xsl:text>
         </xsl:when>
         <!--<xsl:otherwise>
            <xsl:message>no template in teicertainty.xsl for your use of certainty. Doc: <xsl:value-of select="tokenize(base-uri(),'/')[last()]"></xsl:value-of></xsl:message>
         </xsl:otherwise>-->
      </xsl:choose>
   </xsl:template>

</xsl:stylesheet>
