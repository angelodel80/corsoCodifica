<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html" version="5" doctype-public="html" indent="yes" />
    <xsl:param name="title">TITOLO</xsl:param>
    <xsl:template match="/">
        <html>
            <head><title><xsl:value-of select="$title" /></title></head>
            <body>
                <xsl:call-template name="body">
                    <xsl:with-param name="style">color:red</xsl:with-param>
                </xsl:call-template>
            </body>
        </html>
    </xsl:template>

    <xsl:template name="body">
        <xsl:param name="style">color:blue</xsl:param>
        <div>
            <xsl:attribute name="style">
                <xsl:value-of select="$style" />
            </xsl:attribute>
            <xsl:value-of select="." />
        </div>
    </xsl:template>

</xsl:stylesheet>