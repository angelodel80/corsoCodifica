<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
    xmlns="http://www.w3.org/1999/xhtml" 
    xmlns:html="http://www.w3.org/1999/xhtml" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="URL//:tei/tei/">
  <xsl:output method="html" />

    <xsl:template match="/" >
        <html>
            <head>
                <title>
                    <xsl:value-of
                select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/>
                </title>
            </head>
            <body>
                <div>
                    <span>1.</span>
                    <xsl:apply-templates
                        />
                </div>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="tei:TEI">
        <xsl:apply-templates />

        <xsl:choose>
            <xsl:when test="xpath condition">
                <!-- istruzioni  -->
            </xsl:when>

            <xsl:when test="xpath contidion">
                <!-- istruzioni  -->
            </xsl:when>
            
            <xsl:otherwise>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="tei:fileDesc">
        <ol>
            <xsl:for-each select="tei:titleStmt/tei:title">
                <li><xsl:value-of select="."></li>
            </xsl:for-each>
        </ol>
    </xsl:template>



</xsl:stylesheet>