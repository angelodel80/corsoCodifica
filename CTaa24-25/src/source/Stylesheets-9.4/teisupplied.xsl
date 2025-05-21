<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:t="http://www.tei-c.org/ns/1.0" 
   xmlns:EDF="http://epidoc.sourceforge.net/ns/functions"
                exclude-result-prefixes="t EDF" 
                version="2.0">

   <xsl:template match="t:supplied[@reason='lost']">
      <xsl:param name="parm-edition-type" tunnel="yes" required="no"></xsl:param>
      <xsl:param name="parm-leiden-style" tunnel="yes" required="no"></xsl:param>
      <xsl:param name="location" />
      <xsl:if test="($parm-leiden-style = ('ddbdp','dclp','sammelbuch')) and child::t:*[1][local-name() = 'milestone'][@rend = 'paragraphos']">
         <br/>
      </xsl:if>
      <xsl:choose>
         <xsl:when test="@evidence">
            <xsl:if test="$parm-leiden-style = ('ddbdp','dclp','sammelbuch')">
               <xsl:text>[</xsl:text>
            </xsl:if>
            <xsl:choose>
               <xsl:when test="@evidence = 'parallel'">
                  <!-- Found in [htm|txt]-teisupplied.xsl -->
                  <xsl:call-template name="supplied-parallel"/>
               </xsl:when>
               <xsl:when test="@evidence = 'previouseditor'">
                  <!-- Found in [htm|txt]-teisupplied.xsl -->
                  <xsl:call-template name="supplied-previouseditor"/>
               </xsl:when>
            </xsl:choose>
            <xsl:if test="$parm-leiden-style = 'ddbdp' or $parm-leiden-style = 'sammelbuch'">
               <xsl:text>]</xsl:text>
            </xsl:if>
         </xsl:when>
         
         <xsl:otherwise>
        <!--
           *NB* the lost-opener and lost-closer templates, found in tpl-reasonlost.xsl,
           are no longer used in the EpiDoc Example Stylesheets since November 2011.
           They used to serve to limit the superfluous square brackets between adjacent gap
           and supplied elements, but this function is now performed by regex in
           [htm|txt]-tpl-sqbrackets.xsl which is called after all other templates are completed.
        -->
            <xsl:text>[</xsl:text>
            <xsl:choose>
                <xsl:when test="$parm-edition-type = 'diplomatic'">
                  <xsl:variable name="orig-supplied-content">
                     <xsl:value-of select="descendant::text()[not(ancestor::t:reg or ancestor::t:ex 
                        or ancestor::t:corr or ancestor::t:rdg)]"/>
                  </xsl:variable>
                  <xsl:variable name="sup-context-length">
                     <!-- take all text content that is not restored or expanded -->
                     <xsl:value-of select="translate(normalize-space($orig-supplied-content),' ','')"/>
                     <!-- also add characters for vacats -->
                     <xsl:for-each select="descendant::t:space">
                        <xsl:choose>
                           <xsl:when test="@quantity">
                              <xsl:for-each select="1 to @quantity">
                                 <xsl:text>.</xsl:text>
                              </xsl:for-each>
                           </xsl:when>
                           <xsl:otherwise>
                              <xsl:text>...</xsl:text>
                           </xsl:otherwise>
                        </xsl:choose>
                     </xsl:for-each>
                     <!-- also add characters for symbols and abbreviations -->
                     <xsl:for-each select="t:g|t:expan[not(child::abbr)]">
                        <xsl:text>.</xsl:text>
                     </xsl:for-each>
                   </xsl:variable>
                  <!-- Found in teigap.xsl -->
                  <xsl:call-template name="dot-out">
                     <xsl:with-param name="cur-num" select="string-length($sup-context-length)"/>
                  </xsl:call-template>
                  <!--<xsl:call-template name="dot-out">
                     <xsl:with-param name="cur-num" select="$space-ex"/>
                  </xsl:call-template>-->
               </xsl:when>
               <xsl:otherwise>
                  <xsl:apply-templates/>
               </xsl:otherwise>
            </xsl:choose>
            <!-- Found in tpl-cert-low.xsl -->
            <xsl:call-template name="cert-low"/>
            <!-- function EDF:f-wwrap declared in functions.xsl; tests if lb break=no immediately follows supplied -->
            <xsl:if test="EDF:f-wwrap(.) = true()">
               <!-- unless this is in the app part of a choice/subst/app in ddbdp
                      or an EDH leiden style, which doesn't use hyphens-->
                <xsl:if test="(not($parm-leiden-style=('ddbdp','dclp') and (ancestor::t:*[local-name()=('reg','corr','rdg')
                   or self::t:del[parent::t:subst]]))) and (not($location = 'apparatus'))
                   and not(starts-with($parm-leiden-style, 'edh') or $parm-leiden-style='eagletxt')">
                  <xsl:text>-</xsl:text>
               </xsl:if>
            </xsl:if>
            <!--
               *NB* the lost-opener and lost-closer templates, found in tpl-reasonlost.xsl,
               are no longer used in the EpiDoc Example Stylesheets since November 2011.
               They used to serve to limit the superfluous square brackets between adjacent gap
               and supplied elements, but this function is now performed by regex in
               [htm|txt]-tpl-sqbrackets.xsl which is called after all other templates are completed.
           -->
            <xsl:text>]</xsl:text>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

  <xsl:template match="t:supplied[@reason='omitted']">
      <xsl:param name="parm-edition-type" tunnel="yes" required="no"></xsl:param>
      <xsl:choose>
         <xsl:when test="$parm-edition-type='diplomatic'"/>
         <xsl:when test="@evidence = 'parallel'">
            <!-- Found in [htm|txt]-teisupplied.xsl -->
            <xsl:call-template name="supplied-parallel"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text>&lt;</xsl:text>
            <xsl:apply-templates/>
            <!-- Found in tpl-cert-low.xsl -->
            <xsl:call-template name="cert-low"/>
            <xsl:text>&gt;</xsl:text>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

  <xsl:template match="t:supplied[@reason='subaudible']">
     <xsl:param name="parm-leiden-style" tunnel="yes" required="no"></xsl:param>
     <xsl:choose>
        <xsl:when test="starts-with($parm-leiden-style, 'edh') or $parm-leiden-style='eagletxt'"/>
        <xsl:otherwise>
            <!-- Found in [htm|txt]-teisupplied.xsl -->
            <xsl:call-template name="supplied-subaudible"/>
        </xsl:otherwise> </xsl:choose>
  </xsl:template>

   <xsl:template match="t:supplied[@reason='explanation']">
      <xsl:text>(i.e. </xsl:text>
      <xsl:apply-templates/>
      <xsl:call-template name="cert-low"/>
      <xsl:text>)</xsl:text>
   </xsl:template>

   <xsl:template match="t:supplied[@reason='undefined' and @evidence]">
      <xsl:param name="parm-leiden-style" tunnel="yes" required="no"></xsl:param>
      <xsl:choose>
         <xsl:when test="@evidence = 'apograph'">
            <xsl:text>⌈</xsl:text>
            <xsl:apply-templates/>
            <xsl:call-template name="cert-low"/>
            <xsl:text>⌉</xsl:text>
         </xsl:when>
         <xsl:when test="@evidence = 'parallel'">
            <!-- Found in [htm|txt]-teisupplied.xsl -->
            <xsl:call-template name="supplied-parallel"/>
         </xsl:when>
         <xsl:when test="@evidence = 'previouseditor'">
            <!-- Found in [htm|txt]-teisupplied.xsl -->
            <xsl:call-template name="supplied-previouseditor"/>
         </xsl:when>
      </xsl:choose>
   </xsl:template>

</xsl:stylesheet>