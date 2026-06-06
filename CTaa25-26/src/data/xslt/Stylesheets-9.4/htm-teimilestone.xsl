<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:t="http://www.tei-c.org/ns/1.0"
   exclude-result-prefixes="t" version="2.0">
   <!-- More specific templates in teimilestone.xsl -->

   <xsl:template match="t:milestone">
       <xsl:param name="parm-leiden-style" tunnel="yes" required="no"/>      
       <xsl:param name="parm-edn-structure" tunnel="yes" required="no"/>
       <xsl:choose>
         <xsl:when
            test="($parm-leiden-style = ('ddbdp','dclp','sammelbuch')) and ancestor::t:div[@type = 'translation']">
            <xsl:if test="@rend = 'break'">
               <br/>
            </xsl:if>
            <sup>
               <strong>
                  <xsl:value-of select="@n"/>
               </strong>
            </sup>
            <xsl:text> </xsl:text>
         </xsl:when>
          <xsl:when test="($parm-leiden-style = ('ddbdp','dclp','sammelbuch') or $parm-edn-structure='inslib')">
            <xsl:choose>
               <xsl:when test="@rend = 'wavy-line'">
                  <xsl:if test="not(parent::t:supplied)">
                     <br/>
                  </xsl:if>
                  <xsl:text>~~~~~~~~</xsl:text>
               </xsl:when>
               <xsl:when test="@rend = 'paragraphos'">
                  <!--         imported change  from https://sourceforge.net/p/epidoc/code/2602/-->
                  <!-- Added to controll '-' when there is a milestone@rend='paragraphos' followed by a lb@break='no' see: https://github.com/DCLP/dclpxsltbox/issues/52-->
                 <xsl:if test="following-sibling::node()[not(self::text()
                    and normalize-space(self::text())='')][1]/self::t:lb[@break='no']
                    and not(preceding-sibling::*[1][self::t:supplied[@reason='lost']])">-</xsl:if>
                  <xsl:if test="not(parent::t:supplied) and not($parm-edn-structure='inslib')">
                     <br/>
                  </xsl:if>
                  <xsl:text>——</xsl:text>
               </xsl:when>
               <xsl:when test="@rend = 'diple-obelismene' and @unit='undefined'">
                  <!-- <xsl:message><xsl:text>    </xsl:text>diple-obelismene!</xsl:message> -->
                  <xsl:if test="following-sibling::node()[not(self::text() and normalize-space(self::text())='')][1]/self::t:lb[@break='no']">-</xsl:if>
                  <xsl:if test="not(parent::t:supplied)">
                     <br/>
                  </xsl:if>
                  <xsl:text>⤚</xsl:text>
               </xsl:when>
               <xsl:when test="@rend = 'coronis' and @unit='undefined'">
                  <!-- <xsl:message><xsl:text>    </xsl:text>coronis!</xsl:message> -->
                  <xsl:if test="following-sibling::node()[not(self::text() and normalize-space(self::text())='')][1]/self::t:lb[@break='no']">-</xsl:if>
                  <xsl:if test="not(parent::t:supplied)">
                     <br/>
                  </xsl:if>
                  <xsl:text>⸎</xsl:text>
               </xsl:when>
               <xsl:when test="@rend = 'horizontal-rule'">
                  <xsl:if test="not(parent::t:supplied)">
                     <br/>
                  </xsl:if>
                  <xsl:text>————————</xsl:text>
               </xsl:when>
               <xsl:otherwise>
                  <br/>
                  <xsl:value-of select="@rend"/>
               </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
       </xsl:choose>
   </xsl:template>

   <xsl:template match="t:cb">
      <xsl:param name="parm-leiden-style" tunnel="yes" required="no"/>
      <xsl:if test="$parm-leiden-style='iospe'">
         <xsl:element name="span">
            <xsl:attribute name="class" select="'textpartnumber'"/>
            <xsl:attribute name="style" select="'left: -4em;'"/>
            <xsl:text>Col. </xsl:text>
            <xsl:value-of select="@n"/>
            <xsl:element name="br"/>
         </xsl:element>
      </xsl:if>
   </xsl:template>

</xsl:stylesheet>
