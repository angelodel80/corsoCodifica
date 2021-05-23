<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text"  encoding="UTF-8" />

    <xsl:variable name="space">
        <xsl:text>&#x20;</xsl:text>
    </xsl:variable>


    <xsl:variable name="tab">
        <xsl:text>&#x9;</xsl:text>
    </xsl:variable>

    <xsl:variable name="newline">
        <xsl:text>&#x0A;</xsl:text>
    </xsl:variable>

    <xsl:template match="/">
        <xsl:value-of 
        select="concat(
                        'POS',$tab,
                        'AnalisiSintattica', $tab, 
                        'ID', $tab,
                        'Token', $tab,
                        'Verso', $tab,
                        'Lemma', $tab,
                        'Traduzione lessicale ENG', $tab,
                        'Traduzione letterale ENG',
                        $newline)" />
        
        <xsl:apply-templates select="//line"/>    

    </xsl:template>

    <xsl:template match="line">
        <xsl:variable name="tokens" select="tokenize(./text(),'\s+')" />
        <xsl:variable name="doc" select="/doc" />
        <xsl:variable name="lineID" select="attribute::n" />

        <xsl:for-each select="$tokens">
            <xsl:value-of select="$space" />
            <xsl:value-of select="$tab" />
            <xsl:value-of select="$space" />
            <xsl:value-of select="$tab" />
            <xsl:value-of select="concat($doc/@n,'.',$lineID)" />
            <xsl:value-of select="$tab" />

            <xsl:value-of select="." />
            <xsl:value-of select="$newline" />
        </xsl:for-each>

    </xsl:template> 


</xsl:stylesheet>