<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="/">
        <xsl:value-of select="//titleStmt" />
    </xsl:template>

    <xsl:template match="body">
        <xsl:text>REGOLA DIV : </xsl:text>
       <xsl:apply-templates select="div" />
    </xsl:template>
    
    <xsl:template match="div">
        <xsl:value-of select="concat(' ', @type)" />
        <!--xsl:apply-templates /-->
    </xsl:template>

    <xsl:template match="head">
        <xsl:value-of select="." />
    </xsl:template>

    <xsl:template match="lb">
            <xsl:text>RIGA</xsl:text>
    </xsl:template>

</xsl:stylesheet>
