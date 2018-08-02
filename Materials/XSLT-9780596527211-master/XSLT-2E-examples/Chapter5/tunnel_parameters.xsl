<?xml version="1.0" encoding="utf-8"?>
<!-- tunnel_parameters.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html"/>

  <xsl:template match="/">
    <xsl:result-document href="regular-type.html" method="html">
      <html>
        <xsl:apply-templates select="*|text()">
          <xsl:with-param name="code-font-size" select="'14'"
            tunnel="yes"/>
        </xsl:apply-templates>
      </html>
    </xsl:result-document>
    <xsl:result-document href="larger-type.html" method="html">
      <html>
        <xsl:apply-templates select="*|text()">
          <xsl:with-param name="code-font-size" select="'20'"
            tunnel="yes"/>
        </xsl:apply-templates>
      </html>
    </xsl:result-document>
  </xsl:template>

  <xsl:template match="chapter">
    <head>
      <title><xsl:value-of select="title"/></title>
    </head>
    <body>
      <xsl:apply-templates select="*[not(name() = 'title')]|text()"/>
    </body>
  </xsl:template>

  <xsl:template match="programlisting">
    <xsl:param name="code-font-size" tunnel="yes"/>
    <pre>
      <span>
        <xsl:attribute name="style">
          <xsl:text>font-family:monospace; font-size:</xsl:text>
          <xsl:value-of select="$code-font-size"/>
          <xsl:text>;</xsl:text>
        </xsl:attribute>
        <xsl:apply-templates select="*|text()"/>
      </span>
    </pre>
  </xsl:template>

  <xsl:template match="sect1/title">
    <h1>
      <xsl:apply-templates select="*|text()"/>
    </h1>
  </xsl:template>

  <!-- A useful stylesheet would have dozens more templates here... -->
  <xsl:template match="*">
    <xsl:apply-templates select="*"/>
  </xsl:template>

</xsl:stylesheet>
