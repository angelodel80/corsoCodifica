<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" 
                version="2.0">
  <xsl:include href="teilgandl.xsl"/>

   <xsl:template match="t:lg">
      <xsl:param name="parm-leiden-style" tunnel="yes" required="no"></xsl:param>
      <xsl:param name="parm-edn-structure" tunnel="yes" required="no"/>
      <xsl:choose>
         <!-- in IOSPE, if preceded by ab, will be called inside that div (in htm-teiab.xsl) -->
         <xsl:when test="$parm-leiden-style='iospe' and preceding-sibling::t:*[1][local-name()='ab']"/>
         <xsl:when test="$parm-edn-structure='inslib' and following-sibling::t:lg">
            <div class="textpart no-space">
               <!-- Found in htm-tpl-lang.xsl -->
               <xsl:call-template name="attr-lang"/>
               <xsl:apply-templates/>
            </div>
         </xsl:when>
         <xsl:otherwise>
            <div class="textpart">
               <!-- Found in htm-tpl-lang.xsl -->
               <xsl:call-template name="attr-lang"/>
               <xsl:apply-templates/>
            </div>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>


  <xsl:template match="t:l">
      <xsl:param name="parm-line-inc" tunnel="yes" required="no"></xsl:param>
      <xsl:param name="parm-verse-lines" tunnel="yes" required="no"></xsl:param>
      <xsl:param name="parm-edn-structure" tunnel="yes" required="no"/>
      <xsl:choose>
          <xsl:when test="$parm-verse-lines = 'on'">   
            <xsl:variable name="div-loc">
               <xsl:for-each select="ancestor::t:div[@type='textpart']">
                  <xsl:value-of select="@n"/>
                  <xsl:text>-</xsl:text>
               </xsl:for-each>
            </xsl:variable>
            <br id="a{$div-loc}l{@n}"/>
              <xsl:if test="number(@n) and @n mod number($parm-line-inc) = 0 and not(@n = 0)">
               <span class="linenumber">
                  <xsl:value-of select="@n"/>
               </span>
            </xsl:if>
            <!-- found in teilgandl.xsl -->
        <xsl:call-template name="line-context"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:apply-templates/>
         <!-- if final lb in l is L2R or R2L, then print arrow here -->
            <xsl:if test="$parm-edn-structure='inslib' and not(following-sibling::t:l) and descendant::t:lb[last()][@rend='left-to-right']">
               <xsl:text>&#xa0;&#xa0;→</xsl:text>
            </xsl:if>
            <xsl:if test="$parm-edn-structure='inslib' and not(following-sibling::t:l) and descendant::t:lb[last()][@rend='right-to-left']">
               <xsl:text>&#xa0;&#xa0;←</xsl:text>
            </xsl:if>
         </xsl:otherwise>
      </xsl:choose>
  </xsl:template>

</xsl:stylesheet>