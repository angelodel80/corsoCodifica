<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0"
                version="2.0">
  <!-- Template in teinote.xsl -->
  <xsl:import href="teinote.xsl"/>
  
  <xsl:template match="t:note">
      <xsl:choose>
         <xsl:when test="ancestor::t:p or ancestor::t:l or ancestor::t:ab">
            <xsl:apply-imports/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text>
&#xD;</xsl:text>
            <xsl:apply-imports/>
            <xsl:text>
&#xD;</xsl:text>
         </xsl:otherwise>
      </xsl:choose>
  </xsl:template>
  
</xsl:stylesheet>
