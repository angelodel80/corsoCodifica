<?xml version="1.0" encoding="utf-8"?>
<!-- normal_parameters.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html"/>

  <xsl:template match="/">
    <xsl:result-document href="regular-type.html" method="html">
      <html>
        <xsl:apply-templates select="*|text()">
          <xsl:with-param name="code-font-size" select="'14'"/>
        </xsl:apply-templates>
      </html>
    </xsl:result-document>
    <xsl:result-document href="larger-type.html" method="html">
      <html>
        <xsl:apply-templates select="*|text()">
          <xsl:with-param name="code-font-size" select="'20'"/>
        </xsl:apply-templates>
      </html>
    </xsl:result-document>
  </xsl:template>

  <xsl:template match="chapter">
    <xsl:param name="code-font-size"/>
    <head>
      <title><xsl:value-of select="title"/></title>
    </head>
    <body>
      <xsl:apply-templates select="*[not(name() = 'title')]|text()">
        <xsl:with-param name="code-font-size" select="$code-font-size"/>
      </xsl:apply-templates>
    </body>
  </xsl:template>

  <xsl:template match="programlisting">
    <xsl:param name="code-font-size"/>
    <pre>
      <span>
        <xsl:attribute name="style">
          <xsl:text>font-family:monospace; font-size:</xsl:text>
          <xsl:value-of select="$code-font-size"/>
          <xsl:text>;</xsl:text>
        </xsl:attribute>
        <xsl:apply-templates select="*|text()">
          <xsl:with-param name="code-font-size" select="$code-font-size"/>
        </xsl:apply-templates>
      </span>
    </pre>
  </xsl:template>

  <xsl:template match="sect1/title">
    <xsl:param name="code-font-size"/>
    <h1>
      <xsl:apply-templates select="*|text()">
        <xsl:with-param name="code-font-size" select="$code-font-size"/>
      </xsl:apply-templates>
    </h1>
  </xsl:template>

  <!-- A useful stylesheet would have dozens more templates here... -->
  <xsl:template match="*">
    <xsl:param name="code-font-size"/>
    <xsl:apply-templates select="*">
      <xsl:with-param name="code-font-size" select="$code-font-size"/>
    </xsl:apply-templates>
  </xsl:template>

</xsl:stylesheet>
