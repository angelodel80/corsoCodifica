<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
       xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
       xmlns:tei="http://www.tei-c.org/ns/1.0"
       xmlns="http://www.w3.org/1999/xhtml">
       
       <xsl:output 
            method="html" 
            encoding="UTF-8" 
            indent="yes"
            omit-xml-declaration="yes" />

        <xsl:template match="/tei:TEI">
            <html>
                <head>
                    <title> *-* Titolo del documento *-* </title>
                    <link href="stile.css" rel="stylesheet" type="text/css"/>
                </head>
                <body>
                    <xsl:apply-templates />
                </body> 
            </html>
        </xsl:template>

        <xsl:template match="tei:text/tei:teiHeader">
            <h1>Informazioni sul documento</h1>
            <xsl:apply-templates />
        </xsl:template>

        <xsl:template match="tei:text/tei:front">
            <h1>Frontespizio e prefazione</h1> <br/>
            <xsl:apply-templates/>
        </xsl:template>
    
        <xsl:template match="tei:text/tei:body">
            <h1>Testo</h1> <br/>
            <xsl:apply-templates/>
        </xsl:template>
    
        <xsl:template match="tei:text/tei:back">
            <h1>Appendici</h1> <br/>
            <xsl:apply-templates/>
        </xsl:template>

        <xsl:template match="tei:div" mode="front">
            <br /><hr width="75%"/><br />
            <xsl:apply-templates/>
        </xsl:template>

        <xsl:template match="tei:div">
            <p><xsl:apply-templates/></p>
        </xsl:template>
        
        <xsl:template match="tei:byline">
            <p><xsl:apply-templates/></p>
        </xsl:template>

        <xsl:template match="tei:lg">
            <p>
                <xsl:if test="@">
                    <b><xsl:value-of select="@n" /></b>
                </xsl:if>
            </p>
        </xsl:template>
        
        <xsl:template match="tei:l">
            <xsl:apply-templates /><br/>
        </xsl:template>

        <xsl:template match="//tei:div/tei:head">
            <h3 class="center"><xsl:apply-templates /></h3>
        </xsl:template>

        <xsl:template match="tei:term">
            <b><i><xsl:apply-templates /></i></b>
        </xsl:template>

        <xsl:template match="tei:sic">
            <xsl:apply-templates />
        </xsl:template>
        
        <xsl:template match="tei:corr">
            [<xsl:apply-templates />]
        </xsl:template>
        
        <xsl:template match="tei:orig">
            [<xsl:apply-templates />]
        </xsl:template>
        
        <xsl:template match="tei:reg">
            [<xsl:apply-templates />]
        </xsl:template>

        <xsl:template match="tei:emph">
            <b><xsl:apply-templates/></b>
        </xsl:template>
   
        <xsl:template match="tei:distinct">
            <font FACE="Garamond, Times, serif">
                <xsl:apply-templates/>
            </font>
        </xsl:template>

        <xsl:template match="tei:hi">
            <xsl:choose>
                <xsl:when test="@rend='italic'">
                    <i><xsl:apply-templates/></i>
                </xsl:when>
                <xsl:when test="@rend='bold'">
                    <b><xsl:apply-templates/></b>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:template>

        <xsl:template match="tei:lb">
            <br/> <xsl:if test="./@n">
                <span class="line">
                    <xsl:value-of select="current()/@n" />
                </span>
            </xsl:if>
        </xsl:template>

</xsl:stylesheet>

