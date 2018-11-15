<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">

    <xsl:output
        method="xml"
        encoding="UTF-8" />

        <xsl:template match="/" >
        <xsl:variable name="var" select="TEI/teiHeader/fileDesc/title" />
            <root>
                <xsl:attribute name="attributo">
                    <xsl:value-of select="$var" />
                </xsl:attribute>
                <title><xsl:value-of select="$var" /></title>

                <xsl:for-each select="//div">
                    <div><xsl:value-of select="." /></div>
                </xsl:for-each>


            </root>
        </xsl:template>

</xsl:stylesheet>