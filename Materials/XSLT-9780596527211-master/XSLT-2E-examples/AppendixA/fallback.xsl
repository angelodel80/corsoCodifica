<?xml version="1.0"?>
<!-- fallback.xsl -->
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:db="xalan://DatabaseExtension"
  extension-element-prefixes="db">

  <xsl:output method="html"/>

  <xsl:template match="/">
    <html>
      <head>
        <title><xsl:value-of select="report/title"/></title>
      </head>
      <body>
        <h1><xsl:value-of select="report/title"/></h1>
        <xsl:for-each select="report/section">
          <h2><xsl:value-of select="title"/></h2>
          <xsl:for-each select="dbaccess">
            <db:accessDatabase>
              <xsl:fallback>
                <p>Sorry, the database library is not available!</p>
              </xsl:fallback> 
            </db:accessDatabase>
          </xsl:for-each>
        </xsl:for-each>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
