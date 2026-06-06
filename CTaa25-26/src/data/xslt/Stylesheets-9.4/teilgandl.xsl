<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" 
                version="2.0">
  <!-- Called by [htm|txt]-teilgandl.xsl -->

  <xsl:template name="line-context">
      <xsl:param name="parm-line-inc" tunnel="yes" required="no"></xsl:param>
      <xsl:if test="@met='pentameter'">
         <xsl:text>   </xsl:text>
      </xsl:if>
      <xsl:if test="local-name(preceding-sibling::t:*[1])='lb'">
         <xsl:variable name="pre-lb">
            <xsl:value-of select="preceding-sibling::t:lb[1]/@n"/>
         </xsl:variable>
         <xsl:if test="number($pre-lb) and $pre-lb mod number($parm-line-inc) = 0 and not($pre-lb = 0)">
            <xsl:choose>
               <xsl:when test="@break='no' or @type='inWord'">
                  <xsl:text>(</xsl:text>
                  <xsl:value-of select="$pre-lb"/>
                  <xsl:text>)</xsl:text>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:text>(</xsl:text>
                  <xsl:value-of select="$pre-lb"/>
                  <xsl:text>) </xsl:text>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:if>
      </xsl:if>
      <xsl:apply-templates/>
      <xsl:if test="local-name(following-sibling::t:*[1])='lb'">
         <xsl:text> |</xsl:text>
      </xsl:if>
  </xsl:template>
</xsl:stylesheet>