<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
    xmlns="http://www.w3.org/1999/xhtml" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0">
  
    <xsl:output method="html" />
    
  <xsl:template match="/">
    <html>
        <head></head>
        <body>
            <xsl:call-template name="body" >
                <xsl:with-param name="style" >color:red</xsl:with-param>
            </xsl:call-template>
        </body>
    </html>
  </xsl:template>


    <xsl:template name="body" >
        <xsl:param name="style" >color:blue</xsl:param>
        <xsl:comment>USO DI PARAMENTRI IN FOGLIO DI STILE XSLT</xsl:comment>
        <div>
            <xsl:attribute name="style" >
                <xsl:value-of select="$style" />
            </xsl:attribute>
        <xsl:value-of select="." />
    </div>
    </xsl:template>

</xsl:stylesheet>