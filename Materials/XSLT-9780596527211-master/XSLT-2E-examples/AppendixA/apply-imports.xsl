<?xml version="1.0"?>
<!-- apply-imports1.xsl -->
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:import href="imported.xsl"/>

  <xsl:preserve-space elements="programlisting"/> 

  <xsl:output method="html"/>

  <xsl:template match="chapter">
    <html>
      <head>
        <title>
          <xsl:value-of select="title"/>
        </title>
      </head>
      <body>
        <xsl:apply-templates select="*"/>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="title">
    <h1>
      <xsl:value-of select="."/>
    </h1>
  </xsl:template>

  <xsl:template match="para">
    <p>
      <xsl:apply-templates select="*|text()"/>
    </p>
  </xsl:template>

  <xsl:template match="programlisting">
    <div style="font-size: 125%; font-weight:bold; 
                font-family: monospace;">
      <xsl:apply-imports />
    </div>
  </xsl:template>

</xsl:stylesheet>
