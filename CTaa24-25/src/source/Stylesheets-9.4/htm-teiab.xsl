<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" 
                version="2.0">
  
  <xsl:template match="t:ab">
      <xsl:param name="parm-leiden-style" tunnel="yes" required="no"></xsl:param>
      <xsl:param name="parm-edition-type" tunnel="yes" required="no"></xsl:param>
      <div class="textpart">
      	<!-- transfers the  @xml:lang attribute of the ab element to the textpart-->
      	<!-- a div[@type='textpart'] is created for each ab element, independant of the textpart / ab hierarchical structure -->
      	
      	<!-- Found in htm-tpl-lang.xsl -->
      	<xsl:call-template name="attr-lang"/>
          <span class="ab">
              <xsl:if test="$parm-leiden-style='iospe'">
                <xsl:variable name="div-loc">
                   <xsl:for-each select="ancestor::t:div[@type='textpart']">
                      <xsl:value-of select="@n"/>
                      <xsl:text>-</xsl:text>
                   </xsl:for-each>
                </xsl:variable>
                <xsl:attribute name="id">
                   <xsl:value-of select="concat('div',$div-loc)"/>
                </xsl:attribute>
             </xsl:if>
             <xsl:apply-templates/>
             <!-- if next div or ab begins with lb[break=no], then add hyphen -->
              <xsl:if test="following::t:lb[1][@break='no' or @type='inWord'] and not($parm-edition-type='diplomatic')">
                <xsl:text>-</xsl:text>
             </xsl:if>
             <!-- if final lb in ab is L2R or R2L, then print arrow here -->
             <xsl:if test="not($parm-leiden-style=('ddbdp', 'dclp','sammelbuch')) 
                 and descendant::t:lb[last()][contains(@style, 'text-direction:l-to-r') or @rend='left-to-right']">
                <xsl:text>&#xa0;&#xa0;→</xsl:text>
             </xsl:if>
             <xsl:if test="not($parm-leiden-style=('ddbdp','dclp','sammelbuch')) 
                 and descendant::t:lb[last()][contains(@style, 'text-direction:r-to-l') or @rend='right-to-left']">
                <xsl:text>&#xa0;&#xa0;←</xsl:text>
             </xsl:if>
             <!-- in IOSPE, if followed by lg, include it here (and suppress in htm-teilgandl.xsl) -->
              <xsl:if test="$parm-leiden-style='iospe' and following-sibling::t:*[1][self::t:lg]">
                <xsl:apply-templates select="following-sibling::t:lg/*"/>
              </xsl:if>
          </span>
      </div>
  </xsl:template>

</xsl:stylesheet>