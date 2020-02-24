<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <xsl:template match="/">
        <html>

        <head>
            <style>
                h1 {
                    text-align:center;
                }
            </style>
        </head>

        <body>
            <h1>
                <xsl:value-of select="element" />
            </h1>
        </body>

        </html>
    </xsl:template>

</xsl:stylesheet>