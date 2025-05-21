<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:EDF="http://epidoc.sourceforge.net/ns/functions"
    xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:function name="EDF:refParser">
        <xsl:param name="ref"/>
        <xsl:param name="listPrefixDef"/>
        <xsl:choose>
            <xsl:when test="starts-with($ref, 'http')">
                <xsl:value-of select="$ref"/>
            </xsl:when>
            <xsl:when test="contains($ref, ':')">
                <xsl:variable name="prefix" select="substring-before($ref,':')"/>
                <xsl:variable name="pdef" select="$listPrefixDef//t:prefixDef[@ident=$prefix]"/>
                <xsl:choose>
                    <xsl:when test="$pdef"><xsl:value-of select="replace(substring-after($ref, ':'), $pdef/@matchPattern, $pdef/@replacementPattern)"/></xsl:when>
                    <xsl:otherwise><xsl:value-of select="concat('no matching prefix ',$prefix, ' found for ', $ref)"/></xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$ref"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
   
    <xsl:function name="EDF:refID">
        <xsl:param name="ref"/>
        <xsl:choose>
            <xsl:when test="contains($ref, '#')">
                <xsl:value-of select="substring-after($ref,'#')"/>
            </xsl:when>
            <xsl:when test="contains($ref, ':')">
                <xsl:value-of select="substring-after($ref,':')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$ref"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>

    <xsl:function name="EDF:f-wwrap">
        <!-- called by teisupplied.xsl, teig.xsl and teispace.xsl -->
        <xsl:param name="ww-context"/>
        <xsl:choose>
            <xsl:when test="$ww-context/following-sibling::node()[1][(local-name()='lb' and (@break='no' or @type='inWord'))             or normalize-space(.)='' and following-sibling::node()[1][local-name()='lb' and (@break='no' or @type='inWord')]]">
                <xsl:value-of select="true()"/>
            </xsl:when>
            <!--      imported change    https://sourceforge.net/p/epidoc/code/2602/-->
            <!-- Added to controll '-' when there is a milestone@rend='paragraphos' followed by a lb@break='no' see: https://github.com/DCLP/dclpxsltbox/issues/52-->
            <xsl:when test="$ww-context/following-sibling::node()[1][(local-name()='milestone' and (@rend='paragraphos'))
                or normalize-space(.)='' and following-sibling::node()[1][local-name()='milestone' and (@rend='paragraphos')]
                and $ww-context/following-sibling::node()[2][(local-name()='lb' and (@break='no' or @type='inWord'))
                or normalize-space(.)='' and following-sibling::node()[2][local-name()='lb' and (@break='no' or @type='inWord')]]]">
                <xsl:value-of select="true()"/>
            </xsl:when>
            <!-- Added to controll '-' when there is a milestone@rend='paragraphos' followed by a lb@break='no' see: https://github.com/DCLP/dclpxsltbox/issues/52 -->
            <xsl:when test="$ww-context/following-sibling::node()[1][(local-name()='milestone' and (@rend='paragraphos'))
                or normalize-space(.)='' and following-sibling::node()[1][local-name()='milestone' and (@rend='paragraphos')]
                and $ww-context/following-sibling::node()[2][(local-name()='lb' and (@break='no' or @type='inWord'))
                or normalize-space(.)='' and following-sibling::node()[2][local-name()='lb' and (@break='no' or @type='inWord')]]]">
                <xsl:value-of select="true()"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="false()"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
</xsl:stylesheet>