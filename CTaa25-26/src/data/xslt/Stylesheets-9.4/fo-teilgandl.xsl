<!-- $Id$ --><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="t" version="2.0">
  <xsl:include href="teilgandl.xsl"/>

  <xsl:template match="t:lg">
      <xsl:param name="parm-leiden-style" tunnel="yes" required="no"/>
      <xsl:choose>
        <!-- in IOSPE, if preceded by ab, will be called inside that div (in htm-teiab.xsl) -->
          <xsl:when test="$parm-leiden-style='iospe' and preceding-sibling::t:*[1][local-name()='ab']"/>
        <xsl:otherwise>
          <fo:block-container margin-left="6em" line-height="1.4" margin-top="8px" margin-bottom="8px" position="relative" padding-right="2em">
         <!-- Found in htm-tpl-lang.xsl -->
         <xsl:call-template name="attr-lang"/>
            <xsl:apply-templates/>
         </fo:block-container>
        </xsl:otherwise>
     </xsl:choose>
  </xsl:template>


  <xsl:template match="t:l">
      <xsl:param name="parm-line-inc" tunnel="yes" required="no"/>
      <xsl:param name="parm-verse-lines" tunnel="yes" required="no"/>
      <xsl:choose>
          <xsl:when test="$parm-verse-lines = 'on'">   
            <xsl:variable name="div-loc">
               <xsl:for-each select="ancestor::t:div[@type='textpart']">
                  <xsl:value-of select="@n"/>
                  <xsl:text>-</xsl:text>
               </xsl:for-each>
            </xsl:variable>
            <fo:block/>
              <xsl:if test="number(@n) and @n mod number($parm-line-inc) = 0 and not(@n = 0)">
                <fo:inline start-indent="0" padding-right="0.2em" position="absolute">
                  <xsl:value-of select="@n"/>
               </fo:inline>
            </xsl:if>
            <!-- found in teilgandl.xsl -->
        <xsl:call-template name="line-context"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:apply-templates/>
         </xsl:otherwise>
      </xsl:choose>
  </xsl:template>

</xsl:stylesheet>