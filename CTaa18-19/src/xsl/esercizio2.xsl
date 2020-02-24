<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="xml" encoding="UTF-8" indent="yes" />
    <xsl:template match="/">
        <xsl:variable name="var" select="TEI/teiHeader/fileDesc/title" />
        <xsl:variable name="sub" select="substring-before(TEI/text/body/div[3],':')" />
        <xsl:variable name="pref" select="substring(TEI/text/body/div[4],1,3)" />
        <xsl:variable name="root" select="/TEI" />
        <xsl:variable name="tel" select="//div[@type='tel']" />
        <root>
            <xsl:attribute name="attributo">
                <xsl:value-of select="concat($var,'-ciao')" />
            </xsl:attribute>
            <title>
                <xsl:if test="contains(TEI/teiHeader/@xml:id,'ident')">
                <xsl:attribute name="type">
                    <xsl:value-of select="$pref" />
                </xsl:attribute>
                </xsl:if>
                <xsl:value-of select="$sub" />
            </title>
            <update>
                <xsl:value-of select="count(//div)" />
            </update>
            <tel>
                <xsl:value-of select="$tel" />
            </tel>
            <xsl:for-each select="//div">
                <div>
                    <xsl:value-of select="./p" />
                </div>
            </xsl:for-each>
        </root>
    </xsl:template>
</xsl:stylesheet>