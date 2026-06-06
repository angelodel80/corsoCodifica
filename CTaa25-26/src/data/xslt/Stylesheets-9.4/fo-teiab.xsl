<!-- $Id$ --><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="t" version="2.0">
  
  <xsl:template match="t:ab">
      <xsl:param name="parm-leiden-style" tunnel="yes" required="no"/>
    <xsl:param name="parm-edition-type" tunnel="yes" required="no"/>
    <xsl:param name="parm-line-inc" tunnel="yes" required="no"/>
      <fo:block margin-bottom="3mm">
        <fo:table width="100%">
          <fo:table-column column-number="1" column-width="10%"/>
          <fo:table-column column-number="3" column-width="90%"/>
          <fo:table-body>
            <fo:table-row>
              <fo:table-cell column-number="1"><fo:block><xsl:comment>number</xsl:comment></fo:block></fo:table-cell>
              <fo:table-cell column-number="3"><fo:block><xsl:comment>line</xsl:comment></fo:block></fo:table-cell>
            </fo:table-row>
            
            
            <fo:table-row>
              <fo:table-cell column-number="1"><fo:block><xsl:apply-templates select=".//t:lb" mode="linenumber"/></fo:block></fo:table-cell>
              <fo:table-cell column-number="3">
                
        <fo:block>
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
             <xsl:if test="not($parm-leiden-style=('ddbdp','sammelbuch'))                   and descendant::t:lb[last()][contains(@style, 'text-direction:l-to-r') or @rend='left-to-right']">
                <xsl:text>  →</xsl:text>
             </xsl:if>
             <xsl:if test="not($parm-leiden-style=('ddbdp','sammelbuch'))                   and descendant::t:lb[last()][contains(@style, 'text-direction:r-to-l') or @rend='right-to-left']">
                <xsl:text>  ←</xsl:text>
             </xsl:if>
             <!-- in IOSPE, if followed by lg, include it here (and suppress in htm-teilgandl.xsl) -->
              <xsl:if test="$parm-leiden-style='iospe' and following-sibling::t:*[1][self::t:lg]">
                <xsl:apply-templates select="following-sibling::t:lg/*"/>
              </xsl:if>
          </fo:block>
              </fo:table-cell>
            </fo:table-row>
          </fo:table-body>
        </fo:table>
      </fo:block>
  </xsl:template>

</xsl:stylesheet>