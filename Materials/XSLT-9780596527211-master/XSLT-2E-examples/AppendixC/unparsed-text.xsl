<?xml version="1.0"?>
<!-- unparsed-text.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:output method="html"/>

  <xsl:variable name="reportTitle">
    <xsl:value-of select="/report/title"/>
    <xsl:text> for </xsl:text>
    <xsl:value-of select="/report/@month"/>
    <xsl:text>/</xsl:text>
    <xsl:value-of select="/report/@year"/>
  </xsl:variable>

  <xsl:template match="/">
    <html>
      <head>
        <title>
          <xsl:value-of select="$reportTitle"/>
        </title>
      </head>
      <body style="font-family: sans-serif;">
        <xsl:value-of 
          select="unparsed-text('header.html')"
          disable-output-escaping="yes"/>
        <xsl:apply-templates select="*|text()"/>
        <xsl:value-of 
          select="unparsed-text('footer.html')"
          disable-output-escaping="yes"/>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="title">
    <h1>
      <xsl:value-of select="$reportTitle"/>
    </h1>
  </xsl:template>

  <xsl:template match="brand">
    <h2>
      <xsl:value-of select="name"/>
      <xsl:text> : </xsl:text>
      <xsl:value-of select="units"/>
    </h2>
  </xsl:template>

</xsl:stylesheet>
