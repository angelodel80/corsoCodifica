<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t"  version="2.0">
   <!-- html hi part of transformation in htm-teihi.xsl -->

    <!-- Add ligature combining characaters to given text -->
    <xsl:template name="ligaturizeText">
        <xsl:param name="textLigaturize"/>
        <xsl:analyze-string select="$textLigaturize" regex="\p{{L}}"> <!-- select letters only (will omit combining chars) -->
            <xsl:matching-substring>
                <xsl:choose>
                    <xsl:when test="position()=1"> <!-- skip first ligatured char -->
                        <xsl:value-of select="."/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>&#x0361;</xsl:text> <!-- emit ligature combining char -->
                        <xsl:value-of select="."/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:value-of select="."/>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>

    <xsl:template match="t:hi">
        <xsl:param name="parm-external-app-style" tunnel="yes" required="no"></xsl:param>
        <xsl:param name="parm-internal-app-style" tunnel="yes" required="no"></xsl:param>
        <xsl:param name="parm-edition-type" tunnel="yes" required="no"></xsl:param>
        <xsl:param name="parm-edn-structure" tunnel="yes" required="no"></xsl:param>
        <xsl:param name="parm-leiden-style" tunnel="yes" required="no"></xsl:param>
        <xsl:param name="location" tunnel="yes" required="no"/>

        <!-- This is necessary when <hi> content is embedded within <orig> mark-up or has embedded mark-up within.
             Without it, <orig> text may be reduced to lowercase, or embedded mark-up will be ignored. -->
        <xsl:variable name="text-content">
            <xsl:choose>
                <xsl:when test="ancestor::t:orig[not(ancestor::t:choice)]">
                    <xsl:variable name="processedChars">
                        <xsl:apply-templates select="./*|text()"/>
                    </xsl:variable>
                    <xsl:value-of select="translate($processedChars, $all-grc, $grc-upper-strip)"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="./*|text()"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:choose>
            <xsl:when test="@rend='ligature' and not($parm-edn-structure='inslib')">
                <xsl:choose>
                    <xsl:when test="$parm-leiden-style='seg'">
                        <xsl:if test="string-length(normalize-space(.))=2">
                            <xsl:text>&#x035c;</xsl:text>
                        </xsl:if>
                    </xsl:when>
                    <xsl:otherwise>
                        <!-- Combining char (x0361) will only render ligature line over two chars. For ligatures of >=3 chars, keep adding ligature marks -->
                        <!-- Combining characters for half-marks are: COMBINING LIGATURE LEFT HALF (U+FE20), COMBINING LIGATURE RIGHT HALF (U+FE21),
                           and COMBINING CONJOINING MACRON (U+FE26) -->
                        <!-- Also need to modify so that elements within <hi rend="ligature"> are rendered, e.g., reversed E. See RIB 1911 for example. -->
                        <!-- pro-process text content first, so formatting (e.g., underdots for unclear chars) gets applied before ligature marks -->
                        <xsl:variable name="preprocessed">
                            <xsl:value-of select="normalize-space($text-content)"/>
                        </xsl:variable>
                        <xsl:call-template name="ligaturizeText">
                            <xsl:with-param name="textLigaturize" select="$preprocessed"/>
                        </xsl:call-template>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>

            <xsl:when
             test="@rend = 'diaeresis' or @rend = 'grave' or @rend = 'acute' or @rend = 'asper' or @rend = 'lenis' or @rend = 'circumflex'">
             <xsl:apply-templates/>
             <xsl:choose>
                 <!-- if context is inside the app-part of an app-like element, print diacritic in parens here -->
                 <xsl:when test="$parm-internal-app-style = 'ddbdp' and
                     ancestor::t:*[local-name()=('reg','corr','rdg') 
                     or self::t:del[@rend='corrected']]">
                     <!--ancestor::t:*[local-name()=('orig','reg','sic','corr','lem','rdg')
                         or self::t:del[@rend='corrected']
                         or self::t:add[@place='inline']][1][local-name()=('reg','corr','del','rdg')]">-->
                     <xsl:text>(</xsl:text>
                     <!-- found in tpl-apparatus.xsl -->
                     <xsl:call-template name="hirend">
                         <xsl:with-param name="hicontext" select="'no'"/>
                     </xsl:call-template>
                     <xsl:text>)</xsl:text>
                 </xsl:when>
                 <xsl:when test="$parm-internal-app-style = 'ddbdp'">
                     <!-- found in [htm|txt]-tpl-apparatus.xsl -->
                     <xsl:call-template name="app-link">
                         <xsl:with-param name="location">
                             <xsl:choose>
                                 <xsl:when test="$location = 'apparatus'">apparatus</xsl:when>
                                 <xsl:otherwise>text</xsl:otherwise>
                             </xsl:choose>
                         </xsl:with-param>
                     </xsl:call-template>
                 </xsl:when>
             </xsl:choose>
         </xsl:when>
           <xsl:otherwise>
               <xsl:apply-templates/>
           </xsl:otherwise>
       </xsl:choose>
   </xsl:template>

</xsl:stylesheet>
