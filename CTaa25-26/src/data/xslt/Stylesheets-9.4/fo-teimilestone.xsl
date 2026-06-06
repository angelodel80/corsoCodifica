<!-- $Id$ --><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:axf="http://www.antennahouse.com/names/XSL/Extensions" exclude-result-prefixes="t" version="2.0">
   <!-- More specific templates in teimilestone.xsl -->

   <xsl:template match="t:milestone">
       <xsl:param name="parm-leiden-style" tunnel="yes" required="no"/>      
       <xsl:choose>
         <xsl:when test="($parm-leiden-style = 'ddbdp' or $parm-leiden-style = 'sammelbuch') and ancestor::t:div[@type = 'translation']">
            <xsl:if test="@rend = 'break'">
               <fo:block/>
            </xsl:if>
            <fo:inline-container vertical-align="super" font-size="8pt">
               <fo:inline font-weight="800">
                  <xsl:value-of select="@n"/>
               </fo:inline>
            </fo:inline-container>
            <xsl:text> </xsl:text>
         </xsl:when>
           <xsl:when test="($parm-leiden-style = 'ddbdp' or $parm-leiden-style = 'sammelbuch')">
            <xsl:choose>
               <xsl:when test="@rend = 'wavy-line'">
                  <xsl:if test="not(parent::t:supplied)">
                     <fo:block/>
                  </xsl:if>
                  <xsl:text>~~~~~~~~</xsl:text>
               </xsl:when>
               <xsl:when test="@rend = 'paragraphos'">
                  <xsl:if test="following-sibling::node()[not(self::text() and normalize-space(self::text())='')][1]/self::t:lb[@break='no']">-</xsl:if>
                  <xsl:if test="not(parent::t:supplied)">
                     <fo:block/>
                  </xsl:if>
                  <xsl:text>——</xsl:text>
               </xsl:when>
               <xsl:when test="@rend = 'horizontal-rule'">
                  <xsl:if test="not(parent::t:supplied)">
                     <fo:block/>
                  </xsl:if>
                  <xsl:text>————————</xsl:text>
               </xsl:when>
            </xsl:choose>
         </xsl:when>
         <xsl:otherwise>
            <fo:block/>
            <xsl:value-of select="@rend"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   
   <xsl:template match="t:cb">
      <xsl:param name="parm-leiden-style" tunnel="yes" required="no"/>
      <xsl:if test="$parm-leiden-style='iospe'">
         <fo:inline padding-right="0.2em" position="absolute" start-indent="0">
            <xsl:text>Col. </xsl:text>
            <xsl:value-of select="@n"/></fo:inline>
            <xsl:element name="fo:block"/>
      </xsl:if>
   </xsl:template>

</xsl:stylesheet>