<xsl:stylesheet xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xd:doc xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Nov 2, 2011</xd:p>
            <xd:p><xd:b>Author:</xd:b> gbodard</xd:p>
            <xd:p><xd:b>Author:</xd:b> flawrence</xd:p>
            <xd:p><xd:b>Author:</xd:b> rviglianti</xd:p>
            <xd:p/>
        </xd:desc>
    </xd:doc>
    
    <xsl:template match="comment()" mode="sqbrackets">
        <xsl:sequence select="."/>
    </xsl:template>
    
    <xsl:template match="*" mode="sqbrackets">
        <xsl:element name="{name()}">
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates mode="sqbrackets"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="fo:block" mode="sqbrackets">
        <xsl:sequence select="."/>
    </xsl:template>
    
    <xsl:template match="text()" mode="sqbrackets">
        <xsl:variable name="me" select="."/>
        <xsl:variable name="startspace" select="if (matches(substring(.,1,1),'[\n\r\s\t]')) then ' ' else ''"/>
        <xsl:variable name="endspace" select="if (matches(substring(.,string-length(.)),'[\n\r\s\t]')) then ' ' else ''"/>
        <xsl:variable name="current" select="replace(normalize-space(.), '([^\]])\](\s*)\[([^\[])', '$1$2$3')"/>
        <xsl:variable name="strlength" select="string-length($current)"/>
        <xsl:variable name="firstletter" select="substring($current, 1, 1)"/>
        <xsl:variable name="lastletter" select="substring($current, $strlength)"/>
        
        <xsl:value-of select="$startspace"/>
        
        <xsl:choose>
            <xsl:when test="$firstletter = '[' or $lastletter = ']'">
                
                <xsl:variable name="previous" select="preceding::text()[1]"/>
                <xsl:variable name="after" select="following::text()[1]"/>
                
                <!-- get the first text node before the next br (if this node matches current text node then there is a br between this text node and the next text node so don't strip brackets) -->
                <xsl:variable name="beforenextbr" select="following::fo:block[not(node())][1]/preceding::text()[1]"/>
                
                <!-- get the first next node following the preceding br (if this node matches current text node then there is a br between this text node and the previous text node so don't strip brackets)-->
                <xsl:variable name="afterprevbr" select="preceding::fo:block[not(node())][1]/following::text()[1]"/>
                <xsl:variable name="afirstletter" select="substring(normalize-space($after), 1, 1)"/>
                <xsl:variable name="plastletter" select="substring(normalize-space($previous), string-length(normalize-space($previous)))"/>
                
                <xsl:choose>
                    <xsl:when test="$firstletter = '[' and $lastletter = ']'                          and $plastletter = ']' and $afirstletter = '['                          and generate-id($afterprevbr) != generate-id(.)                          and generate-id($beforenextbr) != generate-id(.)">
                        <xsl:value-of select="substring($current, 2, string-length($current)-2)"/>
                    </xsl:when>
                    <xsl:when test="$plastletter = ']' and $firstletter = '[' and generate-id($afterprevbr) != generate-id(.)">
                        <xsl:value-of select="substring($current, 2)"/>
                    </xsl:when>
                    <xsl:when test="$afirstletter = '[' and $lastletter = ']' and generate-id($beforenextbr) != generate-id(.)">
                        <xsl:value-of select="substring($current, 1, string-length($current)-1)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$current"/>
                    </xsl:otherwise>
                </xsl:choose>
                
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$current"/>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:value-of select="$endspace"/>
        
    </xsl:template>
    
</xsl:stylesheet>