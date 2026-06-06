<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:t="http://www.tei-c.org/ns/1.0"
   xmlns:EDF="http://epidoc.sourceforge.net/ns/functions"
  
   exclude-result-prefixes="t EDF" version="2.0">
   <!-- Found in [htm|txt]-teispace.xsl -->

   <xsl:template match="t:space">
       <xsl:param name="parm-edition-type" tunnel="yes" required="no"/>
       <xsl:param name="parm-leiden-style" tunnel="yes" required="no"/>
       <xsl:param name="parm-edn-structure" tunnel="yes" required="no"/> <!-- added for creta -->
      <!-- function EDF:f-wwrap declared in functions.xsl; tests if lb break=no immediately follows space -->
      <xsl:if test="EDF:f-wwrap(.) = true()">
         <xsl:text>- </xsl:text>
      </xsl:if>
      <xsl:choose>
          <xsl:when test="$parm-edition-type = 'diplomatic'">
            <xsl:choose>
               <xsl:when test="@unit='line'">
                  <xsl:text>&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;</xsl:text>
                  <xsl:call-template name="dip-space"/>
               </xsl:when>
               <xsl:when test="@unit='character' or not(@unit)">
                  <xsl:variable name="sp-ext">
                     <xsl:choose>
                        <xsl:when test="@quantity">
                           <xsl:number value="@quantity"/>
                        </xsl:when>
                        <xsl:when test="number(@extent)">
                           <xsl:number value="@extent"/>
                        </xsl:when>
                        <xsl:otherwise>
                           <xsl:number value="3"/>
                        </xsl:otherwise>
                     </xsl:choose>
                  </xsl:variable>
                  <xsl:for-each select="1 to $sp-ext">
                     <xsl:text>&#xa0;&#xa0;</xsl:text>
                  </xsl:for-each>
               </xsl:when>
               <xsl:otherwise/>
            </xsl:choose>
         </xsl:when>

         <xsl:otherwise>
            <xsl:choose>
               <xsl:when test="($parm-leiden-style = ('ddbdp','dclp','sammelbuch'))">
                 <xsl:variable name="content">
                   <xsl:text>&#x2066; vac. </xsl:text>
                   <xsl:choose>
                     <xsl:when test="@quantity">
                       <xsl:if test="@precision='low'">
                         <xsl:text>ca. </xsl:text>
                       </xsl:if>
                       <xsl:value-of select="@quantity"/>
                     </xsl:when>
                     <xsl:when test="@atLeast and @atMost">
                       <xsl:value-of select="@atLeast"/>
                       <xsl:text>-</xsl:text>
                       <xsl:value-of select="@atMost"/>
                     </xsl:when>
                     <xsl:when test="@atLeast ">
                       <xsl:text>&#x2265;</xsl:text>
                       <xsl:value-of select="@atLeast"/>
                     </xsl:when>
                     <xsl:when test="@atMost ">
                       <xsl:text>&#x2264;</xsl:text>
                       <xsl:value-of select="@atMost"/>
                     </xsl:when>
                     <xsl:otherwise>
                       <xsl:text>? </xsl:text>
                     </xsl:otherwise>
                   </xsl:choose>
                   <xsl:if test="@unit='line'">
                     <xsl:text> line</xsl:text>
                     <xsl:if test="@quantity > 1 or @extent='unknown' or @atLeast or @atMost">
                       <xsl:text>s</xsl:text>
                     </xsl:if>
                   </xsl:if>
                   <xsl:if test="child::t:certainty[@match='..']">
                     <xsl:text>(?) </xsl:text>
                   </xsl:if>
                   <xsl:text>&#x2069;</xsl:text>
                 </xsl:variable>
                 <xsl:call-template name="space-content">
                   <xsl:with-param name="vacat" select="$content"/>
                 </xsl:call-template>
               </xsl:when>
               
                <xsl:when test="$parm-leiden-style='london'">
                  <xsl:choose>
                     <xsl:when test="@extent = 'unknown'">
                        <!-- Found in [htm|txt]-teispace.xsl -->
                        <xsl:call-template name="space-content">
                           <xsl:with-param name="vacat" select="' vac '"/>
                        </xsl:call-template>
                     </xsl:when>
                     <xsl:when test="@quantity = string(1) and @unit='character'">
                        <xsl:call-template name="space-content">
                           <xsl:with-param name="vacat" select="' v '"/>
                        </xsl:call-template>
                     </xsl:when>
                     <xsl:when test="@quantity = string(2) and @unit='character'">
                        <xsl:call-template name="space-content">
                           <xsl:with-param name="vacat" select="' vv '"/>
                        </xsl:call-template>
                     </xsl:when>
                     <xsl:when test="contains('345', @quantity) and @unit='character'">
                        <!-- Found in [htm|txt]-teispace.xsl -->
                        <xsl:call-template name="space-content">
                           <xsl:with-param name="vacat" select="' vac '"/>
                        </xsl:call-template>
                     </xsl:when>
                     <xsl:when test="@quantity &gt;= 6 and @unit='character'">
                        <xsl:call-template name="space-content">
                           <xsl:with-param name="vacat" select="' vacat '"/>
                        </xsl:call-template>
                     </xsl:when>
                     <xsl:when test="@unit='line'">
                        <xsl:text>&#160;&#160;&#160;&#160;&#160;</xsl:text>
                        <xsl:call-template name="space-content">
                           <xsl:with-param name="vacat" select="' vacat '"/>
                        </xsl:call-template>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:call-template name="space-content">
                           <xsl:with-param name="vacat" select="' vac '"/>
                        </xsl:call-template>
                     </xsl:otherwise>
                  </xsl:choose>
               </xsl:when>

                <xsl:when test="$parm-leiden-style='iospe'">
                  <xsl:variable name="vacat" select="' vac. '"/>
                  <xsl:choose>
                     <xsl:when test="@quantity and @unit='character'">
                        <xsl:call-template name="space-content">
                           <xsl:with-param name="vacat" select="$vacat"/>
                           <xsl:with-param name="extent" select="concat(@quantity,' litt. ')"/>
                        </xsl:call-template>
                     </xsl:when>
                     <xsl:when test="@unit='character'">
                        <xsl:call-template name="space-content">
                           <xsl:with-param name="vacat" select="$vacat"/>
                        </xsl:call-template>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:call-template name="space-content">
                           <xsl:with-param name="vacat" select="$vacat"/>
                        </xsl:call-template>
                     </xsl:otherwise>
                  </xsl:choose>
               </xsl:when>

                <xsl:when test="$parm-leiden-style='panciera'">
                  <xsl:variable name="precision">
                     <xsl:if test="@precision = 'low'">?</xsl:if>
                  </xsl:variable>

                  <xsl:choose>
                     <xsl:when test="@extent = 'unknown'">
                        <!-- Found in [htm|txt]-teispace.xsl -->
                        <xsl:call-template name="space-content">
                           <xsl:with-param name="vacat" select="' vac. '"/>
                        </xsl:call-template>
                     </xsl:when>
                     <xsl:when test="@quantity and @unit='character'">
                        <xsl:call-template name="space-content">
                           <xsl:with-param name="vacat"><xsl:text> vac. </xsl:text></xsl:with-param>
                           <xsl:with-param name="extent">
                              <xsl:value-of select="@quantity"/>
                              <xsl:value-of select="$precision"/>
                           </xsl:with-param>
                        </xsl:call-template>
                     </xsl:when>
                     <xsl:when test="@quantity and @unit='line'">
                        <xsl:call-template name="space-content">
                        <!-- Found in [htm|txt]-teispace.xsl -->
                           <xsl:with-param name="vacat"><xsl:text> vac. </xsl:text></xsl:with-param>
                           <xsl:with-param name="extent">
                              <xsl:value-of select="@quantity"/>
                              <xsl:text> line</xsl:text>
                              <xsl:if test="@quantity > 1">
                                 <xsl:text>s</xsl:text>
                              </xsl:if>
                              <xsl:value-of select="$precision"/>
                           </xsl:with-param>
                        </xsl:call-template>
                     </xsl:when>
                     <xsl:when test="@quantity and @unit != 'line' and @unit != 'character'">
                        <xsl:call-template name="space-content">
                           <xsl:with-param name="vacat"><xsl:text> vac. </xsl:text></xsl:with-param>
                           <xsl:with-param name="extent">
                              <xsl:value-of select="@quantity"/>
                              <xsl:text> </xsl:text>
                              <xsl:value-of select="@unit"/>
                              <xsl:value-of select="$precision"/>
                           </xsl:with-param>
                        </xsl:call-template>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:call-template name="space-content">
                           <xsl:with-param name="vacat" select="' vac. '"/>
                        </xsl:call-template>
                     </xsl:otherwise>
                  </xsl:choose>
               </xsl:when>

               <xsl:when test="($parm-edn-structure = 'creta')"> <!-- added for creta -->
                  <xsl:choose>
                     <xsl:when test="@unit='character'">
                        <xsl:choose>
                           <xsl:when test="@quantity='1'">
                           <i>v</i>
                        </xsl:when>
                        <xsl:when test="@quantity='2'">
                           <i>vv</i>
                        </xsl:when>
                        <xsl:when test="@quantity='3'">
                           <i>vvv</i>
                        </xsl:when>
                        <xsl:otherwise>
                           <i>vac.</i>
                        </xsl:otherwise>
                        </xsl:choose>
                     </xsl:when>
                     <xsl:when test="@unit='line'">
                        <i>vacat</i>
                     </xsl:when>                
                  </xsl:choose>
                  <xsl:if test="@cert='low'">
                     <i>?</i>
                  </xsl:if>
               </xsl:when>

               <xsl:otherwise>
                  <xsl:call-template name="space-content">
                     <xsl:with-param name="vacat" select="' vac. '"/>
                  </xsl:call-template>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <!-- Called from [htm|txt]-teispace.xsl -->
   <xsl:template name="space-content-1">
      <xsl:param name="vacat"/>
      <xsl:if test="child::t:certainty[starts-with(@match,'..')]">
         <xsl:text>(?)</xsl:text>
      </xsl:if>
      <xsl:value-of select="$vacat"/>
   </xsl:template>


   <!-- Called from [htm|txt]-teispace.xsl -->
   <xsl:template name="space-content-2">
       <xsl:param name="parm-leiden-style" tunnel="yes" required="no"></xsl:param>
       <xsl:param name="vacat"/>
      <xsl:param name="extent"/>
       <xsl:if test="$parm-leiden-style='panciera'"><xsl:text>(</xsl:text></xsl:if>
      <xsl:value-of select="$vacat"/>
      <xsl:if test="child::t:certainty[starts-with(@match,'..')]">
         <xsl:text>(?)</xsl:text>
      </xsl:if>
      <xsl:if test="string-length($extent) &gt; 0">
         <xsl:text> </xsl:text>
         <xsl:value-of select="$extent"/>
      </xsl:if>
       <xsl:if test="$parm-leiden-style='panciera'"><xsl:text>)</xsl:text></xsl:if>
   </xsl:template>

</xsl:stylesheet>
