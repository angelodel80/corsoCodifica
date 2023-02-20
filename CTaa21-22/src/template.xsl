<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                
                version="1.0">
    <xsl:output method="html" encoding="UTF-8" indent="yes" />
    <xsl:template match="/">
        <html>
            <head>
               
                <title>
                    <xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title" />
                </title>

                 <link rel="stylesheet" type="text/css" href="./mycss.css" />
                <style>
                    h1{
                        color:blue;
                    }
                </style>
            </head>
            <body>
                <div class="index">
                    <h1>INDEX</h1>
                    <ul>
                        <xsl:apply-templates select="//div[@type='chapter']" mode="index" />
                    </ul>
                </div>
                <div>
                    <xsl:apply-templates select="child::node()" />
                </div>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="div" mode="index">
        <ul>
            <xsl:for-each select=".">
                <li>
                    <xsl:value-of select="head" />
                </li>
            </xsl:for-each>
        </ul>
    </xsl:template>
    <xsl:template match="titleStmt/title">
        <h2>
            <xsl:value-of select="." />
        </h2>
    </xsl:template>
    <xsl:template match="div/head">
        <h3>
            <xsl:value-of select="." />
        </h3>
    </xsl:template>

    <xsl:template match="tei:persName">
        <a href="http://">
            <xsl:value-of select="current()/text()" />
        </a>
    </xsl:template>
    
    <xsl:template match="teiHeader">
    <span>[identificativo del documento: <xsl:value-of select="@xml:id" />]</span>
</xsl:template>


</xsl:stylesheet>