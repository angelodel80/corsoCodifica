<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html" version="5" doctype-public="html" indent="yes" />
    <xsl:variable name="main" select="document('../main.xml')" />
    <xsl:variable name="title">TITOLO</xsl:variable>
    <xsl:template match="/">
        <html>
            <head>
                <title>
                    <xsl:value-of select="$title" />
                </title>
            </head>
            <body>
                <div><xsl:apply-templates select="TEI/teiHeader" /></div>
                <div><ul>
                    <xsl:for-each select="TEI/text/body/div">
                        <xsl:sort select="@n" data-type="number" order="descending" />
                        <li>
                            <xsl:value-of select="@n" />
                            <xsl:text>|</xsl:text>
                            <xsl:value-of select="current()" />
                        </li>
                    </xsl:for-each>
                    </ul>
                </div>
            </body>
        </html>
    </xsl:template>


</xsl:stylesheet>