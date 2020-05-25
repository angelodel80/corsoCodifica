<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="text" />

    <xsl:template match="listBibl">
        [<xsl:value-of select="@n" />]
        <xsl:apply-templates />
    </xsl:template>

    <xsl:template match="title">
        titoli: <xsl:value-of select="." /> -
    </xsl:template>

    <xsl:template match="author">
        
    </xsl:template>

</xsl:stylesheet>
