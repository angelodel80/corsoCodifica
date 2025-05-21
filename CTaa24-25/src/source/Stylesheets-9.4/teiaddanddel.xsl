<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t"  version="2.0">
   <!-- Contains templates for subst, add and del -->
   
   <!-- Imported by htm-teiaddanddel.xsl or called directly from start-txt.xsl -->
   
   <xsl:template match="t:subst">
      <xsl:param name="parm-external-app-style" tunnel="yes" required="no"/>
      <xsl:param name="parm-internal-app-style" tunnel="yes" required="no"/>
      <xsl:param name="location" tunnel="yes" required="no"/>
       <xsl:apply-templates/>

      <xsl:if test="$parm-internal-app-style = 'ddbdp'">
         <!-- Found in [htm|txt]-tpl-apparatus -->
          <xsl:call-template name="app-link">
             <xsl:with-param name="location">
                <xsl:choose>
                   <xsl:when test="$location = 'apparatus'">apparatus</xsl:when>
                   <xsl:otherwise>text</xsl:otherwise>
                </xsl:choose>
             </xsl:with-param>
          </xsl:call-template>
      </xsl:if>
   </xsl:template>


   <xsl:template match="t:add">
       <xsl:param name="parm-leiden-style" tunnel="yes" required="no"></xsl:param>
       <xsl:choose>
          <xsl:when test="$parm-leiden-style=('ddbdp','dclp','sammelbuch')">
            <xsl:choose>
               <xsl:when test="parent::t:subst"/>
               <xsl:when test="@place = 'above'">
                  <xsl:text>\</xsl:text>
               </xsl:when>
               <xsl:when test="@place = 'below'">
                  <xsl:text>/</xsl:text>
               </xsl:when>
               <xsl:when test="@place = 'left'">
                  <xsl:text>(added at left: </xsl:text>
               </xsl:when>
               <xsl:when test="@place = 'right'">
                  <xsl:text>(added at right: </xsl:text>
               </xsl:when>
            </xsl:choose>
         </xsl:when>
           <xsl:when test="$parm-leiden-style=('petrae','iospe')">
            <xsl:text>\</xsl:text>
         </xsl:when>
         <xsl:otherwise>
            <xsl:choose>
               <xsl:when test="parent::t:subst or @place='overstrike'">
                  <xsl:text>«</xsl:text>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:text>`</xsl:text>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates/>
      <xsl:call-template name="cert-low"/>

      <xsl:choose>
         <xsl:when test="$parm-leiden-style=('ddbdp','dclp','sammelbuch')">
            <xsl:choose>
               <!-- if my parent is subst which in turn is in the appcrit-part of a further app-like element 
                  (i.e. my ancestor is reg, corr, rdg, or del[corrected]), then include value of my sibling del in parens -->
               <xsl:when test="parent::t:subst and ancestor::t:*[local-name()=('reg','corr','rdg') 
                  or self::t:del[@rend='corrected']]">
                  <!-- If add contains app, *only* render del (because add is rendered before the subst by app templates) -->
                  <xsl:text> (</xsl:text><xsl:choose>
                     <xsl:when test="t:app"><xsl:call-template name="resolvesubst">
                           <!-- From tpl-apparatus.xsl -->
                           <xsl:with-param name="delpath" select="../t:del/node()"/>
                        </xsl:call-template></xsl:when>
                     <xsl:otherwise><xsl:call-template name="resolvesubst">
                           <!-- From tpl-apparatus.xsl -->
                           <xsl:with-param name="delpath" select="../t:del/node()"/>
                           <xsl:with-param name="addpath" select="node()"/>
                        </xsl:call-template></xsl:otherwise></xsl:choose><xsl:text>)</xsl:text>
               </xsl:when>
               <xsl:when test="parent::t:subst"/>
               <xsl:when test="@place = 'above'">
                  <xsl:text>/</xsl:text>
               </xsl:when>
               <xsl:when test="@place = 'below'">
                  <xsl:text>\</xsl:text>
               </xsl:when>
               <xsl:when test="@place = 'left' or @place = 'right'">
                  <xsl:text>)</xsl:text>
               </xsl:when>
            </xsl:choose>
         </xsl:when>
          <xsl:when test="$parm-leiden-style=('petrae','iospe')">
            <xsl:text>/</xsl:text>
         </xsl:when>
         <xsl:when test="parent::t:subst or @place='overstrike'">
            <xsl:text>»</xsl:text>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text>´</xsl:text>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>


   <xsl:template match="t:del">
      <xsl:param name="parm-internal-app-style" tunnel="yes" required="no"/>
      <xsl:param name="parm-leiden-style" tunnel="yes" required="no"/>
      <xsl:param name="parm-apparatus-style" tunnel="yes" required="no"/>
      <xsl:param name="location" tunnel="yes" required="no"/>
      <xsl:if test="$parm-apparatus-style = 'ddbdp'">
         <xsl:if test="@rend = 'slashes' or @rend = 'cross-strokes'">
            <!-- Found in [htm | txt]-tpl-apparatus -->
            <xsl:call-template name="app-link">
               <xsl:with-param name="location">
                  <xsl:choose>
                     <xsl:when test="$location = 'apparatus'">apparatus</xsl:when>
                     <xsl:otherwise>text</xsl:otherwise>
                  </xsl:choose>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:if>

      <xsl:choose>
          <xsl:when test="starts-with($parm-leiden-style, 'edh') or $parm-leiden-style=('petrae','iospe')">
            <xsl:text>[[</xsl:text>
            <xsl:apply-templates/>
            <xsl:text>]]</xsl:text>
         </xsl:when>
         <xsl:when test="($parm-leiden-style = ('ddbdp','dclp','sammelbuch')) and @rend='slashes'">
            <xsl:apply-templates/>
         </xsl:when>
         <xsl:when test="($parm-leiden-style = ('ddbdp','dclp','sammelbuch')) and @rend='cross-strokes'">
            <xsl:apply-templates/>
         </xsl:when>
          <xsl:when test="$parm-leiden-style = 'rib'">
              <xsl:choose>
                  <xsl:when test="@rend='erasure'">
                      <span class="erasure"><xsl:apply-templates/></span>
                  </xsl:when>
                  <xsl:when test="not(@rend)"/>
                  <xsl:otherwise>
                      <xsl:apply-templates/>
                  </xsl:otherwise>
              </xsl:choose>
          </xsl:when>
          <xsl:when test="parent::t:subst"/>
         <xsl:otherwise>
            <xsl:text>&#x27e6;</xsl:text>
            <xsl:apply-templates/>
            <xsl:call-template name="cert-low"/>
            <xsl:text>&#x27e7;</xsl:text>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

</xsl:stylesheet>
