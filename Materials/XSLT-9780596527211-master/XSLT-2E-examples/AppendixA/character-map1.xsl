<?xml version="1.0" encoding="utf-8"?>
<!-- character-map1.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html" use-character-maps="sample"/>

  <xsl:character-map name="sample" use-character-maps="circles">
    <xsl:output-character character="&#x9;" string="  "/>
  </xsl:character-map>

  <xsl:character-map name="circles">
    <xsl:output-character character="&#x2780;"
      string="&lt;img src='images/circle1.gif'
      width='28' height='28'/&gt;"/>
    <xsl:output-character character="&#x2781;"
      string="&lt;img src='images/circle2.gif'
      width='28' height='28'/&gt;"/>
  </xsl:character-map>

  <xsl:template match="char-test">
    <html>
      <head>
        <title>A test of some special characters</title>
      </head>
      <body style="font-family: sans-serif;">
        <h1>A test of some special characters</h1>
        <xsl:apply-templates select="*"/>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="tabs">
    <pre style="font-size: 150%; font-weight: bold;">
      <xsl:value-of select="."/>
    </pre>
  </xsl:template>

  <xsl:template match="special-char">
    <p style="font-size: 200%;">
      <xsl:text>Here's a special character: </xsl:text>
      <xsl:value-of select="."/>
    </p>
  </xsl:template>

</xsl:stylesheet>
