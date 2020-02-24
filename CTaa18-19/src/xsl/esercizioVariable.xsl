<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html" version="5" doctype-public="html" indent="yes" />
    <xsl:variable name="main" select="document('../main.xml')" />
    <xsl:variable name="title">TITOLO</xsl:variable>
    <xsl:template match="/">
        <html>
            <head><title><xsl:value-of select="$title" /></title></head>
            <body>
                <xsl:value-of select="$main/root/@attributo" />
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>