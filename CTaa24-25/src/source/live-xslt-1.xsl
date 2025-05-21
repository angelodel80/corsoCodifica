<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" />
    <xsl:strip-space elements="expan abbr ex" />
    
    <xsl:template match="/">
        <html>
            <head>
                <title>
                    <xsl:value-of select="//titleStmt/title" />
                </title>
                <style>
                .edition{color:red}
                </style>
            </head>
            <body>
                <xsl:apply-templates select="current()/descendant::text" />
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="div[@type='edition']|div[@type='translation']">
        
        <xsl:element name="div">
            <xsl:attribute name="class">
                <xsl:value-of select="@type"></xsl:value-of>
            </xsl:attribute>
            <xsl:value-of select="normalize-space(.)" />
        </xsl:element>
        
    </xsl:template>
   
    <xsl:template match="div" />

</xsl:stylesheet>