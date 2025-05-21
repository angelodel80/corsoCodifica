<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8" />
    
    <xsl:template match="/">
      <html>
        <head>
          <title>test</title>
        </head>
        <body>
          <xsl:element name="h1">
            <xsl:value-of
       select="descendant::langUsage/language[@ident='it']/preceding-sibling::*[1]/text()"
      />
          </xsl:element>
        </body>
      
      </html>

    </xsl:template>

</xsl:stylesheet>
