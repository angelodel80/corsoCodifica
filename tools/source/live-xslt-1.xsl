<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text" />
    <xsl:strip-space elements="expan abbr ex" />
    <xsl:template match="/">
        <xsl:apply-templates select="current()/descendant::text" />
    </xsl:template>
     <xsl:template match="div[@type='edition']|div[@type='translation']">
        <xsl:value-of select="normalize-space(.)" />
    </xsl:template>
    <xsl:template match="div" />
</xsl:stylesheet>