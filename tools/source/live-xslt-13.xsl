<xsl:stylesheet version="2.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text" encoding="UTF-8" />
    <xsl:strip-space elements="*" />

    <xsl:template match="/">
        <xsl:value-of select="concat('&#10;','title : ', normalize-space(descendant::titleStmt/title=>string()))" />
        <xsl:apply-templates select="//text//div" />
    </xsl:template>

    <xsl:template match="div">
        <xsl:text>&#10;</xsl:text>
        <xsl:value-of select="name(.)=>concat(' : ',@type)" />
        <xsl:text>&#10;</xsl:text>
        <xsl:apply-templates select="head" />
    </xsl:template>

    <xsl:template match="head">
        <xsl:value-of select="name(.)=>concat(' : ', .,'&#10;')" />
        <xsl:apply-templates select="following-sibling::*" />
    </xsl:template>

    <xsl:template match="lb">
        <xsl:value-of select="concat('&#10;', 'riga ' , current()/@n, ' : ')" />
    </xsl:template>

</xsl:stylesheet>
