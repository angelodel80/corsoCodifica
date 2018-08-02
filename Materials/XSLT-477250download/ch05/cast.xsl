<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="xhtml" encoding="UTF-8"
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
        doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"/>

    <xsl:variable name="cast">
        <xsl:perform-sort select="//castItem">
            <xsl:sort select="."/>
        </xsl:perform-sort>
    </xsl:variable>
    <xsl:param name="style">reference.css</xsl:param>
    <xsl:template match="/">
        <html>
            <xsl:call-template name="head">
                <xsl:with-param name="title" select="PLAY/PERSONAE/TITLE"/>
                <xsl:with-param name="style" select="$style"/>
            </xsl:call-template>
            <body>
               <h2><xsl:value-of select="//castList/head"/></h2>
                <ul class="unmarked">
                <xsl:for-each select="$cast/castItem">
                    <li><xsl:value-of select="."/></li>
                </xsl:for-each>
                </ul>              
            </body>
        </html>
    </xsl:template>
    <xsl:template name="head">
        <xsl:param name="title"/>
        <xsl:param name="style"/>
        <head>
            <meta http-equiv="Content-Type" content="text/xml;charset=UTF-8"/>
            <title>
                <xsl:value-of select="$title"/>
            </title>
            <link rel="stylesheet" type="text/css">
                <xsl:attribute name="href">
                    <xsl:value-of select="$style"/>
                </xsl:attribute>
            </link>
        </head>
    </xsl:template>

</xsl:stylesheet>
