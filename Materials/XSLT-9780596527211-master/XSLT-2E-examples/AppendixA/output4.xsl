<?xml version="1.0"?>
<!-- output4.xsl -->
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"
    encoding="ISO-8859-3"
    indent="yes"
    omit-xml-declaration="no"
    standalone="yes"
    doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>

  <xsl:template match="/">
    <html>
      <head>
        <title><xsl:value-of select="/list/title"/></title>
      </head>
      <body>
        <h1><xsl:value-of select="/list/title"/></h1>
        <p>
          <xsl:for-each select="/list/listitem">
            <xsl:number format="1. "/>
            <xsl:value-of select="."/>
            <br/>
          </xsl:for-each>
        </p>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
