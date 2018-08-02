<?xml version="1.0"?>
<!-- element-available.xsl -->
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:redirect="org.apache.xalan.xslt.extensions.Redirect"
  extension-element-prefixes="redirect">

  <xsl:output method="html"/>

  <xsl:template match="/">
    <xsl:choose>
      <xsl:when test="element-available('redirect:write')">
        <xsl:for-each select="/book/chapter">
          <redirect:write select="concat('chapter', position(), '.html')">
            <html>
              <head>
                <title><xsl:value-of select="title"/></title>
              </head>
              <body>
                <h1><xsl:value-of select="title"/></h1>
                <xsl:apply-templates select="para"/>
                <xsl:if test="not(position()=1)">
                  <p>
                    <a href="chapter{position()-1}.html">Previous</a>
                  </p>
                </xsl:if>
                <xsl:if test="not(position()=last())">
                  <p>
                    <a href="chapter{position()+1}.html">Next</a>
                  </p>
                </xsl:if>
              </body>
            </html>
          </redirect:write>
        </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
        <html>
          <head>
            <title><xsl:value-of select="/book/title"/></title>
          </head>
          <xsl:for-each select="/book/chapter">
            <h1><xsl:value-of select="title"/></h1>
            <xsl:apply-templates select="para"/>
          </xsl:for-each>
        </html>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="para">
    <p><xsl:apply-templates select="*|text()"/></p>
  </xsl:template>

</xsl:stylesheet>
