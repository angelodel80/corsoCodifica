<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" 
                version="2.0">

  <xsl:template match="t:handShift">
      <xsl:param name="parm-leiden-style" tunnel="yes" required="no"></xsl:param>
      <xsl:choose>
         <xsl:when test="($parm-leiden-style = ('ddbdp','dclp','sammelbuch'))">
            <xsl:text>(hand </xsl:text>
            <xsl:value-of select="substring-after(@new, 'm')"/>
            <xsl:if test="@cert='low'">
               <xsl:text>?</xsl:text>
            </xsl:if>
            <xsl:text>) </xsl:text>
         </xsl:when>
         <xsl:otherwise>
            <xsl:apply-templates/>
         </xsl:otherwise>
      </xsl:choose>
  </xsl:template>

</xsl:stylesheet>