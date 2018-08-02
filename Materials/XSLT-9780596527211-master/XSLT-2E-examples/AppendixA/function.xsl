<?xml version="1.0" encoding="utf-8"?>
<!-- function.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:sample="http://www.oreilly.com/catalog/xslt"
  exclude-result-prefixes="xs sample">

  <xsl:output method="html" include-content-type="no"/>

  <xsl:variable name="colors" as="xs:string *"
    select="('yellow', 'white', 'blue')"/>

  <xsl:variable name="fontSizes" as="xs:integer *"
    select="(18, 24, 36)"/>

  <xsl:variable name="styles" as="xs:string *"
    select="('color: black;', 'color: black;', 
            'color: white; font-weight: bold;')"/>

  <xsl:template match="/">
    <html>
      <head>
        <title><xsl:value-of select="/list/title"/></title>
      </head>
      <body style="font-family: sans-serif;">
        <h1 style="font-size: 48;"><xsl:value-of select="/list/title"/></h1>
        <table border="3" cellpadding="5" cellspacing="5" width="50%">
          <tr>
            <xsl:for-each select="/list/listitem">
              <td style="font-size: {sample:getFontSize(position())};
                         {sample:getStyle(position())}"
                bgcolor="{sample:getColor(position())}">
                <xsl:value-of select="."/>
              </td>
            </xsl:for-each>
          </tr>
        </table>
      </body>
    </html>
  </xsl:template>

  <xsl:function name="sample:getColor" as="xs:string">
    <xsl:param name="pos" as="xs:integer"/>
    <xsl:value-of select="$colors[($pos mod count($colors)) + 1]"/>
  </xsl:function>

  <xsl:function name="sample:getStyle" as="xs:string">
    <xsl:param name="pos" as="xs:integer"/>
    <xsl:value-of select="$styles[($pos mod count($styles)) + 1]"/>
  </xsl:function>

  <xsl:function name="sample:getFontSize" as="xs:integer">
    <xsl:param name="pos" as="xs:integer"/>
    <xsl:value-of select="$fontSizes[($pos mod count($fontSizes)) + 1]"/>
  </xsl:function>

</xsl:stylesheet>
