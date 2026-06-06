<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0"
                version="2.0">
  
  <xsl:template match="t:div/t:head">
      <xsl:param name="parm-leiden-style" tunnel="yes" required="no"></xsl:param>
      <xsl:choose>
          <xsl:when test="starts-with($parm-leiden-style, 'edh')"/>
         <xsl:otherwise>
            <xsl:apply-templates/>
            <xsl:text>
&#xD;</xsl:text>
         </xsl:otherwise>
      </xsl:choose>
  </xsl:template>
  
</xsl:stylesheet>
