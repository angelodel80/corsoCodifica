<?xml version="1.0" encoding="utf-8"?>
<!-- simple-function.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:sample="http://www.oreilly.com/catalog/xslt"
  exclude-result-prefixes="xs sample">

  <xsl:output method="html" include-content-type="no"/>

  <xsl:variable name="colors" as="xs:string *"
    select="('green', 'grey', 'blue', 'red')"/>

  <xsl:template match="/">
    <html>
      <head>
        <title>A table with different background colors</title>
      </head>
      <body style="font-family: sans-serif;">
        <h1 style="font-size: 28;">
          A table with different background colors:
        </h1>
        <table border="3" cellpadding="5" cellspacing="5" width="50%">
          <tr>
            <xsl:for-each select="1 to 12">
              <td style="font-size: 48; color: black; 
                         font-weight: bold; text-align: center;"
                bgcolor="{sample:getBackgroundColor(position())}">
                <xsl:value-of select="."/>
              </td>
            </xsl:for-each>
          </tr>
        </table>
      </body>
    </html>
  </xsl:template>

  <xsl:function name="sample:getBackgroundColor" as="xs:string">
    <xsl:param name="pos" as="xs:integer"/>
    <xsl:value-of select="$colors[($pos mod count($colors)) + 1]"/>
  </xsl:function>

</xsl:stylesheet>
