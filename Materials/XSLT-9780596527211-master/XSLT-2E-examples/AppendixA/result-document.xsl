<?xml version="1.0" encoding="utf-8"?>
<!-- result-document.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html" include-content-type="no"/>

  <xsl:template match="/">
    <html>
      <head>
        <title><xsl:value-of select="book/title"/></title>
      </head>
      <body>
        <h1><xsl:value-of select="book/title"/></h1>
        <p>Here are some interesting XSLT topics:</p>
        <ul>
          <xsl:for-each select="book/chapter">
            <li>
              <a href="{concat('chapter', position(), '.html')}">
                <xsl:value-of select="title"/>
              </a>
            </li>
          </xsl:for-each>
        </ul>
        <xsl:for-each select="book/chapter">
          <xsl:result-document method="html" 
            include-content-type="no"
            href="{concat('chapter', position(), '.html')}">
            <html>
              <head>
                <title><xsl:value-of select="title"/></title>
              </head>
              <body>
                <h1><xsl:value-of select="title"/></h1>
                <xsl:apply-templates select="*[position() > 1]"/>
              </body>
            </html>
          </xsl:result-document>
        </xsl:for-each>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="para">
    <p><xsl:apply-templates select="*|text()"/></p>
  </xsl:template>

</xsl:stylesheet>
