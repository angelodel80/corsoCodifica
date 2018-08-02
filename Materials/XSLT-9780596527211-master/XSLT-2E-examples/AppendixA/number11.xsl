<?xml version="1.0"?>
<!-- number11.xsl -->
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html"/>

  <xsl:template match="book">
    <html>
      <head>
        <title>Thai numbering</title>
      </head>
      <body style="font-family: sans-serif;">
        <h1>Thai numbering</h1>
        <p style="font-size: 150%">
          <xsl:for-each select=".//sect2">
            <xsl:number level="any" count="sect2"
              format="&#x0E51; "/>
            <xsl:value-of select="title"/>
            <br/>
          </xsl:for-each>
        </p>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
