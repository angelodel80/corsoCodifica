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
                <xsl:apply-templates select="TEI/teiHeader" />
                <div><xsl:apply-templates select="TEI/text/body" /></div>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="div">
        <xsl:if test="current()/@*">
        attributi:
        <xsl:variable name="attr" select="current()/@*" />
            <xsl:for-each select="$attr">
                <xsl:value-of select="concat('[',position(),']',current())" />
                <xsl:text>&#32;</xsl:text>
            </xsl:for-each>
        </xsl:if>
        <br />
        contenuto: <xsl:value-of select="current()" />
        <br />
    </xsl:template>

    <xsl:template match="TEI/teiHeader">
        <h2>
            Intestazione TEI
        </h2>
        <div>
            <xsl:choose>
                <xsl:when test="current()/fileDesc/titleStmt/author">
                    <xsl:variable name="autore" select="current()/fileDesc/titleStmt/author" />
                    <p>Autore: <xsl:value-of select="$autore" /></p>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:variable name="autore">Autore non presente</xsl:variable>
                    <p>Autore: <xsl:value-of select="$autore" /></p>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates />
        </div>
    </xsl:template>

    <xsl:template match="fileDesc/publicationStmt">
        <p>
            <xsl:value-of select="current()/p" />
        </p>

    </xsl:template>


</xsl:stylesheet>