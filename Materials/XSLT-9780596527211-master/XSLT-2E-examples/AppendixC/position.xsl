<?xml version="1.0"?>
<!-- position.xsl -->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html"/>

  <xsl:template match="/">
    <html>
      <head>
        <title>
          <xsl:value-of select="/list/title"/>
        </title>
      </head>
      <body style="font-family: sans-serif;">
        <h1>
          <xsl:value-of select="/list/title"/>
        </h1>
        <table border="1" cellpadding="5">
          <xsl:for-each select="/list/listitem">
            <xsl:variable name="style">
              <xsl:text>color: </xsl:text>
              <xsl:choose>
                <xsl:when test="position() mod 3 = 1">white</xsl:when>
                <xsl:when test="position() mod 3 = 2">white</xsl:when>
                <xsl:otherwise>black</xsl:otherwise>
              </xsl:choose>
              <xsl:text>; background: </xsl:text>
              <xsl:choose>
                <xsl:when test="position() mod 3 = 1">black</xsl:when>
                <xsl:when test="position() mod 3 = 2">gray</xsl:when>
                <xsl:otherwise>white</xsl:otherwise>
              </xsl:choose>
              <xsl:text>;</xsl:text>
            </xsl:variable>
            <tr style="{$style}">
              <td>
                <b><xsl:value-of select="."/></b>
              </td>
            </tr>
          </xsl:for-each>
        </table>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
