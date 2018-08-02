<?xml version="1.0"?>
<!-- base-uri2.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:output method="html" include-content-type="no"/>

  <xsl:template match="/">
    <html>
      <head>
        <title>Here are some cars</title>
      </head>
      <body>
        <h1>Here are some cars:</h1>
        <xsl:apply-templates select="cars/manufacturer"/>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="manufacturer">
    <h2>
      <xsl:value-of select="@name"/>
    </h2>
    <ul>
      <xsl:for-each select="car">
        <li>
          <a href="{concat(base-uri(), ., '.html')}">
            <xsl:value-of select="."/>
          </a>
        </li>
      </xsl:for-each>
    </ul>
  </xsl:template>

</xsl:stylesheet>
