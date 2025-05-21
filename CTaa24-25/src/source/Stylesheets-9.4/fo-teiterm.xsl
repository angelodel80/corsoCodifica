<!-- $Id$ --><xsl:stylesheet xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" version="2.0">
  
  <xsl:template match="t:term">
      <xsl:param name="parm-edn-structure" tunnel="yes" required="no"/>
      <xsl:param name="parm-hgv-gloss" tunnel="yes" required="no"/>
      <xsl:param name="parm-leiden-style" tunnel="yes" required="no"/>
      <xsl:choose>
      <!-- Adds caption for hgv translations -->
          <xsl:when test="($parm-leiden-style = 'ddbdp' or $parm-leiden-style = 'sammelbuch') and ancestor::t:div[@type = 'translation'] and @target">
            <xsl:variable name="lang" select="ancestor::t:div[@type = 'translation']/@xml:lang"/>
            <xsl:variable name="term" select="@target"/>
        
            <xsl:choose>
               <xsl:when test="ancestor::t:lem">
                  <xsl:apply-templates/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:choose>
                      <xsl:when test="document($parm-hgv-gloss)//t:item[@xml:id = $term]/t:gloss[@xml:lang = $lang]/text()"><fo:inline class="term">
                    <xsl:apply-templates/></fo:inline>
                          <fo:inline style="display:none"><xsl:value-of select="document($parm-hgv-gloss)//t:item[@xml:id = $term]/t:gloss[@xml:lang = $lang]"/></fo:inline>                 
                    </xsl:when>
                    <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
                  </xsl:choose>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:when>
      
          <xsl:when test="$parm-edn-structure = 'rib'">
              <xsl:choose>
                  <xsl:when test="@xml:lang='grc'"><span class="greek"><xsl:apply-templates/></span></xsl:when>
                  <xsl:when test="@rend='diplo'"><span class="sc"><xsl:apply-templates/></span></xsl:when>
                  <xsl:when test="@xml:lang"><span class="em"><xsl:apply-templates/></span></xsl:when>
                  <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
              </xsl:choose>
          </xsl:when>

          <xsl:otherwise>
            <xsl:apply-templates/>
         </xsl:otherwise>
      </xsl:choose>
    
  </xsl:template>
</xsl:stylesheet>