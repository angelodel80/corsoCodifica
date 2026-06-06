<!-- $Id$ --><xsl:stylesheet xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" version="2.0">
  <!-- Contains app and its children rdg, ptr, note and lem -->

   <xsl:template match="t:app">
      <xsl:param name="parm-internal-app-style" tunnel="yes" required="no"/>
      <xsl:param name="parm-external-app-style" tunnel="yes" required="no"/>
      <xsl:param name="parm-edn-structure" tunnel="yes" required="no"/>
      <xsl:choose>
         <xsl:when test="$parm-edn-structure = 'igcyr'">
         <xsl:for-each select=".">
            <fo:block>
               <xsl:value-of select="@loc"/><xsl:text> </xsl:text>
               <xsl:if test="t:lem">
                  <xsl:for-each select="t:lem[@resp]">
                     <xsl:variable name="authors">
                     <xsl:variable name="resp" select="tokenize(./@resp,' ')"/>
                     <xsl:for-each select="$resp">
                           <xsl:variable name="indresp">
                              <xsl:sequence select="substring-after(.,'#')"/>
                           </xsl:variable>
                     <xsl:choose>
                              <xsl:when test="document('Workspace/files/BIBLIOGRAPHY.xml')//t:bibl[@xml:id = $indresp]">
                                 <xsl:for-each select="document('Workspace/files/BIBLIOGRAPHY.xml')//t:bibl[@xml:id = $indresp]">
                                    <xsl:text> </xsl:text>
                                    <xsl:choose><xsl:when test="t:author"><xsl:value-of select="t:author[1]/t:name[@type='surname']"/>
                                       <xsl:if test="t:author[2]">
                                          <xsl:text>-</xsl:text>
                                          <xsl:value-of select="t:author[2]/t:name[@type='surname']"/>
                                       </xsl:if></xsl:when>
                                       <xsl:when test="t:editor">
                                          <xsl:value-of select="t:editor[1]/t:name[@type='surname']"/>
                                          <xsl:if test="t:editor[2]">
                                             <xsl:text>-</xsl:text>
                                             <xsl:value-of select="t:editor[2]/t:name[@type='surname']"/>
                                          </xsl:if>
                                       </xsl:when></xsl:choose>
                                    <xsl:text> </xsl:text>
                                    <xsl:value-of select="t:date"/>
                                 </xsl:for-each>
                              </xsl:when>
                              <xsl:when test="contains($indresp,'SEG')">
                                 <xsl:text> SEG </xsl:text><xsl:value-of select="substring-after($indresp, 'SEG')"/>
                              </xsl:when>
                              <xsl:when test="contains($indresp,'SECir')">
                                 <xsl:text> SECir </xsl:text><xsl:value-of select="substring-after($indresp, 'SECir')"/>
                              </xsl:when>
                              <xsl:when test="contains($indresp,'Sammelbuch')">
                                 <xsl:text> Sammelbuch </xsl:text><xsl:value-of select="$indresp"/>
                              </xsl:when>
                              <xsl:otherwise>
                                 <xsl:text> !</xsl:text><xsl:value-of select="$indresp"/><xsl:text>!</xsl:text>
                              </xsl:otherwise>
                           </xsl:choose>
                           <xsl:if test="not(position()=last())">
                              <xsl:text>, </xsl:text>
                           </xsl:if>
                        </xsl:for-each>
                        </xsl:variable>
                     <xsl:apply-templates><xsl:with-param name="location" tunnel="yes">apparatus</xsl:with-param></xsl:apply-templates>
                     <xsl:text> </xsl:text>
                     <xsl:value-of select="$authors"/>
                     </xsl:for-each>
               </xsl:if>
               <xsl:text> </xsl:text>
               <xsl:for-each select="t:rdg">
                  <xsl:variable name="authors">
                     <xsl:choose><xsl:when test="./@resp">
                        <xsl:variable name="resp" select="tokenize(./@resp,' ')"/>
                        <xsl:for-each select="$resp">
                           <xsl:variable name="indresp">
                              <xsl:sequence select="substring-after(.,'#')"/>
                           </xsl:variable>
                           <xsl:choose>
                              <xsl:when test="document('Workspace/files/BIBLIOGRAPHY.xml')//t:bibl[@xml:id = $indresp]">
                                 <xsl:for-each select="document('Workspace/files/BIBLIOGRAPHY.xml')//t:bibl[@xml:id = $indresp]">
                                    <xsl:text> </xsl:text>
                                    <xsl:choose><xsl:when test="t:author"><xsl:value-of select="t:author[1]/t:name[@type='surname']"/>
                                       <xsl:if test="t:author[2]">
                                          <xsl:text>-</xsl:text>
                                          <xsl:value-of select="t:author[2]/t:name[@type='surname']"/>
                                       </xsl:if></xsl:when>
                                       <xsl:when test="t:editor">
                                          <xsl:value-of select="t:editor[1]/t:name[@type='surname']"/>
                                          <xsl:if test="t:editor[2]">
                                             <xsl:text>-</xsl:text>
                                             <xsl:value-of select="t:editor[2]/t:name[@type='surname']"/>
                                          </xsl:if>
                                       </xsl:when></xsl:choose>
                                    <xsl:text> </xsl:text>
                                    <xsl:value-of select="t:date"/>
                                 </xsl:for-each>
                              </xsl:when>
                              <xsl:when test="contains($indresp,'SEG')">
                                 <xsl:text> SEG </xsl:text><xsl:value-of select="substring-after($indresp, 'SEG')"/>
                              </xsl:when>
                              <xsl:when test="contains($indresp,'SECir')">
                                 <xsl:text> SECir </xsl:text><xsl:value-of select="substring-after($indresp, 'SECir')"/>
                              </xsl:when>
                              <xsl:when test="contains($indresp,'Sammelbuch')">
                                 <xsl:text> Sammelbuch </xsl:text><xsl:value-of select="$indresp"/>
                              </xsl:when>
                              <xsl:otherwise>
                                 <xsl:text> !</xsl:text><xsl:value-of select="$indresp"/><xsl:text>!</xsl:text>
                              </xsl:otherwise>
                           </xsl:choose>
                           <xsl:if test="not(position()=last())">
                              <xsl:text>, </xsl:text>
                           </xsl:if>
                        </xsl:for-each>
                     </xsl:when>
                        <xsl:otherwise>
                           <xsl:text>Other reading</xsl:text>
                        </xsl:otherwise>
                     </xsl:choose>
                     </xsl:variable>
                  <xsl:apply-templates><xsl:with-param name="location" tunnel="yes">apparatus</xsl:with-param></xsl:apply-templates>
                  <xsl:text> </xsl:text>
                  <xsl:value-of select="$authors"/>
                  <xsl:if test="./note"><xsl:value-of select="./note"/></xsl:if>
                  <xsl:choose><xsl:when test="not(position() = last())"><xsl:text>; </xsl:text></xsl:when><xsl:otherwise><xsl:text>.</xsl:text></xsl:otherwise></xsl:choose>
               </xsl:for-each>
               <xsl:text> </xsl:text>
               <xsl:for-each select="t:note">
                  <xsl:value-of select="."/>
               </xsl:for-each>
            </fo:block>
            </xsl:for-each>
      </xsl:when>
         <xsl:when test="@resp='previous'">
            <fo:inline text-decoration="underline">
               <xsl:apply-templates/>
            </fo:inline>
         </xsl:when>
         <xsl:when test="@resp='autopsy'"/>
         <xsl:otherwise>
            <xsl:apply-templates/>
         </xsl:otherwise>
      </xsl:choose>

      <!-- Found in htm-tpl-apparatus - creates links to footnote in apparatus -->
      <xsl:if test="$parm-internal-app-style = 'ddbdp'">
         <xsl:call-template name="app-link">
            <xsl:with-param name="location" select="'text'"/>
         </xsl:call-template>
      </xsl:if>
  </xsl:template>


  <xsl:template match="t:rdg">
      <xsl:param name="parm-edition-type" tunnel="yes" required="no"/>
      <xsl:choose>
          <xsl:when test="$parm-edition-type = 'diplomatic'">
            <xsl:choose>
               <xsl:when test="@resp='previous'"/>
               <xsl:when test="@resp='autopsy'">
                  <xsl:apply-templates/>
               </xsl:when>
               <xsl:when test="not(preceding-sibling::t:lem or preceding-sibling::t:rdg)">
                  <xsl:apply-templates/>
               </xsl:when>
               <xsl:otherwise/>
            </xsl:choose>
         </xsl:when>
         <xsl:when test="@resp='previous'">
            <xsl:apply-templates/>
         </xsl:when>
         <xsl:when test="@resp='autopsy'"/>
         <xsl:when test="parent::t:app"/>
         <xsl:otherwise>
            <xsl:apply-templates/>
         </xsl:otherwise>
      </xsl:choose>
  </xsl:template>


  <xsl:template match="t:wit">
      <xsl:choose>
      <!-- Temporary -->
         <xsl:when test="parent::t:app"/>
         <xsl:otherwise>
            <xsl:apply-templates/>
         </xsl:otherwise>
      </xsl:choose>
  </xsl:template>

   <xsl:template match="t:lem">
      <xsl:param name="parm-edition-type" tunnel="yes" required="no"/>
      <xsl:param name="parm-leiden-style" tunnel="yes" required="no"/>
      <xsl:param name="parm-hgv-gloss" tunnel="yes" required="no"/>
      <xsl:choose>
          <xsl:when test="$parm-leiden-style=('ddbdp','sammelbuch') and ancestor::t:div[@type='translation']">
            <xsl:variable name="wit-val" select="@resp"/>
            <xsl:variable name="lang" select="ancestor::t:div[@type = 'translation']/@xml:lang"/>
            <fo:inline-container>
              <xsl:apply-templates/>
              <fo:inline font-weight="800"><xsl:choose>
                  <xsl:when test="$lang = 'en'">
                    <xsl:if test=".//t:term[@target]">
                      <xsl:text>Glossary/</xsl:text>
                    </xsl:if>
                    <xsl:text>Correction:</xsl:text>
                  </xsl:when>
                  <xsl:when test="$lang = 'de'">
                    <xsl:if test=".//t:term[@target]">
                      <xsl:text>Glossar/</xsl:text>
                    </xsl:if>
                    <xsl:text>Korrektur:</xsl:text>
                  </xsl:when>
                </xsl:choose>
              </fo:inline>
                <xsl:for-each select=".//t:term[@target]">
                    <xsl:value-of select="document($parm-hgv-gloss)//t:item[@xml:id = current()/@target]/t:term"/>
                  <xsl:text>. </xsl:text>
                    <xsl:value-of select="document($parm-hgv-gloss)//t:item[@xml:id = current()/@target]/t:gloss[@xml:lang = $lang]"/>
                  <xsl:text>; </xsl:text>
                </xsl:for-each>
                <xsl:value-of select="$wit-val"/>
              
            </fo:inline-container>
         </xsl:when>
          <xsl:when test="$parm-leiden-style=('ddbdp','sammelbuch') and ancestor::t:*[local-name()=('reg','corr','rdg')             or self::t:del[@rend='corrected']]">
            <xsl:apply-templates/>
            <xsl:if test="@resp">
               <xsl:choose>
                   <xsl:when test="$parm-leiden-style='ddbdp'"><xsl:text> FNORD-SPLIT </xsl:text></xsl:when>
                  <xsl:otherwise><xsl:text> </xsl:text></xsl:otherwise>
               </xsl:choose>
               <xsl:if test="parent::t:app[@type='BL']">
                  <xsl:text>BL </xsl:text>
               </xsl:if>

               <xsl:value-of select="@resp"/>

               <xsl:if test="parent::t:app[@type='SoSOL']">
                  <xsl:text> (via PE)</xsl:text>
               </xsl:if>
               <xsl:choose>
                   <xsl:when test="$parm-leiden-style='ddbdp'"><xsl:text> FNORD-DELIM </xsl:text></xsl:when>
                  <xsl:otherwise><xsl:text> </xsl:text></xsl:otherwise>
               </xsl:choose>
            </xsl:if>
            <xsl:choose>
               <xsl:when test="parent::t:app[@type='editorial']">
                  <xsl:text> (</xsl:text><xsl:for-each select="following-sibling::t:rdg">
                     <!-- found in tpl-apparatus.xsl -->
                     <xsl:call-template name="app-ed-mult"/>
                  </xsl:for-each><xsl:text>)</xsl:text>
               </xsl:when>
               <xsl:when test="parent::t:app[@type='alternative']">
                  <xsl:text> (or </xsl:text>
                  <xsl:for-each select="following-sibling::t:rdg">
                     <xsl:apply-templates/>
                     <xsl:if test="position()!=last()">
                        <xsl:text> or </xsl:text>
                     </xsl:if>
                  </xsl:for-each>
                  <xsl:text>)</xsl:text>
               </xsl:when>
            </xsl:choose>
         </xsl:when>
         <xsl:when test="parent::t:app[@type='previouslyread']">
            <fo:inline text-decoration="underline">
               <xsl:apply-templates/>
            </fo:inline>
         </xsl:when>
          <xsl:when test="$parm-leiden-style='iospe' and $parm-edition-type='interpretive' and ../t:rdg">
            <xsl:apply-templates/>
            <xsl:for-each select="../t:rdg">
               <xsl:text> resp. </xsl:text>
               <xsl:apply-templates/>
            </xsl:for-each>
         </xsl:when>
         <xsl:otherwise>
            <xsl:apply-templates/>
         </xsl:otherwise>
      </xsl:choose>
  </xsl:template>

</xsl:stylesheet>