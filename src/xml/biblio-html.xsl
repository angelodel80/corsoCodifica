<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <xsl:output method="html" />

    <xsl:template match="/">
        <html>
            <head>
                <title>elenco bibliografia</title>
                <meta charset="UTF-8" />

                <style type="text/css">
                    body {
                        color:blue;
                    }
                    .bold {
                        font-weight:bold;
                    }
                    .italic {
                        font-style:italic;
                    }
                    .underline {
                        text-decoration:underline;
                    }
                </style>

            </head>

            <body>
                <h1>elenco bibliografia</h1>
                <ul>
                    <xsl:for-each select="listBibl/bib/biblInfo">
                        <li>

                           <span class="bold">titolo: </span> <span class="italic"> <xsl:value-of select="title" />; </span>  
                           <span class="bold">autore: </span> <span class="italic"> <xsl:value-of select="author" />; </span>
                           <span class="bold">cost: </span> <span class="underline">
                           <xsl:value-of select="cost" /> euro</span>.
                           <xsl:if test="cost &lt; 20"> * </xsl:if>

                        </li>
                
                    </xsl:for-each>

                </ul>
            </body>
        </html>

    </xsl:template>

</xsl:stylesheet>