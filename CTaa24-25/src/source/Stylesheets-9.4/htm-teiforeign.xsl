<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" 
    version="2.0">
    
    <xsl:template match="t:foreign" mode="#default inslib-dimensions inslib-placename sample-dimensions creta">
        <xsl:param name="parm-edn-structure" tunnel="yes" required="no"/>
        <xsl:choose>
            <xsl:when test="$parm-edn-structure='inslib' or $parm-edn-structure='sample' or $parm-edn-structure='creta'">
                <span class="lang">
                    <!-- Found in htm-tpl-lang.xsl -->
                    <xsl:call-template name="attr-lang"/>
                    <xsl:choose>
                        <xsl:when test="@xml:lang='grc'">
                            <xsl:apply-templates/>
                        </xsl:when>
                        <xsl:otherwise>
                            <i><xsl:apply-templates/></i>
                        </xsl:otherwise>
                    </xsl:choose>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <span class="lang">
                    <!-- Found in htm-tpl-lang.xsl -->
                    <xsl:call-template name="attr-lang"/>
                    <xsl:apply-templates/>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>