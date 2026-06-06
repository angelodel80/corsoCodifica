<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:t="http://www.tei-c.org/ns/1.0"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:EDF="http://epidoc.sourceforge.net/ns/functions"
   exclude-result-prefixes="t" version="2.0">
   <!-- Templates imported by [htm|txt]teigap.xsl -->
    
    <!-- style of the dot defined here -->
    <xsl:function name="EDF:dotchar" as="xs:string">
       <xsl:param name="leidenStyle"></xsl:param>
       <xsl:param name="gapReason"></xsl:param>
       <xsl:variable name="dot">
           <xsl:choose>
              <xsl:when test="$leidenStyle = ('ddbdp','dclp','sammelbuch')">
                   <xsl:text>&#xa0;&#xa0;&#x323;</xsl:text>
               </xsl:when>
               <xsl:when test="$leidenStyle = 'panciera' and $gapReason='illegible'">
                   <xsl:text>+</xsl:text>
               </xsl:when>
               <xsl:when test="$leidenStyle='london'">
                   <xsl:text>&#xb7;</xsl:text>
               </xsl:when>
               <xsl:otherwise>
                   <xsl:text>.</xsl:text>
               </xsl:otherwise>
           </xsl:choose>
       </xsl:variable>
       <xsl:sequence select="$dot"/>
   </xsl:function>

   <!-- The highest value of @quantity that will have dots produced -->
   <xsl:function name="EDF:dotmax" as="xs:double">
      <xsl:param name="leidenStyle"></xsl:param>
      <xsl:variable name="maxnum">
         <xsl:choose>
            <xsl:when test="$leidenStyle = ('ddbdp','sammelbuch')">
               <xsl:number value="8"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:number value="3"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:sequence select="$maxnum"/>
   </xsl:function>

   <xsl:template match="t:gap[@reason='omitted']">
      <xsl:param name="parm-edition-type" tunnel="yes" required="no"></xsl:param>
      <xsl:param name="parm-leiden-style" tunnel="yes" required="no"></xsl:param>
      <xsl:choose>
         <xsl:when test="$parm-edition-type = 'diplomatic'"/>
         <xsl:when test="$parm-leiden-style = 'panciera'">
            <xsl:text>&#12296;---&#12297;</xsl:text>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text>&lt;</xsl:text>
            <xsl:call-template name="extent-string"/>
            <xsl:text>&gt;</xsl:text>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <xsl:template match="t:gap[@reason='ellipsis']">
       <xsl:param name="parm-leiden-style" tunnel="yes" required="no"></xsl:param>
       <xsl:choose>
          <xsl:when test="$parm-leiden-style = ('ddbdp','dclp','sammelbuch')">
            <xsl:if test="string(t:desc) != 'non transcribed'">
               <xsl:value-of select="t:desc"/>
               <xsl:text> </xsl:text>
            </xsl:if>
            <xsl:choose>
               <xsl:when test="@quantity">
                  <xsl:if test="@precision='low'">
                     <xsl:text>ca.</xsl:text>
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
                  <xsl:text>?</xsl:text>
               </xsl:otherwise>
            </xsl:choose>
            <xsl:text> </xsl:text>
            <xsl:value-of select="@unit"/>
            <xsl:if test="@quantity &gt; 1 or @extent='unknown' or @atLeast or @atMost">
               <xsl:text>s</xsl:text>
            </xsl:if>
            <xsl:if test="string(t:desc) = 'non transcribed'">
               <xsl:text> untranscribed</xsl:text>
            </xsl:if>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text> ... </xsl:text>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>


   <xsl:template match="t:gap[@reason='illegible']">
      <xsl:param name="location" tunnel="yes" required="no"/>
      <!-- certainty -->
      <xsl:if test="child::t:certainty[@match='..']">
         <xsl:text>?</xsl:text>
      </xsl:if>

      <xsl:if test="not(preceding::node()[1][self::text()][normalize-space(.)=''][preceding-sibling::node()[1][self::t:gap[@reason='illegible']]])
         and not(preceding::node()[1][self::t:gap[@reason='illegible']]) and not($location = 'apparatus')">
         <xsl:call-template name="extent-string"/>
      </xsl:if>
      
      <!-- Apparatus display suppress  @extent='unknown' in apparatus TODO: possibly need to add: and not(self::t:gap[@reason='illegible'][@extent='unknown'])
       -->
      <xsl:if test="$location = 'apparatus'  and not(preceding::node()[1][self::text()][normalize-space(.)=''][preceding-sibling::node()[1][self::t:gap[@reason='illegible']]]) and not(preceding-sibling::node()[1][self::t:gap[@reason='illegible']])">
         <xsl:call-template name="extent-string"/>
      </xsl:if>
   </xsl:template>


   <xsl:template match="t:gap[@reason='lost']">
       <xsl:param name="parm-leiden-style" tunnel="yes" required="no"></xsl:param>
       <xsl:param name="parm-edition-type" tunnel="yes" required="no"></xsl:param>
       <xsl:param name="parm-verse-lines" tunnel="yes" required="no"></xsl:param>
       <xsl:choose>
         <xsl:when
            test="$parm-leiden-style = ('ddbdp','dclp','sammelbuch') and @unit = 'line' and @extent = 'unknown'"/>
           <xsl:when test="$parm-leiden-style = 'panceira' and @unit = 'line' and @extent = 'unknown'"/>
         <xsl:when test="@unit='line'">
            <xsl:text>[</xsl:text>
         </xsl:when>
         <xsl:otherwise>
            <!-- *NB* the lost-opener and lost-closer templates, found in tpl-reasonlost.xsl,
           are no longer used in this version of the stylesheets. They used to serve to limit
           the superfluous square brackets between adjacent gap and supplied elements,
           but this function is now performed by regex in [htm|txt]-tpl-sqbrackets.xsl
           which is called after all other templates are completed.
        -->
            <xsl:text>[</xsl:text>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:if
         test="$parm-leiden-style='london' and preceding-sibling::node()[1][@part='M' or @part='I'] and not($parm-edition-type='diplomatic')">
         <xsl:text>-</xsl:text>
      </xsl:if>

      <xsl:choose>
         <xsl:when test="$parm-verse-lines='on' and parent::t:seg[@met or @real]">
            <xsl:call-template name="verse-string"/>
         </xsl:when>
         <xsl:otherwise>
            <!-- Don't display again if there is a preceding adjecent gap with @reason='lost' and @extent='unknown' 
            -->
            <xsl:if
               test="
               (
               not(preceding::node()[1][self::text()][normalize-space(.)=''][preceding-sibling::node()[1][self::t:gap[@reason='lost'][@extent='unknown']]])
               and not(preceding::node()[1][self::t:gap[@reason='lost'][@extent='unknown']])
               ) 
               or not(self::t:gap[@reason='lost'][@extent='unknown'])">
               <xsl:call-template name="extent-string"/>
            </xsl:if>
         </xsl:otherwise>
      </xsl:choose>

      <!-- certainty -->
      <xsl:if test="child::t:certainty[@match='..']">
         <xsl:choose>
            <xsl:when test="$parm-leiden-style = ('ddbdp','dclp','sammelbuch')">
               <xsl:text>(?)</xsl:text>
            </xsl:when>
            <xsl:otherwise>
               <xsl:text>?</xsl:text>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:if>

      <xsl:if
         test="$parm-leiden-style='london' and following-sibling::node()[1][@part='M' or @part='F'] and not($parm-edition-type='diplomatic')">
         <xsl:text>-</xsl:text>
      </xsl:if>

      <xsl:choose>
         <xsl:when
            test="$parm-leiden-style = ('ddbdp','dclp','sammelbuch') and @unit = 'line' and @extent = 'unknown'"/>
          <xsl:when test="$parm-leiden-style = 'panceira' and @unit = 'line' and @extent = 'unknown'"/>
         <xsl:when test="@unit='line'">
            <xsl:text>]</xsl:text>
         </xsl:when>
         <xsl:otherwise>
            <!-- *NB* the lost-opener and lost-closer templates, found in tpl-reasonlost.xsl,
           are no longer used in this version of the stylesheets. They used to serve to limit
           the superfluous square brackets between adjacent gap and supplied elements,
           but this function is now performed by regex in [htm|txt]-tpl-sqbrackets.xsl
           which is called after all other templates are completed.
        -->
            <xsl:text>]</xsl:text>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>


  <xsl:template name="extent-string">
    <xsl:param name="parm-edition-type" tunnel="yes" required="no"/>
    <xsl:param name="parm-leiden-style" tunnel="yes" required="no"/>
    <xsl:param name="parm-edn-structure" tunnel="yes" required="no"/> 
    <!-- Found in htm|txt-teigap.xsl This allows, e.g. setting a text direction on the content. -->
    <xsl:call-template name="extent-string-wrapper"/>    
  </xsl:template>

   <xsl:template name="extent-string-content">
      <xsl:param name="parm-edition-type" tunnel="yes" required="no"/>
      <xsl:param name="parm-leiden-style" tunnel="yes" required="no"/>
      <xsl:param name="parm-edn-structure" tunnel="yes" required="no"/> <!-- added for creta -->
      <xsl:variable name="cur-dot" select="EDF:dotchar($parm-leiden-style,@reason)"/>
      <xsl:variable name="cur-max" select="EDF:dotmax($parm-leiden-style)"/>
     
      <!-- Precision of <gap> defined -->
      <xsl:variable name="circa">
         <xsl:choose>
            <xsl:when
               test="$parm-leiden-style = ('ddbdp','dclp','sammelbuch') and
               (@precision='low' or (@unit='character' and number(@quantity) &gt; $cur-max))">
               <xsl:text>ca.</xsl:text>
            </xsl:when>
            <xsl:when test="@precision='low' and not(starts-with($parm-leiden-style, 'edh'))">
               <xsl:text>c. </xsl:text>
            </xsl:when>
         </xsl:choose>
      </xsl:variable>

      <xsl:choose>
         <xsl:when test="@extent='unknown'">
            <xsl:choose>
               <xsl:when test="$parm-leiden-style = ('ddbdp','dclp','sammelbuch')">
                  <xsl:choose>
                     <!-- lines lost -->
                     <xsl:when test="@reason='lost' and @unit='line'">
                        <!--and (not(preceding-sibling::t:lb[2]) or not(following-sibling::*))-->
                        <xsl:text>-- -- -- -- -- -- -- -- -- --</xsl:text>
                     </xsl:when>
                     <!-- illegible vestiges -->
                     <xsl:when test="t:desc = 'vestiges' and @reason = 'illegible'">
                        <xsl:call-template name="tpl-vest">
                           <xsl:with-param name="circa" select="$circa"/>
                        </xsl:call-template>
                     </xsl:when>
                     <!-- other reason illegible and lost/chars caught in the otherwise -->
                     <xsl:otherwise>
                        <xsl:text>&#x2066;&#x0A;-ca.?-&#x0A;&#x2069;</xsl:text>
                     </xsl:otherwise>
                  </xsl:choose>
               </xsl:when>
               <xsl:when test="$parm-leiden-style = 'london' and not($parm-edition-type='diplomatic')">
                  <xsl:value-of select="$cur-dot"/>
                  <xsl:value-of select="$cur-dot"/>
                  <xsl:text> ? </xsl:text>
                  <xsl:value-of select="$cur-dot"/>
                  <xsl:value-of select="$cur-dot"/>
               </xsl:when>
               <xsl:when test="$parm-leiden-style = 'london'">
                  <xsl:value-of select="$cur-dot"/>
                  <xsl:value-of select="$cur-dot"/>
                  <xsl:value-of select="$cur-dot"/>
                  <xsl:value-of select="$cur-dot"/>
                  <xsl:value-of select="$cur-dot"/>
                  <xsl:value-of select="$cur-dot"/>
                  <xsl:value-of select="$cur-dot"/>
                  <xsl:value-of select="$cur-dot"/>
               </xsl:when>
               <xsl:when test="$parm-leiden-style = 'edh-itx'">
                  <xsl:text>3</xsl:text>
               </xsl:when>
               <xsl:when test="$parm-leiden-style = 'edh-names'">
                  <xsl:text>---</xsl:text>
               </xsl:when>
               <xsl:when test="$parm-leiden-style = 'panciera'">
                  <xsl:choose>
                     <!-- lines lost -->
                     <xsl:when test="@reason='lost' and @unit='line'">
                        <xsl:text>------</xsl:text>
                     </xsl:when>
                     <!--     unknown charcaters lost-->
                     <xsl:when test="@reason='lost' and @unit='character'">
                        <xsl:text>---</xsl:text>
                     </xsl:when>
                  </xsl:choose>
               </xsl:when>
               <xsl:when test="$parm-edn-structure = 'creta'"> <!-- added for creta -->
                  <xsl:text>- - -</xsl:text>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:text>---</xsl:text>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:when>

         <xsl:when test="@quantity and @unit='character'">
            <xsl:choose>
               <xsl:when test="$parm-edition-type = 'diplomatic'">
                  <xsl:variable name="dots"
                     select="'····························································································································································'"/>
                  <xsl:value-of select="substring($dots, 1, number(@quantity))"/>
               </xsl:when>
               <xsl:when test="$parm-leiden-style = 'edh-itx'">
                  <xsl:choose>
                     <xsl:when test="number(@quantity) &gt; 2">
                        <xsl:text>3</xsl:text>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:value-of select="@quantity"/>
                     </xsl:otherwise>
                  </xsl:choose>
               </xsl:when>
               <xsl:when test="number(@quantity) &gt; $cur-max or (number(@quantity) &gt; 1 and @precision='low')">
                  <xsl:choose>
                     <xsl:when test="$parm-leiden-style = ('ddbdp','dclp','sammelbuch')">
                        <xsl:choose>
                           <xsl:when test="t:desc = 'vestiges' and @reason = 'illegible'">
                              <xsl:call-template name="tpl-vest">
                                 <xsl:with-param name="circa" select="$circa"/>
                              </xsl:call-template>
                           </xsl:when>
                           <xsl:otherwise>
                              <xsl:text>- </xsl:text>
                              <xsl:value-of select="$circa"/>
                              <xsl:value-of select="@quantity"/>
                              <xsl:text> -</xsl:text>
                           </xsl:otherwise>
                        </xsl:choose>
                     </xsl:when>
                     <xsl:when test="$parm-leiden-style = 'panciera'">
                        <xsl:text>c. </xsl:text>
                        <xsl:value-of select="@quantity"/>
                     </xsl:when>
                     <xsl:when test="$parm-leiden-style = 'london'">
                        <xsl:value-of select="$cur-dot"/>
                        <xsl:value-of select="$cur-dot"/>
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="$circa"/>
                        <xsl:value-of select="@quantity"/>
                        <xsl:value-of select="$cur-dot"/>
                        <xsl:value-of select="$cur-dot"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:value-of select="$cur-dot"/>
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="$circa"/>
                        <xsl:value-of select="@quantity"/>
                        <xsl:value-of select="$cur-dot"/>
                     </xsl:otherwise>
                  </xsl:choose>
               </xsl:when>

               <xsl:when test="$cur-max &gt;= number(@quantity)">
                  <xsl:choose>
                     <xsl:when test="t:desc='vestiges' and @reason='illegible' and ($parm-leiden-style=('ddbdp','dclp','sammelbuch'))">
                        <xsl:call-template name="tpl-vest">
                           <xsl:with-param name="circa" select="$circa"/>
                        </xsl:call-template>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:call-template name="dot-out">
                           <xsl:with-param name="cur-num" select="number(@quantity)"/>
                        </xsl:call-template>
                     </xsl:otherwise>
                  </xsl:choose>
               </xsl:when>

               <xsl:otherwise>
                  <xsl:choose>
                     <xsl:when
                        test="t:desc='vestiges' and @reason='illegible' and ($parm-leiden-style=('ddbdp','dclp','sammelbuch'))">
                        <xsl:call-template name="tpl-vest">
                           <xsl:with-param name="circa" select="$circa"/>
                        </xsl:call-template>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:text>&#x2066; - - - &#x2069;</xsl:text>
                     </xsl:otherwise>
                  </xsl:choose>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:when>

         <xsl:when test="@atLeast and @atMost and not($parm-leiden-style=('edh-names','edh-itx'))">
            <!-- reason illegible and lost caught in the otherwise -->
            <xsl:choose>
               <xsl:when test="$parm-leiden-style = ('ddbdp','dclp','sammelbuch')">
                  <xsl:choose>
                     <xsl:when test="t:desc='vestiges' and @reason='illegible'">
                        <xsl:call-template name="tpl-vest">
                           <xsl:with-param name="circa" select="$circa"/>
                        </xsl:call-template>
                     </xsl:when>
                     <xsl:when test="@unit='character'">
                        <xsl:text> -</xsl:text>
                        <xsl:value-of select="@atLeast"/>
                        <xsl:text>-</xsl:text>
                        <xsl:value-of select="@atMost"/>
                        <xsl:text>- </xsl:text>
                     </xsl:when>
                     <xsl:when test="@unit='line'">
                        <xsl:if test="@reason='illegible'">
                           <xsl:text>Traces </xsl:text>
                        </xsl:if>
                        <xsl:value-of select="@atLeast"/>
                        <xsl:text>-</xsl:text>
                        <xsl:value-of select="@atMost"/>
                        <xsl:text> lines</xsl:text>
                        <xsl:if test="@reason='lost'">
                           <xsl:text> missing</xsl:text>
                        </xsl:if>
                     </xsl:when>
                  </xsl:choose>
               </xsl:when>
               <xsl:when test="$parm-leiden-style = ('panciera','eagletxt')">
                  <xsl:choose>
                     <xsl:when test="parent::t:name[@type='praenomen']">
                        <xsl:text>-</xsl:text>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:text>c. </xsl:text>
                        <xsl:value-of select="@atLeast"/>
                        <xsl:text> - </xsl:text>
                        <xsl:value-of select="@atMost"/>
                     </xsl:otherwise>
                  </xsl:choose>
               </xsl:when>
               <xsl:when test="$parm-leiden-style = ('panciera','eagletxt')">
                  <xsl:text>c. </xsl:text>
                  <xsl:value-of select="@atLeast"/>
                  <xsl:text> - </xsl:text>
                  <xsl:value-of select="@atMost"/>
               </xsl:when>
               <xsl:when test="$parm-leiden-style = 'london'">
                  <xsl:value-of select="$cur-dot"/>
                  <xsl:value-of select="$cur-dot"/>
                  <xsl:text> </xsl:text>
                  <xsl:value-of select="$circa"/>
                  <xsl:value-of select="@atLeast"/>
                  <xsl:text>-</xsl:text>
                  <xsl:value-of select="@atMost"/>
                  <xsl:value-of select="$cur-dot"/>
                  <xsl:value-of select="$cur-dot"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:value-of select="$cur-dot"/>
                  <xsl:text> </xsl:text>
                  <xsl:value-of select="$circa"/>
                  <xsl:value-of select="@atLeast"/>
                  <xsl:text>-</xsl:text>
                  <xsl:value-of select="@atMost"/>
                  <xsl:value-of select="$cur-dot"/>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:when>

         <xsl:when test="@quantity and @unit='line'">
            <xsl:choose>
               <xsl:when test="$parm-leiden-style = ('ddbdp','dclp','sammelbuch')">
                  <xsl:choose>
                     <xsl:when test="desc = 'vestiges' and @reason = 'illegible'">
                        <xsl:call-template name="tpl-vest">
                           <xsl:with-param name="circa" select="$circa"/>
                        </xsl:call-template>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:choose>
                           <!--<xsl:when test="@extent='unknown' and @reason='lost'">
                              <xsl:text>Text breaks</xsl:text>
                           </xsl:when>-->
                           <!--<xsl:when test="@extent='unknown' and @reason='illegible'">
                              <xsl:text>Traces</xsl:text>
                           </xsl:when>-->
                           <xsl:when test="@reason='lost'">
                              <xsl:value-of select="$circa"/>
                              <xsl:value-of select="@quantity"/>
                              <xsl:text> line</xsl:text>
                              <xsl:if test="number(@quantity) &gt; 1">
                                 <xsl:text>s</xsl:text>
                              </xsl:if>
                              <xsl:text> missing</xsl:text>
                           </xsl:when>
                           <xsl:when test="@reason='illegible'">
                              <xsl:text>Traces </xsl:text>
                              <xsl:value-of select="$circa"/>
                              <xsl:value-of select="@quantity"/>
                              <xsl:text> line</xsl:text>
                              <xsl:if test="number(@quantity) &gt; 1">
                                 <xsl:text>s</xsl:text>
                              </xsl:if>
                           </xsl:when>
                        </xsl:choose>
                     </xsl:otherwise>
                  </xsl:choose>
               </xsl:when>
               <xsl:when test="$parm-leiden-style = 'london'">
                  <xsl:text>---</xsl:text>
               </xsl:when>
               <xsl:when test="$parm-leiden-style =('panciera','eagletxt') and not(following-sibling::t:lb)">
                  <xsl:text>------</xsl:text>
               </xsl:when>
               <xsl:when test="$parm-leiden-style = 'edh-itx'">
                  <xsl:choose>
                     <xsl:when test="not(following-sibling::t:lb)">
                        <xsl:text>&amp;</xsl:text>
                     </xsl:when>
                     <xsl:when test="count(preceding-sibling::t:lb) = 1">
                        <xsl:text>$</xsl:text>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:text>6</xsl:text>
                     </xsl:otherwise>
                  </xsl:choose>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:text>&#x2066; - - - - - - - - - - &#x2069;</xsl:text>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:when>

         <xsl:when test="@quantity and @unit='cm'">
            <xsl:choose>
               <xsl:when
                  test="desc = 'vestiges' and $parm-leiden-style = ('ddbdp','dclp','sammelbuch') and @reason = 'illegible'">
                  <xsl:call-template name="tpl-vest">
                     <xsl:with-param name="circa" select="$circa"/>
                  </xsl:call-template>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:apply-templates/>
                  <xsl:value-of select="$cur-dot"/>
                  <xsl:value-of select="$cur-dot"/>
                  <xsl:text> </xsl:text>
                  <xsl:value-of select="$circa"/>
                  <xsl:value-of select="@quantity"/>
                  <xsl:text> cm </xsl:text>
                  <xsl:value-of select="$cur-dot"/>
                  <xsl:value-of select="$cur-dot"/>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:when>

         <xsl:otherwise>
            <xsl:choose>
               <xsl:when
                  test="desc = 'vestiges' and $parm-leiden-style = ('ddbdp','dclp','sammelbuch') and @reason = 'illegible'">
                  <xsl:call-template name="tpl-vest">
                     <xsl:with-param name="circa" select="$circa"/>
                  </xsl:call-template>
               </xsl:when>
               <xsl:when test="$parm-leiden-style = 'edh-itx'">
                  <xsl:text>6</xsl:text>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:value-of select="$cur-dot"/>
                  <xsl:value-of select="$cur-dot"/>
                  <xsl:text> ? </xsl:text>
                  <xsl:value-of select="$cur-dot"/>
                  <xsl:value-of select="$cur-dot"/>
                  <xsl:apply-templates/>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <!-- Template for lost verse, metre known -->
   <xsl:template name="verse-string">
      <xsl:choose>
         <xsl:when test="parent::t:seg[contains(@real,'+') or contains(@real,'-')]">
            <xsl:call-template name="scansion">
               <xsl:with-param name="met-string" select="translate(parent::t:seg/@real, '+-','ˉ˘')"/>
               <xsl:with-param name="string-len" select="string-length(parent::t:seg/@real)"/>
               <xsl:with-param name="string-pos" select="string-length(parent::t:seg/@real) - 1"/>
            </xsl:call-template>
         </xsl:when>
         <xsl:when test="parent::t:seg[contains(@met,'+') or contains(@met,'-')]">
            <xsl:call-template name="scansion">
               <xsl:with-param name="met-string" select="translate(parent::t:seg/@met, '+-','ˉ˘')"/>
               <xsl:with-param name="string-len" select="string-length(parent::t:seg/@met)"/>
               <xsl:with-param name="string-pos" select="string-length(parent::t:seg/@met) - 1"/>
            </xsl:call-template>
         </xsl:when>
         <xsl:otherwise>
            <xsl:call-template name="extent-string"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <!-- print macron and breve with intervening hard-spaces -->
   <xsl:template name="scansion">
      <xsl:param name="met-string"/>
      <xsl:param name="string-len"/>
      <xsl:param name="string-pos"/>
      <xsl:if test="$string-pos > -1">
         <xsl:text>&#xa0;</xsl:text>
         <xsl:value-of select="substring($met-string, number($string-len - $string-pos), 1)"/>
         <xsl:text>&#xa0;</xsl:text>
         <xsl:call-template name="scansion">
            <xsl:with-param name="met-string" select="$met-string"/>
            <xsl:with-param name="string-len" select="$string-len"/>
            <xsl:with-param name="string-pos" select="$string-pos - 1"/>
         </xsl:call-template>
      </xsl:if>
   </xsl:template>


   <!-- Template for vestiges -->
   <xsl:template name="tpl-vest">
      <xsl:param name="circa"/>
      <xsl:text>Traces</xsl:text>
      <xsl:choose>
         <xsl:when test="@extent = 'unknown'">
            <xsl:if test="@unit='line'">
               <xsl:text> ?  lines</xsl:text>
            </xsl:if>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text> </xsl:text>
            <xsl:value-of select="$circa"/>
            <xsl:text> </xsl:text>
            <xsl:choose>
               <xsl:when test="string(@atLeast) and string(@atMost)">
                  <xsl:value-of select="@atLeast"/>
                  <xsl:text>-</xsl:text>
                  <xsl:value-of select="@atMost"/>
               </xsl:when>
               <xsl:when test="string(@quantity)">
                  <xsl:value-of select="@quantity"/>
               </xsl:when>
            </xsl:choose>
            <xsl:choose>
               <xsl:when test="@unit = 'line'">
                  <xsl:text> line</xsl:text>
                  <xsl:if test="number(@quantity) &gt; 1 or number(@atMost) &gt; 1">
                     <xsl:text>s</xsl:text>
                  </xsl:if>
               </xsl:when>
               <xsl:when test="@unit = 'character'">
                  <xsl:text> character</xsl:text>
                  <xsl:if test="number(@quantity) &gt; 1 or number(@atMost) &gt; 1">
                     <xsl:text>s</xsl:text>
                  </xsl:if>
               </xsl:when>
               <xsl:when test="@unit = 'cm'">
                  <xsl:text> cm</xsl:text>
               </xsl:when>
            </xsl:choose>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>


   <!-- Production of dots -->
   <xsl:template name="dot-out">
      <xsl:param name="cur-num"/>
      <xsl:param name="parm-leiden-style" tunnel="yes" required="no"></xsl:param>
      <xsl:variable name="cur-dot" select="EDF:dotchar($parm-leiden-style,@reason)"></xsl:variable>

      <xsl:if test="$cur-num &gt; 0">
         <xsl:value-of select="$cur-dot"/>

         <xsl:call-template name="dot-out">
            <xsl:with-param name="cur-num" select="$cur-num - 1"/>
         </xsl:call-template>
      </xsl:if>
   </xsl:template>
</xsl:stylesheet>
