<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output 
    method="html"
    indent="yes"
     />
<xsl:template match="/">
<html>
    <head><title><xsl:value-of select="TEI/teiHeader/fileDesc/title"/></title></head>
    <body>
        <div><span>1.</span>
            <xsl:apply-templates select="TEI/teiHeader/fileDesc" />
        </div>
        <div>2.<xsl:apply-templates select="TEI/teiHeader/profileDesc" /></div>
        <div style="color:blue"><xsl:apply-templates select="TEI/text/body" /></div>
    </body>
</html>
</xsl:template>

<xsl:template match="fileDesc">
    <h1>File Desc</h1>
    <p>
        <xsl:value-of select="titleStmt/title" disable-output-escaping="no" />
    </p>
</xsl:template>

<xsl:template match="profileDesc">
    <h2><xsl:apply-templates /></h2>
</xsl:template>

<xsl:template match="head">
    <xsl:copy>
        <xsl:apply-templates />
    </xsl:copy>
</xsl:template>

<xsl:template match="p">
    <p><xsl:apply-templates /></p>
</xsl:template>

<xsl:template match="seg | rs">
    <span style="color:red">
        <xsl:value-of select="." />
    </span>
</xsl:template>


</xsl:stylesheet>
