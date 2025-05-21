<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:t="http://www.tei-c.org/ns/1.0"
   xmlns:EDF="http://epidoc.sourceforge.net/ns/functions"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   exclude-result-prefixes="#all" version="2.0">
   <!-- Actual display and increment calculation found in teilb.xsl -->
   <xsl:import href="teilb.xsl"/>

    <xsl:template match="t:lb">
        <xsl:param name="parm-edn-structure" tunnel="yes" required="no"/>
        <xsl:param name="parm-edition-type" tunnel="yes" required="no"/>
        <xsl:param name="parm-leiden-style" tunnel="yes" required="no"/>
        <xsl:param name="parm-line-inc" tunnel="yes" required="no"/>
        <xsl:param name="parm-verse-lines" tunnel="yes" required="no"/>
        <xsl:param name="location" tunnel="yes" required="no"/>
        
        <xsl:choose>
            <xsl:when test="ancestor::t:lg and $parm-verse-lines = 'on'">
                <xsl:apply-imports/>
                <!-- use the particular templates in teilb.xsl -->
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="div-loc">
                    <xsl:for-each select="ancestor::t:div[@type = 'textpart']">
                        <xsl:value-of select="@n"/>
                        <xsl:text>-</xsl:text>
                    </xsl:for-each>
                </xsl:variable>
                <xsl:variable name="line">
                    <xsl:if test="@n">
                        <xsl:value-of select="@n"/>
                    </xsl:if>
                </xsl:variable>
                <!-- print hyphen if break=no  -->
                <xsl:if test="(@break='no' or @type='inWord')">
                    <xsl:choose>
                        <!--    edh web  -->
                        <xsl:when test="$parm-leiden-style=('edh-itx','edh-names')">
                            <xsl:variable name="cur_anc" select="generate-id(ancestor::node()[local-name()='lg' or local-name()='ab'])"/>
                            <xsl:if
                                test="preceding::t:lb[1][generate-id(ancestor::node()[local-name()='lg' or local-name()='ab'])=$cur_anc]">
                                <xsl:choose>
                                    <xsl:when test="$parm-leiden-style='edh-names'
                                        and not(@break='no' or ancestor::t:w | ancestor::t:name | ancestor::t:placeName | ancestor::t:geogName)">
                                        <xsl:text> </xsl:text>
                                    </xsl:when>
                                    <xsl:when test="$parm-leiden-style=('edh-names')"/>
                                    <xsl:when test="@break='no' or ancestor::t:w | ancestor::t:name | ancestor::t:placeName | ancestor::t:geogName">
                                        <xsl:text>/</xsl:text>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:text> / </xsl:text>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:if>
                        </xsl:when>
                        <xsl:when test="$parm-leiden-style='eagletxt'">
                            <xsl:variable name="cur_anc" select="generate-id(ancestor::node()[local-name()='lg' or local-name()='ab'])"/>
                            <xsl:if
                                test="preceding::t:lb[1][generate-id(ancestor::node()[local-name()='lg' or local-name()='ab'])=$cur_anc]">
                                
                                <xsl:choose>
                                    <xsl:when test="not(@break='no' or ancestor::t:w | ancestor::t:name | ancestor::t:placeName | ancestor::t:geogName)">
                                        <xsl:text> / </xsl:text>
                                    </xsl:when>
                                    <xsl:when test="@break='no' or ancestor::t:w | ancestor::t:name | ancestor::t:placeName | ancestor::t:geogName">
                                        <xsl:text>/</xsl:text>
                                    </xsl:when>
                                </xsl:choose>
                            </xsl:if>
                        </xsl:when>
                        <!--    *unless* diplomatic edition  -->
                        <xsl:when test="$parm-edition-type='diplomatic'"/>
                        <!--    *or unless* the lb is first in its ancestor div  -->
                        <xsl:when test="generate-id(self::t:lb) = generate-id(ancestor::t:div[1]/t:*[child::t:lb][1]/t:lb[1])"/>
                        <!-- TODO: The following two are in contention -->
                        <xsl:when test="($parm-leiden-style = 'ddbdp' and ((not(ancestor::*[name() = 'TEI'])) or $location='apparatus')) or ($parm-edn-structure='inslib' and ancestor::t:div[@type='apparatus'])" />                                      
                        <!--   *or unless* the second part of an app in ddbdp  -->
                        <xsl:when test="($parm-leiden-style = 'ddbdp' or $parm-leiden-style = 'sammelbuch') and
                            (ancestor::t:corr or ancestor::t:reg or ancestor::t:rdg or ancestor::t:del[parent::t:subst])"/>
                        <!--  *unless* previous line ends with space / g / supplied[reason=lost]  -->
                        <!-- in which case the hyphen will be inserted before the space/g r final ']' of supplied
                            (tested by EDF:f-wwrap in functions.xsl, which is called by teisupplied.xsl, teig.xsl and teispace.xsl) -->
                        <xsl:when
                            test="
                            preceding-sibling::node()[1][local-name() = 'space' or
                            local-name() = 'g' or (local-name() = 'supplied' and @reason = 'lost') or
                            (normalize-space(.) = ''
                            and preceding-sibling::node()[1][local-name() = 'space' or
                            local-name() = 'g' or (local-name() = 'supplied' and @reason = 'lost')])]"/>
                        <!-- *or unless* this break is accompanied by a paragraphos mark -->
                        <!-- in which case the hypen will be inserted before the paragraphos by code in htm-teimilestone.xsl -->
                        <xsl:when
                            test="preceding-sibling::node()[not(self::text() and normalize-space(self::text()) = '')][1]/self::t:milestone[@rend = 'paragraphos']"/>
                        <xsl:otherwise>
                            <xsl:text>-</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:if>
                                
                <!-- print arrows right of line if R2L or explicitly L2R -->
                <!-- arrows after final line handled in htm-teiab.xsl and htm-teilgandl.xsl -->
                <xsl:if
                    test="
                    not($parm-leiden-style = ('ddbdp','dclp', 'sammelbuch'))
                    and not(position() = 1)
                    and preceding::t:lb[1][@rend = 'left-to-right']">
                    <xsl:text>&#xa0;&#xa0;→</xsl:text>
                </xsl:if>
                <xsl:if
                    test="
                    not($parm-leiden-style = ('ddbdp', 'dclp','sammelbuch'))
                    and not(position() = 1)
                    and preceding::t:lb[1][@rend = 'right-to-left']">
                    <xsl:text>&#xa0;&#xa0;←</xsl:text>
                </xsl:if>
                
                <xsl:if test="$parm-edn-structure='inslib' and ancestor::t:l/preceding::t:l[1]//t:lb[last()][@rend = 'left-to-right']">
                 <xsl:text>&#xa0;&#xa0;→</xsl:text>
             </xsl:if>
             <xsl:if test="$parm-edn-structure='inslib' and ancestor::t:l/preceding::t:l[1]//t:lb[last()][@rend = 'right-to-left']">
                 <xsl:text>&#xa0;&#xa0;←</xsl:text>
             </xsl:if>
            
            <xsl:choose>
                    <!-- replaced test using generate-id() with 'is' -->
                    <xsl:when test="self::t:lb is ancestor::t:div[1]/t:*[child::t:lb][1]/t:lb[1]">
                        <a id="a{$div-loc}l{$line}">
                            <xsl:comment>0</xsl:comment>
                        </a><xsl:if test="@rend">
                            <span>
                                <xsl:if test="@rend">
                                    <xsl:attribute name="class">
                                        <xsl:value-of select="concat('lb ',@rend)"/>
                                    </xsl:attribute>
                                </xsl:if>
                                <xsl:choose>
                                    <xsl:when test="@rend='inverse'">(inverse) </xsl:when>
                                    <xsl:when test="@rend='perpendicular'">(perpendicular) </xsl:when>
                                </xsl:choose>
                            </span>                     
                        </xsl:if>
                        <!-- for the first lb in a div, create an empty anchor instead of a line-break -->
                    </xsl:when>
                    <!-- Commented out, causes incorrect formatting. '|' should only appear in apparatus. See: https://github.com/DCLP/dclpxsltbox/issues/119 TODO: Investigate. Canceled comment (HAC)
                    -->
                    <xsl:when
                        test="($parm-leiden-style = 'ddbdp' or $parm-leiden-style = 'sammelbuch') 
                        and (ancestor::t:sic 
                        or ancestor::t:reg
                        or ancestor::t:rdg or ancestor::t:del[ancestor::t:choice])
                        or ancestor::t:del[@rend='corrected'][parent::t:subst]">
                        <xsl:choose>
                            <xsl:when test="@break='no' or @type='inWord'">
                                <xsl:text>|</xsl:text>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text> | </xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:when
                  test="($parm-leiden-style = ('ddbdp','dclp') and ((not(ancestor::*[name() = 'TEI'])) or $location='apparatus')) or ($parm-edn-structure='inslib' and ancestor::t:div[@type='apparatus'])">
                        <xsl:choose>
                            <xsl:when test="@break = 'no' or @type = 'inWord'">
                                <xsl:text>|</xsl:text>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text> | </xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                        <br id="a{$div-loc}l{$line}"/>
                        <xsl:if test="@rend">
                            <span>
                                <xsl:if test="@rend">
                                    <xsl:attribute name="class">
                                        <xsl:value-of select="concat('lb ',@rend)"/>
                                    </xsl:attribute>
                                </xsl:if>
                                <xsl:choose>
                                    <xsl:when test="@rend='inverse'">(inverse) </xsl:when>
                                    <xsl:when test="@rend='perpendicular'">(perpendicular) </xsl:when>
                                </xsl:choose>
                            </span>                     
                        </xsl:if>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:choose>
                    <xsl:when test="$location = 'apparatus'"/>
                    <xsl:when
                        test="not(number(@n)) and ($parm-leiden-style = ('ddbdp','dclp','sammelbuch'))">
                        <!--         non-numerical line-nos always printed in DDbDP         -->
                        <xsl:call-template name="margin-num"/>
                    </xsl:when>
                    <xsl:when
                        test="
                        number(@n) and @n mod number($parm-line-inc) = 0 and not(@n = 0) and
                        not(following::t:*[1][local-name() = 'gap' or local-name() = 'space'][@unit = 'line'] and
                        ($parm-leiden-style = ('ddbdp','dclp','sammelbuch')))">
                        <!-- prints line-nos divisible by stated increment, unless zero
                            and unless it is a gap line or vacat in DDbDP -->
                        <xsl:call-template name="margin-num"/>
                    </xsl:when>
                    <xsl:when
                        test="$parm-leiden-style = ('ddbdp','dclp') and preceding-sibling::t:*[1][local-name() = 'gap'][@unit = 'line']">
                        <!-- always print line-no after gap line in ddbdp -->
                        <xsl:call-template name="margin-num"/>
                    </xsl:when>
                    <xsl:when
                        test="$parm-leiden-style = ('ddbdp','dclp') and following::t:lb[1][ancestor::t:reg[following-sibling::t:orig[not(descendant::t:lb)]]]">
                        <!-- always print line-no when broken orig in line, in ddbdp -->
                        <xsl:call-template name="margin-num"/>
                    </xsl:when>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

   <xsl:template name="margin-num">
       <xsl:param name="parm-leiden-style" tunnel="yes" required="no"></xsl:param>
       <xsl:choose>
         <!-- don't print marginal line number inside tags that are relegated to the apparatus (ddbdp) -->
         <xsl:when test="$parm-leiden-style = 'eagletxt'"/>
         <xsl:when
            test="$parm-leiden-style = ('ddbdp','dclp','sammelbuch')
            and (ancestor::t:sic
            or ancestor::t:reg
            or ancestor::t:rdg or ancestor::t:del[ancestor::t:choice])
            or ancestor::t:del[@rend='corrected'][parent::t:subst]"/>
         <xsl:otherwise>
            <span>
                  <xsl:choose>
                      <xsl:when test="$parm-leiden-style = 'ddbdp' and following::t:lb[1][ancestor::t:reg[following-sibling::t:orig[not(descendant::t:lb)]]]">
                        <xsl:attribute name="class">
                           <xsl:text>linenumberbroken</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="title">
                           <xsl:text>line-break missing in orig</xsl:text>
                        </xsl:attribute>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:attribute name="class">
                           <xsl:text>linenumber</xsl:text>
                         </xsl:attribute>
                     </xsl:otherwise>
                  </xsl:choose>
               <xsl:value-of select="@n"/>
            </span>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

</xsl:stylesheet>
