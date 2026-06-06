<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" 
                version="2.0">  
  <!-- latinnum span added in htm-teinum.xsl -->
  
   <xsl:template match="t:num">
      <xsl:param name="parm-edition-type" tunnel="yes" required="no"></xsl:param>
      <xsl:param name="parm-leiden-style" tunnel="yes" required="no"></xsl:param>
      <xsl:param name="parm-edn-structure" tunnel="yes" required="no"></xsl:param>
      <xsl:choose>
         <xsl:when test="not(child::t:* or child::text())"/>
         <xsl:when test="$parm-leiden-style = ('ddbdp','dclp','sammelbuch') and $parm-edn-structure!='inslib'">
            <xsl:apply-templates/>
            <xsl:if test="@rend='tick'">
               <xsl:text>´</xsl:text>
            </xsl:if>
         </xsl:when>
         <xsl:when test="$parm-edn-structure!='inslib' and $parm-edition-type='interpretive' and ancestor::t:*[@xml:lang][1][@xml:lang = 'grc']
            and ((number(@value) and not(contains(@value,'/')))
            or (number(@atLeast) and not(contains(@atLeast,'/')))
            or (number(@atMost) and not(contains(@atMost,'/'))))">
            <xsl:if test="@value &gt;= 1000 or @atLeast &gt;= 1000 or @atMost &gt;= 1000">
               <xsl:text>͵</xsl:text>
            </xsl:if>
            <xsl:apply-templates/>
            <xsl:if test="@value mod 1000 != 0
               or @atLeast mod 1000 != 0
               or @atMost mod 1000 != 0">
               <xsl:text>´</xsl:text>
            </xsl:if>
         </xsl:when>
         <xsl:otherwise>
            <xsl:apply-templates/>
         </xsl:otherwise>
      </xsl:choose>
  </xsl:template>
  
  
</xsl:stylesheet>