<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" 
                version="2.0">

  <xsl:template match="t:list">
      <xsl:choose>
         <xsl:when test="@type = 'ordered'">
            <ol>
               <xsl:apply-templates/>
            </ol>
         </xsl:when>
         <xsl:otherwise>
            <ul>
               <xsl:apply-templates/>
            </ul>
         </xsl:otherwise>
      </xsl:choose>
  </xsl:template>


  <xsl:template match="t:item">
      <li>
         <xsl:apply-templates/>
      </li>
  </xsl:template>

</xsl:stylesheet>