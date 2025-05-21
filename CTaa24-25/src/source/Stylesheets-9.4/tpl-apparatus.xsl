<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:t="http://www.tei-c.org/ns/1.0"
   exclude-result-prefixes="t" version="2.0">

   <!-- Generates the DDBDP-style apparatus from the edition -->
   <!--
    Adding to Apparatus:
    1. Add to apparatus: [htm | txt]-tpl-apparatus.xsl add case to the ifs and for-each (3 places)
       - NOTE the app-link 'if' is checking for nested cases, therefore looking for ancestors.
    2. Indicator in text: [htm | txt]-element.xsl to add call-template to [htm | txt]-tpl-apparatus.xsl for links and/or stars.
    3. Add to ddbdp-app template below using local-name() to define context
  -->


   <!-- Defines the output of individual elements in apparatus -->
   <xsl:template name="ddbdp-app">
      <xsl:param name="apptype"/>
      <xsl:variable name="childtype">
         <xsl:choose>
            <xsl:when test="child::t:*[local-name()=('orig','sic','add','lem')]/t:choice[child::t:orig and child::t:reg]">
               <xsl:text>origreg</xsl:text>
            </xsl:when>
            <xsl:when test="child::t:*[local-name()=('orig','sic','add','lem')]/t:choice[child::t:sic and child::t:corr]">
               <xsl:text>siccorr</xsl:text>
            </xsl:when>
            <xsl:when test="child::t:*[local-name()=('orig','sic','add','lem')]/t:subst">
               <xsl:text>subst</xsl:text>
            </xsl:when>
            <xsl:when test="child::t:*[local-name()=('orig','sic','add','lem')]/t:app[@type='alternative']">
               <xsl:text>appalt</xsl:text>
            </xsl:when>
            <xsl:when test="child::t:*[local-name()=('orig','sic','add','lem')]/t:app[@type='editorial'][starts-with(@resp,'BL ')]">
               <xsl:text>appbl</xsl:text>
            </xsl:when>
            <xsl:when test="child::t:*[local-name()=('orig','sic','add','lem')]/t:app[@type='editorial'][starts-with(@resp,'PN ')]">
               <xsl:text>apppn</xsl:text>
            </xsl:when>
            <xsl:when test="child::t:*[local-name()=('orig','sic','add','lem')]/t:app[@type='editorial']">
               <xsl:text>apped</xsl:text>
            </xsl:when>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="div-loc">
         <xsl:for-each select="ancestor::t:div[@type='textpart'][@n]">
            <xsl:value-of select="@n"/>
            <xsl:text>.</xsl:text>
         </xsl:for-each>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="not(ancestor::t:choice or ancestor::t:subst or ancestor::t:app or
            ancestor::t:hi[@rend=('diaeresis','grave','acute','asper','lenis','circumflex')])">
            <!-- either <br/> in htm-tpl-apparatus or \r\n in txt-tpl-apparatus -->
            <xsl:call-template name="lbrk-app"/>
            <!-- in htm-tpl-apparatus.xsl or txt-tpl-apparatus.xsl -->
            <xsl:call-template name="app-link">
               <xsl:with-param name="location" select="'apparatus-link-back'"/>
            </xsl:call-template>
            <xsl:value-of select="$div-loc"/>
            <xsl:value-of select="preceding::t:*[local-name() = 'lb'][1]/@n"/>
            <xsl:if test="descendant::t:lb">
               <xsl:variable name="cnum">
                  <xsl:value-of select="preceding::t:*[local-name() = 'lb'][1]/@n"/>
               </xsl:variable>
               <xsl:if test="descendant::t:lb[position() = last()]/@n != $cnum">
                  <xsl:text>-</xsl:text>
                  <xsl:value-of select="descendant::t:lb[position() = last()]/@n"/>
               </xsl:if>
            </xsl:if>
            <xsl:text>. </xsl:text>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text> : </xsl:text>
         </xsl:otherwise>
      </xsl:choose>
      <span>
         <xsl:choose>
            <xsl:when test="local-name()=('choice','subst','app')">
               <!-- if there are more app elements inside the text part of the element, deal with them here -->
               <xsl:variable name="part1">
                  <xsl:if
                     test="child::t:*[local-name()=('orig','sic','add','lem')]/t:*[local-name()=('choice','subst','app')]">
                     <!-- <xsl:call-template name="txPtchild"> -->
                     <xsl:call-template name="appcontent">
                        <!-- template txPtchild below -->
                        <xsl:with-param name="apptype" select="$apptype"/>
                        <xsl:with-param name="childtype" select="$childtype" />
                     </xsl:call-template>
                  </xsl:if>
               </xsl:variable>
               <xsl:variable name="part2">
                  <xsl:if
                     test="child::t:*[local-name()=('orig','sic','add','lem')]/t:*[local-name()=('choice','subst','app')]">
                     <xsl:call-template name="nonTxPtchild">
                        <!-- template nonTxPtchild below -->
                        <xsl:with-param name="apptype" select="$apptype"/>
                        <xsl:with-param name="childtype" select="$childtype" />
                     </xsl:call-template>
                  </xsl:if>
               </xsl:variable>
               <!-- generate the main content of the app here -->
               <xsl:variable name="part3">
                  <xsl:call-template name="appcontent">
                     <xsl:with-param name="apptype" select="$apptype"/>
                  </xsl:call-template>
               </xsl:variable>
               <xsl:variable name="part4">
                  <xsl:call-template name="nonTxPtchild">
                     <xsl:with-param name="apptype" select="$apptype"/>
                  </xsl:call-template>
               </xsl:variable>
               <xsl:variable name="titleagg">
                  <xsl:choose>
                     <xsl:when test="$apptype=('appbl','apppn','apped')">
                           <xsl:choose>
                              <xsl:when test="($childtype = '' and normalize-space($part4) = '') or ($childtype != '' and normalize-space($part2) = '')"><xsl:call-template name="fnord-seperator">
                                    <xsl:with-param name="part"><xsl:value-of select="$part3" /></xsl:with-param>
                                    <xsl:with-param name="pos">first</xsl:with-param>
                                 </xsl:call-template></xsl:when>
                              <xsl:when test="contains($part3, ' : ') and lem/@resp"><xsl:value-of select="substring-before($part3, ' :')"/></xsl:when>
                              <xsl:otherwise>Current edition</xsl:otherwise>
                           </xsl:choose>
                          <!-- <xsl:if test="starts-with(normalize-space($part3), 'cf.')"> which</xsl:if> -->
                        <xsl:choose>
                           <xsl:when test="$childtype='subst'"> reports </xsl:when>
                           <xsl:otherwise> gives </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                           <xsl:when test="$childtype = 'subst'"><xsl:value-of select="normalize-space($part1)" />, then changed to <xsl:value-of select="normalize-space($part2)" /></xsl:when>
                           <xsl:when test="$childtype != ''"><xsl:value-of select="normalize-space($part2)" /><xsl:text>, </xsl:text><xsl:value-of select="normalize-space($part1)" /></xsl:when>
                           <xsl:otherwise><xsl:value-of select="normalize-space($part4)"/></xsl:otherwise>
                        </xsl:choose><xsl:call-template name="fnord-seperator">
                           <xsl:with-param name="part"><xsl:value-of select="$part3" /></xsl:with-param>
                           <xsl:with-param name="pos">second</xsl:with-param>
                        </xsl:call-template>
                     </xsl:when>
                     <xsl:when test="$apptype = 'subst'">
                        <xsl:choose>
                           <xsl:when test="count(tokenize($part3, 'corr. ex')) > 2">
                              <xsl:variable name="bracketed" select="normalize-space(substring-before(substring-after($part3, '('), ')'))" />
                              Scribe wrote <xsl:value-of select="substring-after($bracketed, 'corr. ex ')" /> <xsl:value-of select="normalize-space(replace(substring-before($part3, '('), 'corr. ex', ', then changed to'))" />
                           </xsl:when>
                           <xsl:otherwise><xsl:value-of select="normalize-space($part3)"/></xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                           <xsl:when test="$childtype != ''"><xsl:value-of select="normalize-space($part2)" /><xsl:if test="(not(ends-with(normalize-space($part2), ',')))">,</xsl:if><xsl:text> </xsl:text><xsl:value-of select="normalize-space($part1)" /></xsl:when>
                           <xsl:otherwise><xsl:if test="(not(ends-with(normalize-space($part3), ',')))">,</xsl:if> then changed to <xsl:value-of select="normalize-space($part4)"/></xsl:otherwise>
                        </xsl:choose>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:choose>
                           <xsl:when test="contains($part3, 'FNORD-SPLIT') and contains($part1, 'FNORD-SPLIT') and $childtype != ''">
                              <xsl:call-template name="childpart">
                                 <xsl:with-param name="childtype"><xsl:value-of select="$childtype" /></xsl:with-param>
                                 <xsl:with-param name="apptype"><xsl:value-of select="$apptype" /></xsl:with-param>
                                 <xsl:with-param name="part1"><xsl:value-of select="$part1" /></xsl:with-param>
                                 <xsl:with-param name="part2"><xsl:value-of select="$part2" /></xsl:with-param>
                              </xsl:call-template><xsl:call-template name="fnord-seperator">
                                 <xsl:with-param name="part"><xsl:value-of select="$part3" /></xsl:with-param>
                                 <xsl:with-param name="pos">second</xsl:with-param>
                              </xsl:call-template>
                           </xsl:when>
                           <xsl:when test="contains($part3, 'FNORD-SPLIT')">
                              <xsl:choose>
                                 <xsl:when test="$childtype != ''"><xsl:value-of select="normalize-space($part2)" /><xsl:text> </xsl:text><xsl:value-of select="normalize-space($part1)" /><xsl:if test="not(ends-with(normalize-space($part1), ',')) and not($apptype = 'appalt' and $childtype = '')">,</xsl:if></xsl:when>
                                 <xsl:otherwise><xsl:if test="$apptype = 'appalt' and $childtype = ''">Scribe wrote</xsl:if> <xsl:value-of select="normalize-space($part4)"/><xsl:if test="not(ends-with(normalize-space($part4), ',')) and not($apptype = 'appalt' and $childtype = '')">,</xsl:if></xsl:otherwise>
                              </xsl:choose><xsl:text> </xsl:text>
                              <xsl:variable name="pt3">
                                 <xsl:call-template name="fnord-seperator">
                                    <xsl:with-param name="part"><xsl:value-of select="$part3" /></xsl:with-param>
                                    <xsl:with-param name="pos">first</xsl:with-param>
                                 </xsl:call-template>
                              </xsl:variable>
                              <xsl:choose>
                                 <xsl:when test="$apptype = 'appalt'">
                                    <xsl:choose>
                                       <xsl:when test="contains($part3, 'l.')"><xsl:text>, </xsl:text><xsl:value-of select="normalize-space(substring-after(substring-before($part3, ')'), ' ('))"/><xsl:text> </xsl:text><xsl:value-of select="normalize-space(substring-before($part3, ' ('))"/></xsl:when>
                                       <xsl:otherwise><xsl:value-of select="normalize-space($part3)"/></xsl:otherwise>
                                    </xsl:choose>
                                 </xsl:when>
                                 <xsl:otherwise><xsl:if test="$apptype='origreg'">for which </xsl:if><xsl:value-of select="$pt3" /></xsl:otherwise>
                              </xsl:choose>
                           </xsl:when>
                           <xsl:when test="contains($part1, 'FNORD-SPLIT')">
                              <xsl:call-template name="childpart">
                                 <xsl:with-param name="childtype"><xsl:value-of select="$childtype" /></xsl:with-param>
                                 <xsl:with-param name="apptype"><xsl:value-of select="$apptype" /></xsl:with-param>
                                 <xsl:with-param name="part1"><xsl:value-of select="$part1" /></xsl:with-param>
                                 <xsl:with-param name="part2"><xsl:value-of select="$part2" /></xsl:with-param>
                              </xsl:call-template>
                              <xsl:choose>
                                 <xsl:when test="contains($part3, 'l.') and $apptype = 'appalt'"><xsl:text>, </xsl:text>
                                    <xsl:value-of select="normalize-space(substring-after(substring-before($part3, ')'), ' ('))"/><xsl:text> </xsl:text><xsl:value-of select="normalize-space(substring-before($part3, ' ('))"/>
                                 </xsl:when>
                                 <xsl:otherwise><xsl:value-of select="normalize-space($part3)"/></xsl:otherwise>
                              </xsl:choose>
                           </xsl:when>
                           <xsl:otherwise>
                              <xsl:if test="($apptype = ('appalt') and $childtype = '') or $childtype = ('appalt')">Scribe wrote </xsl:if>
                              <xsl:choose>
                                 <xsl:when test="$childtype='subst'"><xsl:value-of select="normalize-space($part1)" />, then changed to <xsl:value-of select="normalize-space($part2)" /><xsl:if test="(not(ends-with(normalize-space($part2), ',')))">,</xsl:if></xsl:when>
                                 <xsl:when test="$childtype != ''"><xsl:value-of select="normalize-space($part2)" /><xsl:text> </xsl:text><xsl:value-of select="normalize-space($part1)" /><xsl:if test="(not(ends-with(normalize-space($part1), ',')) and $apptype != 'appalt')">,</xsl:if></xsl:when>
                                 <xsl:otherwise><xsl:value-of select="normalize-space($part4)"/><xsl:if test="(not(ends-with(normalize-space($part4), ',')) and $apptype != 'appalt')">,</xsl:if></xsl:otherwise>
                              </xsl:choose><xsl:text> </xsl:text>
                              <xsl:choose>
                                 <xsl:when test="contains($part3, 'l.') and ($apptype = 'appalt' and $childtype != '')"><xsl:text>, </xsl:text><xsl:value-of select="normalize-space(substring-before($part3, ' ('))"/><xsl:text> </xsl:text><xsl:value-of select="normalize-space(substring-after(substring-before($part3, ')'), ' ('))"/></xsl:when>
                                 <xsl:otherwise><xsl:value-of select="normalize-space($part3)"/></xsl:otherwise>
                              </xsl:choose>
                           </xsl:otherwise>
                        </xsl:choose>
                     </xsl:otherwise>
                  </xsl:choose>
                <!--  </xsl:if>  -->
               </xsl:variable>
               <xsl:variable name="title">
                  <xsl:call-template name="title-convert">
                     <xsl:with-param name="apptype" select="$apptype"/>
                     <xsl:with-param name="childtype" select="$childtype"/>
                     <xsl:with-param name="obf" select="normalize-space($titleagg)"/>
                  </xsl:call-template>
               </xsl:variable>
              <xsl:attribute name="title"><xsl:apply-templates select="$title" mode="sqbrackets"/></xsl:attribute>
               <!-- Parse app content to include html elements see: https://github.com/DCLP/dclpxsltbox/issues/137 -->
               <xsl:call-template name="parse-app-parts"><xsl:with-param name="part" select="$part1"/></xsl:call-template><xsl:if test="normalize-space($part1) != '' and (not(ends-with(normalize-space($part1), ','))) and (not(ends-with(normalize-space($part1), '.')))">,</xsl:if><!--  --><xsl:text> </xsl:text><xsl:call-template name="parse-app-parts"><xsl:with-param name="part" select="$part3"/></xsl:call-template>
            </xsl:when>
            <xsl:when test="local-name() = 'w'">
                <xsl:call-template name="word"/>
            </xsl:when>
            <!-- hi -->
            <xsl:when test="local-name() = 'hi'">
               <xsl:call-template name="hirend"/>
            </xsl:when>

            <!-- g -->
            <xsl:when test="local-name() = 'g'">
               <xsl:call-template name="grend"/>
            </xsl:when>

            <!-- del -->
            <xsl:when test="local-name() = 'del'">
               <xsl:choose>
                  <xsl:when test="@rend = 'slashes'">
                     <xsl:text>Text canceled with slashes</xsl:text>
                  </xsl:when>
                  <xsl:when test="@rend = 'cross-strokes'">
                     <xsl:text>Text canceled with cross-strokes</xsl:text>
                  </xsl:when>
                  <xsl:when test="@rend = 'parens'">
                     <xsl:text>Text canceled by enclosure within parentheses</xsl:text>
                  </xsl:when>
               </xsl:choose>
            </xsl:when>

            <xsl:when test="local-name() = 'milestone'">
               <xsl:if test="@rend = 'box'">
                  <xsl:text>Text in box.</xsl:text>
               </xsl:if>
            </xsl:when>
         </xsl:choose>
      </span>
   </xsl:template>

   <!-- Parse app content to include html elements see: https://github.com/DCLP/dclpxsltbox/issues/137 -->
   <xsl:template name="parse-app-parts">
      <xsl:param name="part" xml:space="preserve"/>
      <xsl:choose>
         <xsl:when test="matches(normalize-space($part),'FNORD(\S)*')"><xsl:value-of select="normalize-space(replace(replace($part, 'FNORD(\S)*', ''), '\(\*\)', ''))"/></xsl:when>
         <xsl:otherwise>
            <xsl:for-each select="$part/node() | $part/text()">
               <xsl:choose>
                  <xsl:when test="matches(normalize-space(.),'FNORD(\S)*')"><xsl:value-of select="normalize-space(replace(replace(., 'FNORD(\S)*', ''), '\(\*\)', ''))"/></xsl:when>
                  <xsl:when test="position() = last()">
                     <xsl:for-each select=".">
                        <xsl:choose>
                           <xsl:when test="self::text()">
                              <xsl:choose>
                                 <xsl:when test="position() = last()">
                                    <xsl:value-of select="replace(.,'\s+$','')"/>
                                 </xsl:when>
                                 <xsl:otherwise>
                                    <xsl:copy xml:space="preserve"/>
                                 </xsl:otherwise>
                              </xsl:choose>
                           </xsl:when>
                           <xsl:when test="name(.)='span'">
                              <xsl:element name="{name(.)}">
                                 <xsl:copy-of select="@*"/>
                                 <xsl:call-template name="parse-app-parts">
                                    <xsl:with-param name="part" select="." xml:space="preserve"/>
                                 </xsl:call-template>
                              </xsl:element>
                           </xsl:when>
                           <xsl:otherwise>
                              <xsl:call-template name="parse-app-parts">
                                 <xsl:with-param name="part" select="." xml:space="preserve"/>
                              </xsl:call-template>
                           </xsl:otherwise>
                        </xsl:choose>
                     </xsl:for-each>
                  </xsl:when>
                  <xsl:when test="name(.)='span'">
                     <xsl:element name="{name(.)}">
                        <xsl:copy-of select="@*"/>
                        <xsl:call-template name="parse-app-parts">
                           <xsl:with-param name="part" select="." xml:space="preserve"/>
                        </xsl:call-template>
                     </xsl:element>
                  </xsl:when>
                  <xsl:when test="self::text()">
                     <xsl:copy xml:space="preserve"/>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:call-template name="parse-app-parts">
                        <xsl:with-param name="part" select="." xml:space="preserve"/>
                     </xsl:call-template>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:for-each>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <xsl:template name="nonTxPtchild">
      <!-- prints the other bit of apparatus content for apps nested in the part of an app not normally printed in edition -->
      <xsl:param name="apptype"/>
      <xsl:param name="childtype"/>

      <xsl:choose>
         <!-- *APPED* -->
         <xsl:when test="$apptype=('appbl','apppn','apped')">
             <xsl:apply-templates select="child::t:*[local-name()=('orig','sic','add','lem')]">
                <xsl:with-param name="location" select="'apparatus'" tunnel="yes"/>
             </xsl:apply-templates>
         </xsl:when>
         <!-- *ORIG*  (repeatable) -->
         <xsl:when test="$childtype='origreg' or ($apptype='origreg' and $childtype='')">
            <xsl:text>for which read </xsl:text>
            <xsl:if test="$childtype != ''">
               <xsl:for-each select="child::t:*[local-name()=('orig','sic','add','lem')]/t:choice/t:orig">
                  <xsl:sort select="position()" order="descending"/>
                  <!-- <xsl:value-of select="."/> -->
                  <xsl:apply-templates>
                     <xsl:with-param name="location" select="'apparatus'" tunnel="yes"/>
                  </xsl:apply-templates>
               </xsl:for-each>
            </xsl:if>
            <xsl:if test="$childtype = ''">
              <xsl:for-each select="t:orig">
                  <xsl:sort select="position()" order="descending"/>
                  <!-- <xsl:value-of select="."/> -->
                  <xsl:apply-templates>
                     <xsl:with-param name="location" select="'apparatus'" tunnel="yes"/>
                  </xsl:apply-templates>
              </xsl:for-each>
            </xsl:if>
         </xsl:when>
         <!-- *SIC* -->
         <xsl:when test="$childtype=('siccorr') or $apptype=('siccorr')">
            <xsl:text>((for which read)) </xsl:text>
            <xsl:choose>
               <xsl:when test="child::t:*[local-name()=('orig','sic','add','lem')]/t:choice/t:sic/node()">
                  <xsl:apply-templates select="child::t:*[local-name()=('orig','sic','add','lem')]/t:choice/t:sic/node()">
                     <xsl:with-param name="location" select="'apparatus'" tunnel="yes"/>
                  </xsl:apply-templates>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:apply-templates select="child::t:*[local-name()=('orig','sic','add','lem')]">
                     <xsl:with-param name="location" select="'apparatus'" tunnel="yes"/>
                  </xsl:apply-templates>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:when>
         <!-- *SUBST* -->
         <xsl:when test="$childtype=('subst') or $apptype=('subst')">
            <xsl:apply-templates select="child::t:*[local-name()=('orig','sic','add','lem')]">
               <xsl:with-param name="location" select="'apparatus'" tunnel="yes"/>
            </xsl:apply-templates>
         </xsl:when>
         <!-- *APPALT* -->
         <xsl:when test="$childtype=('appalt') or $apptype=('appalt')">
            <xsl:apply-templates select="child::t:*[local-name()=('orig','sic','add','lem')]">
               <xsl:with-param name="location" select="'apparatus'" tunnel="yes"/>
            </xsl:apply-templates>
         </xsl:when>
         <!-- *APPED* -->
         <xsl:when test="$childtype=('appbl','apppn','apped')">
            <xsl:apply-templates select="child::t:*[local-name()=('orig','sic','add','lem')]">
               <xsl:with-param name="location" select="'apparatus'" tunnel="yes"/>
            </xsl:apply-templates>
         </xsl:when>
      </xsl:choose>
       <xsl:text> </xsl:text> <!---->
   </xsl:template>

   <xsl:template name="resolvesubst">
      <!-- Deals with old/new encoding of subst -->
      <!-- Used by: txPtchild, appcontent, teiaddanddel.xsl#t:add -->
      <xsl:param name="addpath" select="''"/>
      <xsl:param name="location" tunnel="yes" required="no"/>
      <xsl:param name="delpath"/>
     <xsl:choose>
         <!-- Old encoding: (still supported) -->
         <xsl:when test="(
            not(preceding-sibling::node())
            or matches(preceding-sibling::node()[1][self::text()], '[\s\n\r\t]')
            or preceding-sibling::node()[1][self::t:lb]
            )
            and
            (
            not(following-sibling::node())
            or matches(following-sibling::node()[1][self::text()], '[\s\n\r\t]')
            )
            and (child::t:*[local-name()=('orig','sic','add','lem')])
            ">
           <xsl:text>corr. ex </xsl:text>
           <xsl:call-template name="trans-string">
            <xsl:with-param name="trans-text">
              <xsl:apply-templates select="$delpath"/>
            </xsl:with-param>
           </xsl:call-template>         
         </xsl:when>    
         <!-- New encoding (introduced in Nov/Dec 2011) -->
         <!-- get full word -->
         <xsl:otherwise>
            <xsl:variable name="fullword">
               <xsl:call-template name="recurse_back">
                  <xsl:with-param name="step" select="preceding-sibling::node()[1]"/>
               </xsl:call-template>
               <xsl:apply-templates select="t:add/node()"/>
               <xsl:call-template name="recurse_forward">
                  <xsl:with-param name="step" select="following-sibling::node()[1]"/>
               </xsl:call-template>
            </xsl:variable>
            <xsl:value-of select="$fullword"/>
           <!-- <xsl:text> </xsl:text> -->
            <!-- Check that $addpath has been passed (might be excluded, see template matching t:add in teiaddanddel.xsl-->
            <xsl:choose>
               <xsl:when test="$addpath=''"/>
               <xsl:otherwise><xsl:call-template name="trans-string">
                     <xsl:with-param name="trans-text">
                        <xsl:apply-templates select="$addpath"/>
                     </xsl:with-param>
                  </xsl:call-template><xsl:text> </xsl:text>
               </xsl:otherwise>
            </xsl:choose><xsl:text>corr. ex </xsl:text>
            <xsl:call-template name="trans-string">
               <xsl:with-param name="trans-text">
                  <xsl:apply-templates select="$delpath"/>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:otherwise>
      </xsl:choose></xsl:template>

   <xsl:template name="appcontent">
      <!-- prints the content of apparatus; called by ddb-apparatus or by individual elements if nested -->
      <xsl:param name="apptype"/>
      <xsl:param name="childtype"/>


      <xsl:variable name="path">
         <xsl:choose>
            <xsl:when test="$childtype='origreg' or $childtype=('siccorr')">
               <xsl:copy-of select="child::t:*[local-name()=('orig','sic','add','lem')]/t:choice/child::*"/>
            </xsl:when>
            <xsl:when test="$childtype='subst'">
               <xsl:copy-of select="child::t:*[local-name()=('orig','sic','add','lem')]/t:subst/child::*"/>
            </xsl:when>
            <xsl:when test="$childtype='appalt'">
               <xsl:copy-of select="child::t:*[local-name()=('orig','sic','add','lem')]/t:app[@type='alternative']/child::*"/>
            </xsl:when>
            <xsl:when test="$childtype=('appbl','apppn','apped')">
               <xsl:copy-of select="child::t:*[local-name()=('orig','sic','add','lem')]/t:app[@type='editorial']/child::*"/>
            </xsl:when>
            <!-- <xsl:when test="$apptype=('siccorr')"><xsl:value-of select="t:corr/node()"/></xsl:when> -->
            <xsl:otherwise>
               <xsl:copy-of select="node()"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>

      <!--*!'<xsl:value-of select="$path"/>'  -  Childtype: '<xsl:value-of select="$childtype"/>' - Apptype: '<xsl:value-of select="$apptype"/>'
         <xsl:for-each select="$path/*">
         <xsl:value-of select="name()" />:
         <xsl:for-each select="child::*">
            '<xsl:value-of select="name()" /> - <xsl:value-of select="." />'

         </xsl:for-each>
      </xsl:for-each>-->
  <!--    !*

      **<xsl:value-of select="$apptype"/> - <xsl:value-of select="$childtype"/>**-->

      <xsl:variable name="parent-lang">
      <xsl:if test="(child::t:*[local-name()=('orig','sic','add','lem')]/t:choice/child::t:reg[@xml:lang] and $childtype = 'origreg') or (child::t:reg[@xml:lang] and $apptype = 'origreg')">
         <xsl:if test="$childtype = 'origreg'">
            <xsl:value-of select="child::t:*[local-name()=('orig','sic','add','lem')]/t:choice/child::t:reg/ancestor::t:*[@xml:lang][1]/@xml:lang" />
         </xsl:if>
         <xsl:if test="$apptype = 'origreg'">
            <xsl:value-of select="child::t:reg/ancestor::t:*[@xml:lang][1]/@xml:lang" />
         </xsl:if>
      </xsl:if>
      </xsl:variable>

      <xsl:choose>
         <xsl:when test="$childtype != '' and $apptype != $childtype">
            <xsl:call-template name="appchoice">
               <xsl:with-param name="apptype"><xsl:value-of select="$childtype"/></xsl:with-param>
               <xsl:with-param name="path"><xsl:copy-of select="$path"/></xsl:with-param>
               <xsl:with-param name="parent-lang"><xsl:value-of select="$parent-lang" /></xsl:with-param>
            </xsl:call-template><xsl:text> </xsl:text>
         </xsl:when>
         <xsl:otherwise>
            <xsl:call-template name="appchoice">
               <xsl:with-param name="apptype"><xsl:value-of select="$apptype"/></xsl:with-param>
               <xsl:with-param name="child"><xsl:if test="$childtype != ''">true</xsl:if></xsl:with-param>
               <xsl:with-param name="path"><xsl:copy-of select="$path"/></xsl:with-param>
               <xsl:with-param name="parent-lang"><xsl:value-of select="$parent-lang" /></xsl:with-param>
            </xsl:call-template>
         </xsl:otherwise>
      </xsl:choose>

      <!--
      <xsl:if test="$childtype != '' and $apptype != $childtype">
         {*{<xsl:call-template name="appchoice">
            <xsl:with-param name="apptype"><xsl:value-of select="$childtype"/></xsl:with-param>
            <xsl:with-param name="path"><xsl:copy-of select="$path"/></xsl:with-param>
         </xsl:call-template><xsl:text>, </xsl:text>}}
      </xsl:if>

      {'{<xsl:call-template name="appchoice">
         <xsl:with-param name="apptype"><xsl:value-of select="$apptype"/></xsl:with-param>
         <xsl:with-param name="child"><xsl:if test="$childtype != ''">true</xsl:if></xsl:with-param>
         <xsl:with-param name="path"><xsl:copy-of select="$path"/></xsl:with-param>
      </xsl:call-template>}}

      -->

<!--
 -->

     <!-- <xsl:choose> -->
         <!-- *REG*  (repeatable) -->
        <!-- <xsl:when test="($apptype='origreg' and $childtype='') or $childtype='origreg'"> -->
            <!--**REG - <xsl:value-of select="$path/t:reg"/>** -->
          <!--   <xsl:for-each select="$path/t:reg">
               <xsl:sort select="position()" order="descending"/>
               <xsl:call-template name="multreg"/>
            </xsl:for-each>
            <xsl:if test="$childtype != ''">
               <xsl:text>, </xsl:text>
            </xsl:if>
         </xsl:when> -->
         <!-- *CORR* -->
     <!--    <xsl:when test="$apptype=('siccorr')"> -->
            <!-- **CORR - <xsl:value-of select="$path/t:corr/node()"/>** -->
      <!--      <xsl:text>l. </xsl:text>
            <xsl:apply-templates select="$path/t:corr/node()"/>
            <xsl:text> (corr)</xsl:text>
         </xsl:when> -->
         <!-- *SUBST* -->
     <!--    <xsl:when test="($apptype='subst' and $childtype='') or $childtype='subst'"> -->
            <!-- **SUBST - <xsl:value-of select="$path/t:del/node()"/>/<xsl:value-of select="$path/t:add/node()"/>** -->
     <!--       <xsl:call-template name="resolvesubst">
               <xsl:with-param name="delpath" select="$path/t:del/node()"/>
               <xsl:with-param name="addpath" select="$path/t:add/node()"/>
            </xsl:call-template>
         </xsl:when> -->
         <!-- *ALT* (repeatable) -->
   <!--      <xsl:when test="$apptype='appalt'"> -->
            <!-- **ALT - <xsl:value-of select="$path/t:rdg"/>** -->
   <!--         <xsl:for-each select="$path/t:rdg">
               <xsl:if test="position()!=1">
                  <xsl:text>,</xsl:text>
               </xsl:if>
               <xsl:text> or </xsl:text>
               <xsl:if test="not(.//text())">
                  <xsl:text>not </xsl:text>
                  <xsl:apply-templates select="preceding-sibling::t:lem"/>
               </xsl:if>
               <xsl:apply-templates/>
            </xsl:for-each>
         </xsl:when> -->
         <!-- *ED* (repeatable) -->
   <!--      <xsl:when test="$apptype=('appbl','apppn','apped')">
            <xsl:if test="starts-with(t:lem/@resp,'BL ')">
               <xsl:if test="starts-with(substring-after(t:lem/@resp,'BL '),'cf.')">
                  <xsl:text> cf.</xsl:text>
               </xsl:if>
               <xsl:text> BL </xsl:text>
            </xsl:if>
            <xsl:choose>
               <xsl:when test="starts-with(substring-after(t:lem/@resp,'BL '),'cf.')">
                  <xsl:value-of select="substring-after(t:lem/@resp,'cf.')"/>
                  <xsl:text> : </xsl:text>
               </xsl:when>
               <xsl:when test="starts-with(t:lem/@resp,'BL ')">
                  <xsl:value-of select="substring-after(t:lem/@resp,'BL ')"/>
                  <xsl:text> : </xsl:text>
               </xsl:when>
               <xsl:when test="starts-with(t:lem/@resp,'PN ')">
                  <xsl:value-of select="substring-after(t:lem/@resp,'PN ')"/>
                  <xsl:text> (via PN) : </xsl:text>
               </xsl:when>
               <xsl:when test="t:lem/@resp">
                  <xsl:value-of select="t:lem/@resp"/>
                  <xsl:text> : </xsl:text>
               </xsl:when>
               <xsl:otherwise/>
            </xsl:choose>
            <xsl:for-each select="t:rdg"> -->
               <!-- found below -->
     <!--          <xsl:call-template name="app-ed-mult-with-param">
                  <xsl:with-param name="check">fnord</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
         </xsl:when>
      </xsl:choose> -->
   </xsl:template>

   <xsl:template name="appchoice">
      <xsl:param name="apptype" />
      <xsl:param name="child" />
      <xsl:param name="path" />
      <xsl:param name="parent-lang" />

      <!-- **<xsl:value-of select="$apptype"/> - <xsl:value-of select="$child"/>** -->

     <!-- {{ (<xsl:value-of select="$path/*" />)
            <xsl:for-each select="$path/*">
               <xsl:value-of select="name()" />:
               {<xsl:for-each select="child::*">
                  '<xsl:value-of select="name()" /> - <xsl:value-of select="." />'

               </xsl:for-each>}
            </xsl:for-each>}}-->
      <xsl:choose>
         <!-- *REG*  (repeatable) -->
         <xsl:when test="$apptype='origreg'">
            <!-- **REG - <xsl:value-of select="$path/t:reg"/>** -->
            <xsl:for-each select="$path/t:reg">
               <xsl:sort select="position()" order="descending"/>
               <!-- <xsl:value-of select="."/> -->
               <xsl:call-template name="multreg">
                  <xsl:with-param name="location" select="'apparatus'" tunnel="yes"/>
                  <xsl:with-param name="parent-lang"><xsl:value-of select="$parent-lang" /></xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
            <xsl:if test="$child != ''">
               <xsl:text>, </xsl:text>
            </xsl:if>
         </xsl:when>
         <!-- *CORR* -->
         <xsl:when test="$apptype=('siccorr')">
            <!-- **CORR - <xsl:value-of select="$path/t:corr/node()"/>** -->
            <xsl:text>l. </xsl:text>
            <xsl:apply-templates select="$path/t:corr/node()">
               <xsl:with-param name="location" select="'apparatus'" tunnel="yes"/>
            </xsl:apply-templates>
            <xsl:text> (corr)</xsl:text>
         </xsl:when>
         <!-- *SUBST* -->
         <xsl:when test="$apptype='subst'">
            <!--**SUBST - <xsl:value-of select="$path/t:del/node()"/>/<xsl:value-of select="$path/t:add/node()"/>** -->
            <xsl:call-template name="resolvesubst">
               <xsl:with-param name="location" select="'apparatus'" tunnel="yes"/>
               <xsl:with-param name="delpath" select="$path/t:del/node()"/>
               <xsl:with-param name="addpath" select="$path/t:add/node()"/>
            </xsl:call-template>
         </xsl:when>
         <!-- *ALT* (repeatable) -->
         <xsl:when test="$apptype='appalt'">
            <!-- **ALT - <xsl:value-of select="$path/t:rdg"/>** -->
            <xsl:for-each select="$path/t:rdg">
               <xsl:if test="position()!=1">
                  <xsl:text>,</xsl:text>
               </xsl:if>
               <xsl:text> or </xsl:text>
               <xsl:if test="(not(.//text())) and (not(.//t:gap))">
                  <xsl:text>not </xsl:text>
                  <xsl:apply-templates select="preceding-sibling::t:lem">
                     <xsl:with-param name="location" select="'apparatus'" tunnel="yes"/>
                  </xsl:apply-templates>
               </xsl:if>
               <xsl:apply-templates select=".">
                  <xsl:with-param name="location" select="'apparatus'" tunnel="yes"/>
               </xsl:apply-templates>
            </xsl:for-each>
         </xsl:when>
         <!-- *ED* (repeatable) -->
         <xsl:when test="$apptype=('appbl','apppn','apped')">
            <xsl:if test="starts-with($path/t:lem/@resp,'BL ')">
               <xsl:if test="starts-with(substring-after($path/t:lem/@resp,'BL '),'cf.')">
                  <xsl:text> cf.</xsl:text>
               </xsl:if>
               <xsl:text> BL </xsl:text>
            </xsl:if>
            <xsl:choose>
               <xsl:when test="starts-with(substring-after($path/t:lem/@resp,'BL '),'cf.')">
                  <xsl:value-of select="substring-after($path/t:lem/@resp,'cf.')"/>
                  <xsl:text> : </xsl:text>
               </xsl:when>
               <xsl:when test="starts-with($path/t:lem/@resp,'BL ')">
                  <xsl:value-of select="substring-after($path/t:lem/@resp,'BL ')"/>
                  <xsl:text> : </xsl:text>
               </xsl:when>
               <xsl:when test="starts-with($path/t:lem/@resp,'PN ')">
                  <xsl:value-of select="substring-after($path/t:lem/@resp,'PN ')"/>
                  <xsl:text> (via PN) : </xsl:text>
               </xsl:when>
               <xsl:when test="$path/t:lem/@resp">
                  <xsl:value-of select="$path/t:lem/@resp"/>
                  <xsl:text> : </xsl:text>
               </xsl:when>
               <xsl:otherwise/>
            </xsl:choose>
            <xsl:for-each select="$path/t:rdg">
               <!-- found below -->
               <xsl:call-template name="app-ed-mult-with-param">
                  <xsl:with-param name="check">fnord</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
         </xsl:when>
      </xsl:choose>
   </xsl:template>

   <!-- The recurse_* templates handle isolating the piece of text that will be printed in the apparatus,
        by finding the word breaks before and after it.-->
   <xsl:template name="recurse_back">
      <!-- Recurse through preceding sibling nodes until a space or carriage return is found -->
      <!-- Used by hirend, appcontent -->
      <!-- When used by hirend ($origin='hi'), will strip diacritics -->
      <xsl:param name="step"/>
      <xsl:param name="buildup"/>

      <xsl:variable name="origin" select="name()"/>
      <xsl:variable name="origin_id" select="generate-id()"/>

      <xsl:choose>
         <xsl:when test="$step[self::t:lb[not(@break='no')]]">
            <xsl:copy-of select="$buildup"/>
         </xsl:when>
         <xsl:when test="$step[self::text()]">
            <xsl:choose>
               <xsl:when test="matches($step, '[\s\n\r\t]')">
                 <xsl:choose>
                   <xsl:when test="string-length($buildup) = 0">
                     <xsl:choose>
                       <xsl:when test="$origin='hi'">
                         <xsl:call-template name="trans-string">
                           <xsl:with-param name="trans-text">
                             <xsl:call-template name="string-after-space">
                               <xsl:with-param name="test-string" select="$step"/>
                             </xsl:call-template>
                           </xsl:with-param>
                         </xsl:call-template>
                       </xsl:when>
                       <xsl:otherwise>
                         <xsl:call-template name="string-after-space">
                           <xsl:with-param name="test-string" select="$step"/>
                         </xsl:call-template>
                       </xsl:otherwise>
                     </xsl:choose>
                   </xsl:when>
                   <xsl:otherwise><xsl:copy-of select="$buildup"/></xsl:otherwise>
                 </xsl:choose>
               </xsl:when>
               <!-- if the text node is a first child and a space hasn't been located yet... -->
               <xsl:when test="not($step/preceding-sibling::node()[1])">
                  <xsl:variable name="temp-buildup">
                     <xsl:choose>
                        <xsl:when test="$origin='hi'">
                           <xsl:call-template name="trans-string">
                              <xsl:with-param name="trans-text">
                                 <xsl:call-template name="string-after-space">
                                    <xsl:with-param name="test-string" select="$step"/>
                                 </xsl:call-template>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:when>
                        <xsl:otherwise>
                           <xsl:call-template name="string-after-space">
                              <xsl:with-param name="test-string" select="$step"/>
                           </xsl:call-template>
                        </xsl:otherwise>
                     </xsl:choose>
                     <xsl:copy-of select="$buildup"/>
                  </xsl:variable>

                  <xsl:for-each select="$step/ancestor::*[preceding-sibling::node()][1]">
                     <xsl:call-template name="recurse_back">
                        <xsl:with-param name="step" select="preceding-sibling::node()[1]"/>
                        <xsl:with-param name="buildup" select="$temp-buildup"/>
                     </xsl:call-template>
                  </xsl:for-each>

               </xsl:when>
               <xsl:otherwise>
                  <xsl:variable name="temp-buildup">
                     <xsl:choose>
                        <xsl:when test="$origin='hi'">
                           <xsl:call-template name="trans-string">
                              <xsl:with-param name="trans-text">
                                 <xsl:call-template name="string-after-space">
                                    <xsl:with-param name="test-string" select="$step"/>
                                 </xsl:call-template>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:when>
                        <xsl:otherwise>
                           <xsl:call-template name="string-after-space">
                              <xsl:with-param name="test-string" select="$step"/>
                           </xsl:call-template>
                        </xsl:otherwise>
                     </xsl:choose>
                     <xsl:copy-of select="$buildup"/>
                  </xsl:variable>
                  <xsl:call-template name="recurse_back">
                     <xsl:with-param name="step" select="$step/preceding-sibling::node()[1]"/>
                     <xsl:with-param name="buildup" select="$temp-buildup"/>
                  </xsl:call-template>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:when>
         <!-- if the element is nested and a space hasn't been located yet... -->
         <xsl:when test="not($step/preceding-sibling::node()[1])">
            <xsl:for-each select="$step/ancestor::*[preceding-sibling::node()][1]">
               <xsl:call-template name="recurse_back">
                  <xsl:with-param name="step" select="preceding-sibling::node()[1]"/>
                  <xsl:with-param name="buildup" select="$buildup"/>
               </xsl:call-template>
            </xsl:for-each>
         </xsl:when>
         <xsl:when test="$step/preceding-sibling::node()[1][self::t:lb][not(@break='no')]"/>
         <xsl:otherwise>
            <xsl:choose>
               <xsl:when test="$step[self::t:hi]">
                  <xsl:call-template name="recurse_back">
                     <xsl:with-param name="step" select="$step/preceding-sibling::node()[1]"/>
                  </xsl:call-template>
                  <xsl:for-each select="$step">
                     <xsl:call-template name="hirend_print"/>
                  </xsl:for-each>
                  <xsl:copy-of select="$buildup"/>
               </xsl:when>
               <xsl:when test="$step[self::t:subst]">
                  <xsl:call-template name="recurse_back">
                     <xsl:with-param name="step" select="$step/preceding-sibling::node()[1]"/>
                  </xsl:call-template>
                  <xsl:call-template name="trans-string">
                     <xsl:with-param name="trans-text">
                        <xsl:apply-templates select="$step//t:add/node()"/>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:copy-of select="$buildup"/>
               </xsl:when>
               <xsl:when test="($step[self::text] or $step[self::*]) and matches($step, '[\s\n\r\t]')">
                  <xsl:variable name="builddown">
                     <xsl:call-template name="recurse_down_back">
                        <xsl:with-param name="step" select="$step"/>
                        <xsl:with-param name="buildup" select="$buildup"/>
                        <xsl:with-param name="origin" select="$origin"/>
                     </xsl:call-template>
                  </xsl:variable>
                 <xsl:apply-templates select="$builddown/node()"/>
                  <xsl:copy-of select="$buildup"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:variable name="temp-buildup">
                     <xsl:choose>
                        <xsl:when test="$step/t:hi[generate-id()=$origin_id]"/>
                        <xsl:when test="$step/t:hi">
                           <xsl:for-each select="$step/t:hi">
                              <xsl:call-template name="hirend_print"/>
                           </xsl:for-each>
                        </xsl:when>
                        <xsl:otherwise>
                           <xsl:apply-templates select="$step">
                              <xsl:with-param name="location" select="'apparatus'" tunnel="yes"/>
                           </xsl:apply-templates>
                        </xsl:otherwise>
                     </xsl:choose>
                     <xsl:copy-of select="$buildup"/>
                  </xsl:variable>
                  <xsl:call-template name="recurse_back">
                     <xsl:with-param name="step" select="$step/preceding-sibling::node()[1]"/>
                     <xsl:with-param name="buildup" select="$temp-buildup"/>
                  </xsl:call-template>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:otherwise>
      </xsl:choose>

   </xsl:template>

   <xsl:template name="recurse_down_back">
      <!-- Recurse through child nodes until a space or carriage return is found. Re-create elements when necessary -->
      <!-- Used by recurse_back -->
      <!-- Handles buildup for right-to-left space/return search -->
      <xsl:param name="step"/>
      <xsl:param name="buildup"/>
      <xsl:param name="origin"/>

      <xsl:choose>
         <xsl:when test="$step[self::text()]">
            <xsl:choose>
               <xsl:when test="$origin='hi'">
                  <xsl:call-template name="trans-string">
                     <xsl:with-param name="trans-text">
                        <xsl:call-template name="string-after-space">
                           <xsl:with-param name="test-string" select="$step"/>
                        </xsl:call-template>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:call-template name="string-after-space">
                     <xsl:with-param name="test-string" select="$step"/>
                  </xsl:call-template>
               </xsl:otherwise>
            </xsl:choose>
            <xsl:copy-of select="buildup"/>
         </xsl:when>
         <xsl:when test="$step[self::t:hi]">
            <xsl:for-each select="$step">
               <xsl:call-template name="hirend_print"/>
            </xsl:for-each>
            <xsl:copy-of select="$buildup"/>
         </xsl:when>
         <!-- Special handling for t:orig -->
         <xsl:when test="$step[self::t:orig[parent::t:choice]]">
            <xsl:for-each select="$step/node()">
               <xsl:variable name="curstep-id" select="generate-id($step)"/>
               <xsl:choose>
                  <xsl:when test="matches(., '[\s\n\r\t]')"/>
                  <xsl:when test="following::text()[generate-id(ancestor::node()[1])=$curstep-id and matches(., '[\s\n\r\t]')]">
                     <xsl:call-template name="recurse_down_back">
                        <xsl:with-param name="step" select="following-sibling::node()[1]"/>
                        <xsl:with-param name="buildup" select="buildup"/>
                        <xsl:with-param name="origin" select="$origin"/>
                     </xsl:call-template>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:call-template name="recurse_down_back">
                        <xsl:with-param name="step" select="."/>
                        <xsl:with-param name="buildup" select="buildup"/>
                        <xsl:with-param name="origin" select="$origin"/>
                     </xsl:call-template>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:for-each>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$step/name()}" xmlns="http://www.tei-c.org/ns/1.0">
               <xsl:sequence select="$step/@*"/>
               <xsl:choose>
                  <xsl:when test="$step/text() and not($step/*)">
                     <xsl:choose>
                        <xsl:when test="$origin='hi'">
                           <xsl:call-template name="trans-string">
                              <xsl:with-param name="trans-text">
                                 <xsl:call-template name="string-after-space">
                                    <xsl:with-param name="test-string" select="$step/text()"/>
                                 </xsl:call-template>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:when>
                        <xsl:otherwise>
                           <xsl:call-template name="string-after-space">
                              <xsl:with-param name="test-string" select="$step/text()"/>
                           </xsl:call-template>
                        </xsl:otherwise>
                     </xsl:choose>
                     <xsl:copy-of select="buildup"/>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:for-each select="$step/node()">
                        <xsl:variable name="curstep-id" select="generate-id($step)"/>
                        <xsl:choose>
                           <xsl:when test="matches(., '[\s\n\r\t]')"/>
                           <xsl:when test="following::text()[generate-id(ancestor::node()[1])=$curstep-id and matches(., '[\s\n\r\t]')]">
                              <xsl:call-template name="recurse_down_back">
                                 <xsl:with-param name="step" select="following-sibling::node()[1]"/>
                                 <xsl:with-param name="buildup" select="buildup"/>
                                 <xsl:with-param name="origin" select="$origin"/>
                              </xsl:call-template>
                           </xsl:when>
                           <xsl:otherwise>
                              <xsl:call-template name="recurse_down_back">
                                 <xsl:with-param name="step" select="."/>
                                 <xsl:with-param name="buildup" select="buildup"/>
                                 <xsl:with-param name="origin" select="$origin"/>
                              </xsl:call-template>
                           </xsl:otherwise>
                        </xsl:choose>
                     </xsl:for-each>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <xsl:template name="recurse_forward">
      <!-- Recurse through following sibling nodes until a space or carriage return is found -->
      <!-- Used by hirend, appcontent -->
      <xsl:param name="step"/>

      <xsl:variable name="origin" select="name()"/>
      <xsl:variable name="origin_id" select="generate-id()"/>
      <xsl:choose>
         <xsl:when test="$step[self::t:lb[not(@break='no')]]"/>
         <xsl:when test="$step[self::text()]">
            <xsl:choose>
               <xsl:when test="matches($step, '[\s\n\r\t]')">
                  <xsl:choose>
                     <xsl:when test="$origin='hi'">
                        <xsl:call-template name="trans-string">
                           <xsl:with-param name="trans-text">
                              <xsl:call-template name="string-before-space">
                                 <xsl:with-param name="test-string" select="$step"/>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:call-template name="string-before-space">
                           <xsl:with-param name="test-string" select="$step"/>
                        </xsl:call-template>
                     </xsl:otherwise>
                  </xsl:choose>
               </xsl:when>
               <!-- if the text node is a first child and a space hasn't been located yet... -->
               <xsl:when test="not($step/preceding-sibling::node()[1])">
                  <xsl:choose>
                     <xsl:when test="$origin='hi'">
                        <xsl:call-template name="trans-string">
                           <xsl:with-param name="trans-text">
                              <xsl:call-template name="string-before-space">
                                 <xsl:with-param name="test-string" select="$step"/>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:call-template name="string-before-space">
                           <xsl:with-param name="test-string" select="$step"/>
                        </xsl:call-template>
                     </xsl:otherwise>
                  </xsl:choose>
                  <xsl:for-each select="$step/ancestor::*[following-sibling::node()][1]">
                     <xsl:call-template name="recurse_forward">
                        <xsl:with-param name="step" select="following-sibling::node()[1]"/>
                     </xsl:call-template>
                  </xsl:for-each>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:choose>
                     <xsl:when test="$origin='hi'">
                        <xsl:call-template name="trans-string">
                           <xsl:with-param name="trans-text">
                              <xsl:call-template name="string-before-space">
                                 <xsl:with-param name="test-string" select="$step"/>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:call-template name="string-before-space">
                           <xsl:with-param name="test-string" select="$step"/>
                        </xsl:call-template>
                     </xsl:otherwise>
                  </xsl:choose>
                  <xsl:call-template name="recurse_forward">
                     <xsl:with-param name="step" select="$step/following-sibling::node()[1]"/>
                  </xsl:call-template>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:when>
         <!-- If there's no following step, and we're directly inside orig|reg|sic|corr|abbr|expan
              then we should assume we're at word-end and stop-->
         <xsl:when test="not($step/following-sibling::node()[1])">
            <xsl:if test="not($step/local-name() = ('orig','reg','sic','corr','abbr','expan'))">
               <xsl:choose>
                  <xsl:when test="$step/t:hi[generate-id()=$origin_id]"/>
                  <xsl:when test="$step/t:hi">
                     <xsl:for-each select="$step/t:hi">
                        <xsl:call-template name="hirend_print"/>
                     </xsl:for-each>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:apply-templates select="$step">
                        <xsl:with-param name="location" select="'apparatus'" tunnel="yes"/>
                     </xsl:apply-templates>
                  </xsl:otherwise>
               </xsl:choose>
               <xsl:for-each select="$step/ancestor::*[following-sibling::node()][1]">
                  <xsl:call-template name="recurse_forward">
                     <xsl:with-param name="step" select="following-sibling::node()[1]"/>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:if>
         </xsl:when>
         <xsl:otherwise>
            <xsl:choose>
               <xsl:when test="$step[self::t:hi]">
                  <xsl:for-each select="$step">
                     <xsl:call-template name="hirend_print"/>
                  </xsl:for-each>
                  <xsl:call-template name="recurse_forward">
                     <xsl:with-param name="step" select="$step/following-sibling::node()[1]"/>
                  </xsl:call-template>
               </xsl:when>
               <xsl:when test="$step[self::t:subst]">
                  <xsl:call-template name="trans-string">
                     <xsl:with-param name="trans-text">
                        <xsl:apply-templates select="$step//t:add/node()"/>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="recurse_forward">
                     <xsl:with-param name="step" select="$step/following-sibling::node()[1]"/>
                  </xsl:call-template>
               </xsl:when>
               <xsl:when test="($step[self::text] or $step[self::*]) and matches($step, '[\s\n\r\t]')">
                  <xsl:variable name="builddown">
                     <xsl:call-template name="recurse_down">
                        <xsl:with-param name="step" select="$step"/>
                        <xsl:with-param name="origin" select="$origin"/>
                     </xsl:call-template>
                  </xsl:variable>
                  <xsl:variable name="resolve">
                     <xsl:apply-templates select="$builddown/node()">
                        <xsl:with-param name="location" select="'apparatus'" tunnel="yes"/>
                     </xsl:apply-templates>
                  </xsl:variable>
                  <xsl:value-of select="$resolve"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:choose>
                     <xsl:when test="$step/t:hi[generate-id()=$origin_id]"/>
                     <xsl:when test="$step/t:hi">
                        <xsl:for-each select="$step/t:hi">
                           <xsl:call-template name="hirend_print"/>
                        </xsl:for-each>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:variable name="str">
                           <xsl:choose>
                              <xsl:when test="$step[self::t:hi]">
                                 <xsl:call-template name="hirend_print"/>
                              </xsl:when>
                              <xsl:otherwise>
                                 <xsl:call-template name="trans-string">
                                    <xsl:with-param name="trans-text">
                                       <xsl:apply-templates select="$step"/>
                                    </xsl:with-param>
                                 </xsl:call-template>
                              </xsl:otherwise>
                           </xsl:choose>
                        </xsl:variable>
                        <xsl:value-of select="$str"/>
                     </xsl:otherwise>
                  </xsl:choose>
                  <xsl:call-template name="recurse_forward">
                     <xsl:with-param name="step" select="$step/following-sibling::node()[1]"/>
                  </xsl:call-template>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:otherwise>
      </xsl:choose>

   </xsl:template>

   <xsl:template name="recurse_down">
      <!-- Recurse through child nodes until a space or carriage return is found. Re-create elements when necessary -->
      <!-- Used by recurse_forward -->
      <xsl:param name="step"/>
      <xsl:param name="origin"/>

      <xsl:choose>
         <xsl:when test="$step[self::text()]">
            <xsl:call-template name="trans-string">
               <xsl:with-param name="trans-text">
                  <xsl:call-template name="string-before-space">
                     <xsl:with-param name="test-string" select="$step"/>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:when>
         <xsl:when test="$step[self::t:hi]">
            <xsl:for-each select="$step">
               <xsl:call-template name="hirend_print"/>
            </xsl:for-each>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$step/name()}" xmlns="http://www.tei-c.org/ns/1.0">
               <xsl:sequence select="$step/@*"/>
               <xsl:choose>
                 <xsl:when test="local-name($step/node()[1]) = '' and matches($step/node()[1], '[\s\t\r\n]')">
                   <xsl:choose>
                     <xsl:when test="$origin='hi'">
                       <xsl:call-template name="trans-string">
                         <xsl:with-param name="trans-text">
                           <xsl:call-template name="string-before-space">
                             <xsl:with-param name="test-string" select="$step/node()[1]"/>
                           </xsl:call-template>
                         </xsl:with-param>
                       </xsl:call-template>
                     </xsl:when>
                     <xsl:otherwise>
                       <xsl:call-template name="string-before-space">
                         <xsl:with-param name="test-string" select="$step/node()[1]"/>
                       </xsl:call-template>
                     </xsl:otherwise>
                   </xsl:choose>
                 </xsl:when>
                  <xsl:when test="$step/text() and not($step/*)">
                     <xsl:choose>
                        <xsl:when test="$origin='hi'">
                           <xsl:call-template name="trans-string">
                              <xsl:with-param name="trans-text">
                                 <xsl:call-template name="string-before-space">
                                    <xsl:with-param name="test-string" select="$step/text()"/>
                                 </xsl:call-template>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:when>
                        <xsl:otherwise>
                           <xsl:call-template name="string-before-space">
                              <xsl:with-param name="test-string" select="$step/text()"/>
                           </xsl:call-template>
                        </xsl:otherwise>
                     </xsl:choose>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:for-each select="$step/node()">
                        <xsl:call-template name="recurse_down">
                           <xsl:with-param name="step" select="."/>
                           <xsl:with-param name="origin" select="$origin"/>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
  
   <xsl:template name="word">
     <!-- Allows apparatus-triggering features contained within a word (like <hi> and some <g>s
          to be wrapped together. -->
     <xsl:apply-templates mode="app-word"/>
     <xsl:call-template name="support"/>
   </xsl:template>
  
   <xsl:template match="t:hi" mode="app-word">
     <xsl:call-template name="hirend_print"/>
   </xsl:template>
  
  <xsl:template match="t:g" mode="app-word">
    <xsl:apply-templates select=".">
      <xsl:with-param name="location" select="'apparatus'" tunnel="yes"/>
    </xsl:apply-templates>
  </xsl:template>
  
  <xsl:template match="text()" mode="app-word">
    <xsl:call-template name="trans-string"/>
  </xsl:template>
  
  <xsl:template match="*" mode="app-word">
    <xsl:apply-templates select="."/>
  </xsl:template>

   <xsl:template name="hirend">
      <!-- prints the value of diacritical <hi> values, either in text (with full word context, called from teihi.xsl) or in app (highlighted character only) -->
      <xsl:param name="hicontext" select="'yes'"/>

      <xsl:if test="$hicontext != 'no'">
         <xsl:variable name="text-before">
            <xsl:choose>
               <xsl:when test="not(preceding-sibling::node()[1])">
                  <xsl:call-template name="recurse_back">
                     <xsl:with-param name="step" select="parent::*/preceding-sibling::node()[1]"/>
                  </xsl:call-template>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:call-template name="recurse_back">
                     <xsl:with-param name="step" select="preceding-sibling::node()[1]"/>
                  </xsl:call-template>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:variable>
         <!-- This removes unnecessary line breaks that could've come through -->
         <xsl:value-of select="normalize-space($text-before)"/>
      </xsl:if>

      <xsl:call-template name="hirend_print"/>

      <xsl:if test="$hicontext != 'no'">
         <xsl:choose>
            <xsl:when test="not(following-sibling::node()[1])">
               <xsl:call-template name="recurse_forward">
                  <xsl:with-param name="step" select="parent::*/following-sibling::node()[1]"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
               <xsl:call-template name="recurse_forward">
                  <xsl:with-param name="step" select="following-sibling::node()[1]"/>
               </xsl:call-template>
            </xsl:otherwise>
         </xsl:choose>
         <!-- found below: inserts "papyrus" or "ostrakon" depending on filename -->
         <xsl:call-template name="support"/>
      </xsl:if>
   </xsl:template>

   <xsl:template name="grend">
      <xsl:param name="gcontext" select="'yes'"/>

      <xsl:if test="$gcontext != 'no'">
         <xsl:variable name="text-before">
            <xsl:choose>
               <xsl:when test="not(preceding-sibling::node()[1])">
                  <xsl:call-template name="recurse_back">
                     <xsl:with-param name="step" select="parent::*/preceding-sibling::node()[1]"/>
                  </xsl:call-template>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:call-template name="recurse_back">
                     <xsl:with-param name="step" select="preceding-sibling::node()[1]"/>
                  </xsl:call-template>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:variable>
         <!-- This removes unnecessary line breaks that could've come through -->
         <xsl:value-of select="normalize-space(replace($text-before,'’|''',''))"/>
      </xsl:if>
      <xsl:apply-templates select=".">
         <xsl:with-param name="location" select="'apparatus'" tunnel="yes"/>
      </xsl:apply-templates>
      <xsl:if test="$gcontext != 'no'">
         <xsl:choose>
            <xsl:when test="not(following-sibling::node()[1])">
               <xsl:call-template name="recurse_forward">
                  <xsl:with-param name="step" select="parent::*/following-sibling::node()[1]"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
               <xsl:call-template name="recurse_forward">
                  <xsl:with-param name="step" select="following-sibling::node()[1]"/>
               </xsl:call-template>
            </xsl:otherwise>
         </xsl:choose>
         <!-- found below: inserts "papyrus" or "ostrakon" depending on filename -->
         <xsl:call-template name="support"/>
      </xsl:if>
   </xsl:template>

   <xsl:template name="hirend_print">
      <!-- Determines the value of diacritical <hi> values -->
      <!-- Used by hirend -->
     <xsl:choose>
       <xsl:when test="text()">
         <xsl:call-template name="trans-string"/>
       </xsl:when>
       <xsl:when test="t:gap">
         <xsl:if test="t:gap[@reason='lost']">
           <xsl:text>[</xsl:text>
         </xsl:if>
         <xsl:text>&#xa0;&#xa0;&#x323;</xsl:text>
       </xsl:when>
       <xsl:when test="t:hi">
         <xsl:for-each select="t:hi">
           <xsl:call-template name="hirend_print"/>
         </xsl:for-each>
       </xsl:when>
     </xsl:choose>
     <xsl:choose>
       <xsl:when test="@rend = 'diaeresis'"><xsl:text>̈</xsl:text></xsl:when>
       <xsl:when test="@rend = 'grave'"><xsl:text>̀</xsl:text></xsl:when>
       <xsl:when test="@rend = 'acute'"><xsl:text>́</xsl:text></xsl:when>
       <xsl:when test="@rend = 'asper'"><xsl:text>̔</xsl:text></xsl:when>
       <xsl:when test="@rend = 'lenis'"><xsl:text>̓</xsl:text></xsl:when>
       <xsl:when test="@rend = 'circumflex'"><xsl:text>͂</xsl:text></xsl:when>
     </xsl:choose>
     <xsl:if test="t:gap[@reason='lost']"><xsl:text>]</xsl:text></xsl:if>
   </xsl:template>

   <xsl:template name="multreg">
      <xsl:param name="location" tunnel="yes" required="no"/>
      <xsl:param name="parent-lang" />
      <!-- prints multiple regs in a single choice in sequence -->
      <xsl:choose>
         <xsl:when test="position()!=1">
            <xsl:text>i.e. </xsl:text>
         </xsl:when>
         <xsl:when test="@xml:lang != ancestor::t:*[@xml:lang][1]/@xml:lang or ($parent-lang != '' and @xml:lang != $parent-lang)">
            <xsl:text>i.e. </xsl:text>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text>l. </xsl:text>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:if test="@xml:lang != ancestor::t:*[@xml:lang][1]/@xml:lang or ($parent-lang != '' and @xml:lang != $parent-lang)">
         <xsl:call-template name="reglang">
            <xsl:with-param name="lang" select="@xml:lang"/>
         </xsl:call-template>
      </xsl:if>
      <xsl:apply-templates>
         <xsl:with-param name="location" select="'apparatus'" tunnel="yes"/>
      </xsl:apply-templates>
      <xsl:if test="position()!=last()">
         <xsl:text>, </xsl:text>
      </xsl:if>
   </xsl:template>

   <xsl:template name="reglang">
      <!-- test to insert language for multi-lang regs -->
      <xsl:param name="lang"/>
      <xsl:choose>
         <xsl:when test="$lang='grc'">
            <xsl:text> Greek </xsl:text>
         </xsl:when>
         <xsl:when test="$lang='la'">
            <xsl:text> Latin </xsl:text>
         </xsl:when>
         <xsl:when test="$lang='cop'">
            <xsl:text> Coptic </xsl:text>
         </xsl:when>
      </xsl:choose>
   </xsl:template>

   <xsl:template name="app-ed-mult">
      <xsl:call-template name="app-ed-mult-with-param">
         <xsl:with-param name="check"/>
      </xsl:call-template>
   </xsl:template>

   <xsl:template name="app-ed-mult-with-param">
      <xsl:param name="check"/>
      <xsl:if test="$check='fnord'">FNORD-SPLIT </xsl:if>
      <xsl:apply-templates>
         <xsl:with-param name="location" select="'apparatus'" tunnel="yes"/>
         <xsl:with-param name="check">fnord</xsl:with-param>
      </xsl:apply-templates>
      <xsl:if test="$check='fnord'"> FNORD-SPLIT </xsl:if>
      <xsl:if test="starts-with(@resp,'BL ')">
         <xsl:if test="starts-with(substring-after(@resp,'BL '),'cf.')">
            <xsl:text> cf.</xsl:text>
         </xsl:if>
         <xsl:text> BL</xsl:text>
      </xsl:if>
      <xsl:text> </xsl:text>
      <xsl:choose>
         <xsl:when test="starts-with(substring-after(@resp,'BL '),'cf.')">
            <xsl:value-of select="substring-after(@resp,'cf.')"/>
         </xsl:when>
         <xsl:when test="starts-with(@resp,'BL ')">
            <xsl:value-of select="substring-after(@resp,'BL ')"/>
         </xsl:when>
         <xsl:when test="starts-with(@resp,'PN ')">
            <xsl:value-of select="substring-after(@resp,'PN ')"/>
            <xsl:text> (via PN)</xsl:text>
         </xsl:when>
         <xsl:when test="string(@resp)">
            <xsl:value-of select="@resp"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text> prev. ed.</xsl:text>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:if test="position()!=last()">
         <xsl:text> : </xsl:text>
      </xsl:if>
   </xsl:template>

   <xsl:template name="string-after-space">
      <!-- finds all text content before hi up to the preceding space -->
      <xsl:param name="test-string"/>
      <xsl:choose>
         <xsl:when test="matches($test-string, '[\s\n\t\r]')">
            <xsl:call-template name="string-after-space">
               <xsl:with-param name="test-string" select="tokenize($test-string, '[\s\n\t\r]')[last()]"/>
            </xsl:call-template>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="$test-string"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <xsl:template name="string-before-space">
      <!-- finds all text content after hi up to the next space -->
      <xsl:param name="test-string"/>
      <xsl:choose>
         <xsl:when test="matches($test-string, '[\s\n\t\r]')">
            <xsl:call-template name="string-before-space">
               <xsl:with-param name="test-string" select="tokenize($test-string, '[\s\n\t\r]')[1]"/>
            </xsl:call-template>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="$test-string"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <xsl:template name="trans-string">
      <!-- transforms context of <hi> into lowercase unaccented for rendering in app -->
      <xsl:param name="trans-text" select="."/>
      <xsl:value-of select="replace(translate($trans-text, $all-grc, $grc-lower-strip),'''','')"/>
   </xsl:template>

   <xsl:template name="childCertainty">
      <!-- called in various places; adds (?) if certainty element applied -->
      <xsl:if test="child::t:certainty[@match='..']">
         <xsl:text>(?)</xsl:text>
      </xsl:if>
   </xsl:template>

   <xsl:template name="support">
      <!-- called by template "hirend" above; decides whether text support is "ostrakon" or other (prob. = "papyrus") -->
      <xsl:choose>
         <xsl:when test="starts-with(ancestor::t:TEI//t:idno[@type='filename'],'o.')">
            <xsl:text> ostrakon</xsl:text>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text> papyrus</xsl:text>
         </xsl:otherwise>
      </xsl:choose>

   </xsl:template>

   <xsl:template name="title-convert">
      <xsl:param name="obf"/>
      <xsl:param name="apptype"/>
      <xsl:param name="childtype"/>
      <xsl:variable name="scribeswitch">
         <xsl:choose>
            <xsl:when test="$apptype = 'subst' and $childtype != ''"><xsl:value-of select="replace($obf, 'for which read', ', then changed to')"/></xsl:when>
            <xsl:when test="$childtype != ''"><xsl:value-of select="replace($obf, 'for which read', 'Scribe wrote')"/></xsl:when>
            <xsl:when test="$apptype = 'origreg' and contains($obf, 'for which read') and not(contains($obf, ', for which read'))">
               <xsl:value-of select="replace($obf, 'for which read', 'Scribe wrote')"/></xsl:when>
            <xsl:when test="$apptype = 'siccorr'"><xsl:value-of select="replace($obf, '\(\(for which read\)\)', 'Scribe wrote')"/>
            </xsl:when>
            <xsl:otherwise><xsl:value-of select="$obf"/></xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="no-l">
         <xsl:choose>
            <xsl:when test="$apptype = 'siccorr'"><xsl:value-of select="substring-before(replace($scribeswitch, 'l\. ', 'for which correct to '), '(corr)')"
               /></xsl:when>
            <xsl:when test="$apptype = ('origreg', 'subst', 'appalt', 'apped')"><xsl:value-of select="replace($scribeswitch, 'l\. ', 'for which read ')"/></xsl:when>
            <xsl:when test="contains($scribeswitch, 'prev. ed.')"><xsl:value-of select="replace($scribeswitch, 'l\. ', 'for which read ')"/></xsl:when>
            <xsl:when test="$apptype = 'appbl'"><xsl:value-of select="replace($scribeswitch, 'l\. ', 'normalises to ')"/></xsl:when>
            <xsl:otherwise><xsl:value-of select="replace($scribeswitch, 'l\. ', 'Scribe wrote ')"
               /></xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="corrEx">
         <xsl:choose>
            <xsl:when test="$apptype = ('apped', 'apppn', 'appbl')"><xsl:value-of select="replace($no-l, 'corr. ex', 'scribe wrote')"/></xsl:when>
            <!-- <xsl:when test="contains($no-l, '( corr. ex')">Scribe wrote <xsl:value-of select="substring-before(substring-after($no-l, '( corr. ex'), ')')" /><xsl:value-of select="replace(substring-before($no-l, '( corr. ex'), 'corr. ex', ', then changed to ')" /></xsl:when> -->
            <xsl:otherwise><xsl:value-of select="replace($no-l, 'corr. ex', 'Scribe wrote')"/></xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="prevEd">
         <xsl:value-of select="replace($corrEx, 'prev. ed.', 'previous edition')"/>
      </xsl:variable>
      <xsl:variable name="cf">
         <xsl:value-of select="replace($prevEd, 'cf.', '')"/>
      </xsl:variable>
     <!-- <xsl:variable name="linebreaks">
         <xsl:value-of select="replace($cf, '-', '|')"/>
      </xsl:variable> -->
      <xsl:value-of select="normalize-space(replace($cf, '\(\*\)', ''))"/>
      <!-- <xsl:value-of select="$obf" /> --> <!--(<xsl:value-of select="$apptype"/> - <xsl:value-of select="$childtype"/>)  -->
   </xsl:template>

   <xsl:template name="fnord-seperator">
      <xsl:param name="part" />
      <xsl:param name="pos" /><xsl:choose>
               <xsl:when test="contains($part, 'FNORD-SPLIT') and contains($part, ' :') and contains($part, ' FNORD-DELIM') and starts-with($part, 'l. ')">
                  <xsl:for-each select="tokenize(substring-after($part, 'l. '), ' : ')">
                     <xsl:for-each select="tokenize(., ' FNORD-DELIM ')"><xsl:call-template name="fnord-spliter">
                           <xsl:with-param name="line">
                              <xsl:choose>
                                 <xsl:when test="starts-with(normalize-space(.), 'FNORD-SPLIT')"><xsl:value-of select="substring-after(. , 'FNORD-SPLIT')" /></xsl:when>
                                 <xsl:otherwise><xsl:value-of select="." /></xsl:otherwise>
                              </xsl:choose>
                           </xsl:with-param>
                           <xsl:with-param name="delim"><xsl:if test="$pos='second' or position() != 1">;</xsl:if></xsl:with-param>
                     </xsl:call-template></xsl:for-each>
                  </xsl:for-each>
               </xsl:when>
               <xsl:when test="contains($part, 'FNORD-SPLIT') and contains($part, ' :') and starts-with($part, 'l. ')">
                  <xsl:for-each select="tokenize(substring-after($part, 'l. '), ' : ')"><xsl:call-template name="fnord-spliter">
                        <xsl:with-param name="line">
                           <xsl:choose>
                              <xsl:when test="starts-with(normalize-space(.), 'FNORD-SPLIT')"><xsl:value-of select="substring-after(. , 'FNORD-SPLIT')" /></xsl:when>
                              <xsl:otherwise><xsl:value-of select="." /></xsl:otherwise>
                           </xsl:choose>
                        </xsl:with-param>
                        <xsl:with-param name="delim"><xsl:if test="$pos='second' or position() != 1">;</xsl:if></xsl:with-param>
                        <xsl:with-param name="tail">true</xsl:with-param></xsl:call-template>
                  </xsl:for-each>
               </xsl:when>
               <xsl:when test="contains($part, 'FNORD-SPLIT') and contains($part, ' :') and contains($part, ' FNORD-DELIM')">
                  <xsl:for-each select="tokenize($part, ' : ')"><xsl:for-each select="tokenize(., ' FNORD-DELIM ')"><xsl:call-template name="fnord-spliter">
                        <xsl:with-param name="line">
                           <xsl:choose>
                              <xsl:when test="starts-with(normalize-space(.), 'FNORD-SPLIT')"><xsl:value-of select="substring-after(. , 'FNORD-SPLIT')" /></xsl:when>
                              <xsl:otherwise><xsl:value-of select="." /></xsl:otherwise>
                           </xsl:choose>
                        </xsl:with-param>
                        <xsl:with-param name="delim"><xsl:if test="$pos='second' or position() != 1">;</xsl:if></xsl:with-param>
                     </xsl:call-template></xsl:for-each></xsl:for-each>
               </xsl:when>
               <xsl:when test="contains($part, 'FNORD-SPLIT') and contains($part, ' :')"><xsl:for-each select="tokenize($part, ' : ')"><xsl:call-template name="fnord-spliter">
                        <xsl:with-param name="line">
                           <xsl:choose>
                              <xsl:when test="starts-with(normalize-space(.), 'FNORD-SPLIT')"><xsl:value-of select="substring-after(. , 'FNORD-SPLIT')" /></xsl:when>
                              <xsl:otherwise><xsl:value-of select="." /></xsl:otherwise>
                           </xsl:choose>
                        </xsl:with-param>
                        <xsl:with-param name="delim"><xsl:if test="$pos='second' or position() != 1">;</xsl:if></xsl:with-param>
                     </xsl:call-template></xsl:for-each>
               </xsl:when>
               <xsl:when test="contains($part, 'FNORD-SPLIT') and contains($part, ' FNORD-DELIM') and starts-with($part, 'l. ')">
                  <xsl:for-each select="tokenize(substring-after($part, 'l. '), ' FNORD-DELIM ')"><xsl:call-template name="fnord-spliter">
                        <xsl:with-param name="line">
                           <xsl:choose>
                              <xsl:when test="starts-with(normalize-space(.), 'FNORD-SPLIT')"><xsl:value-of select="substring-after(. , 'FNORD-SPLIT')" /></xsl:when>
                              <xsl:otherwise><xsl:value-of select="." /></xsl:otherwise>
                           </xsl:choose>
                        </xsl:with-param>
                        <xsl:with-param name="delim"><xsl:if test="$pos='second' or position() != 1">;</xsl:if></xsl:with-param>
                        <xsl:with-param name="tail">true</xsl:with-param>
                     </xsl:call-template></xsl:for-each>
               </xsl:when>
               <xsl:when test="contains($part, 'FNORD-SPLIT') and contains($part, ' FNORD-DELIM')">
                  <xsl:for-each select="tokenize($part, ' FNORD-DELIM ')"><xsl:call-template name="fnord-spliter">
                        <xsl:with-param name="line">
                           <xsl:choose>
                              <xsl:when test="starts-with(normalize-space(.), 'FNORD-SPLIT')"><xsl:value-of select="substring-after(. , 'FNORD-SPLIT')" /></xsl:when>
                              <xsl:otherwise><xsl:value-of select="." /></xsl:otherwise>
                           </xsl:choose>
                        </xsl:with-param>
                        <xsl:with-param name="delim"><xsl:if test="$pos='second' or position() != 1">;</xsl:if></xsl:with-param>
                     </xsl:call-template></xsl:for-each>
               </xsl:when>
               <xsl:when test="contains($part, 'FNORD-SPLIT')"><xsl:call-template name="fnord-spliter">
                     <xsl:with-param name="line">
                        <xsl:choose>
                           <xsl:when test="starts-with(normalize-space($part), 'FNORD-SPLIT')"><xsl:value-of select="substring-after($part , 'FNORD-SPLIT')" /></xsl:when>
                           <xsl:otherwise>
                              <xsl:value-of select="$part" /></xsl:otherwise>
                        </xsl:choose>
                     </xsl:with-param>
                     <xsl:with-param name="delim"><xsl:if test="$pos='second'">;</xsl:if></xsl:with-param>
                  </xsl:call-template></xsl:when>
               <xsl:when test="second">previous edition gave <xsl:value-of select="substring-after($part, ' :')"/></xsl:when>
            </xsl:choose></xsl:template>

   <xsl:template name="fnord-spliter">
      <xsl:param name="line" />
      <xsl:param name="delim" />
      <xsl:param name="tail" /><xsl:choose>
         <xsl:when test="$tail and not(contains($line, 'FNORD-SPLIT'))"><xsl:value-of select="$delim" /> <xsl:choose>
               <xsl:when test="contains($line,'prev. ed.') and not(starts-with(normalize-space($line), 'prev. ed.'))">
                  previous edition gave <xsl:value-of select="normalize-space(substring-before($line, 'prev. ed.'))" /><xsl:value-of select="normalize-space(substring-after($line, 'prev. ed.'))" /></xsl:when>
               <xsl:otherwise><xsl:value-of select="normalize-space($line)" /></xsl:otherwise>
            </xsl:choose></xsl:when>
         <xsl:otherwise><xsl:if test="contains($line, 'FNORD-SPLIT')">
               <xsl:value-of select="$delim" /><xsl:text> </xsl:text><xsl:choose>
                  <xsl:when test="contains(normalize-space($line), '(corr')">
                     <xsl:value-of select="normalize-space(substring-after($line, 'FNORD-SPLIT'))"/> reports scribe wrote
                     <xsl:value-of select="normalize-space(substring-before(substring-after(substring-before(normalize-space($line), 'FNORD-SPLIT'), '(corr. ex'), ')'))"/>, then changed to
                     <xsl:value-of select="normalize-space(substring-before(substring-before(normalize-space($line), 'FNORD-SPLIT'), '(corr. ex'))"/>
                  </xsl:when>
                  <xsl:otherwise><xsl:value-of select="normalize-space(substring-after($line, 'FNORD-SPLIT'))"/> gave <xsl:value-of select="normalize-space(substring-before($line, 'FNORD-SPLIT'))"/></xsl:otherwise></xsl:choose></xsl:if></xsl:otherwise>
      </xsl:choose></xsl:template>

   <xsl:template name="childpart">
      <xsl:param name="part2" />
      <xsl:param name="part1" />
      <xsl:param name="childtype" />
      <xsl:param name="apptype" />

      <xsl:choose><xsl:when test="normalize-space($part2) = ''"><xsl:call-template name="fnord-seperator">
               <xsl:with-param name="part"><xsl:value-of select="$part1" /></xsl:with-param>
               <xsl:with-param name="pos">first</xsl:with-param>
            </xsl:call-template></xsl:when>
         <xsl:when test="contains($part1, ' : ')"><xsl:value-of select="substring-before($part1, ' :')"/></xsl:when>
         <xsl:otherwise>Current edition</xsl:otherwise>
      </xsl:choose>

      <xsl:if test="normalize-space($part2) != ''">
         <xsl:if test="starts-with(normalize-space($part1), 'cf.')"> which</xsl:if>  gives <xsl:value-of select="normalize-space($part2)"/><xsl:text> </xsl:text>
      </xsl:if>

      <xsl:variable name="pt1"><xsl:call-template name="fnord-seperator">
            <xsl:with-param name="part"><xsl:value-of select="$part1" /></xsl:with-param>
            <xsl:with-param name="pos">second</xsl:with-param>
         </xsl:call-template>
      </xsl:variable>

      <xsl:choose>
         <xsl:when test="not($apptype = ('apped', 'appbl', 'apppn', 'appalt')) and $childtype = ('apped', 'appbl', 'apppn') and starts-with(normalize-space($pt1), ';')"><xsl:value-of select="normalize-space(substring-after($pt1, ';'))" /></xsl:when>
         <xsl:otherwise><xsl:value-of select="$pt1" /></xsl:otherwise>
      </xsl:choose>
   </xsl:template>


</xsl:stylesheet>
