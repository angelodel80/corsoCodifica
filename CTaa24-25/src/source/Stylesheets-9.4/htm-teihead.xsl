<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" 
                version="2.0">
  
  
  <xsl:template match="t:div/t:head">
      <h3>
         <xsl:apply-templates/>
      </h3>
  </xsl:template>
   
   <xsl:template match="t:body/t:head">
       <xsl:param name="parm-leiden-style" tunnel="yes" required="no"></xsl:param>
       <xsl:choose>
          <xsl:when test="$parm-leiden-style=('ddbdp','dclp')">
            <xsl:element name="p">
               <xsl:apply-templates/>
            </xsl:element>
         </xsl:when>
         <xsl:otherwise>
            <h2>
               <xsl:apply-templates/>
            </h2>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
  
</xsl:stylesheet>