<?xml version="1.0"?>
<!-- next-match.xsl -->
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html"/>

  <xsl:template match="html">
    <html>
      <head>
        <title>
          <xsl:value-of select="head/title"/>
        </title>
      </head>
      <body style="font-family: sans-serif;">
        <xsl:apply-templates select="body/*"/>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="h1/code">
    <span style="color: red;">
      <xsl:next-match/>
    </span>
  </xsl:template>

  <xsl:template match="code">
    <span style="font-family: monospace;">
      <xsl:apply-templates select="*|text()"/>
    </span>
  </xsl:template>

  <xsl:template match="h1">
    <h1>
      <xsl:apply-templates select="*|text()"/>
    </h1>
  </xsl:template>

  <xsl:template match="p">
    <p>
      <xsl:apply-templates select="*|text()"/>
    </p>
  </xsl:template>

</xsl:stylesheet>
