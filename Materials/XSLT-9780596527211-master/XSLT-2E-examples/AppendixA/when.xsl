<?xml version="1.0"?>
<!-- when.xsl -->
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html"/>

  <xsl:template match="/">
    <html>
      <head>
        <title>
          <xsl:value-of select="list/title"/>
        </title>
      </head>
      <body style="font-family: sans-serif; color: white;">
        <h1 style="color: black;">
          <xsl:value-of select="list/title"/>
        </h1>
        <table border="1" cellpadding="5" 
          style="font-weight: bold;">
          <xsl:for-each select="list/listitem">
            <tr>
              <td>
                <xsl:attribute name="style">
                  <xsl:choose>
                    <xsl:when test="position() mod 4 = 0">
                      <xsl:text>background: yellow; color: black;</xsl:text>
                    </xsl:when>
                    <xsl:when test="position() mod 4 = 1">
                      <xsl:text>background: blue;</xsl:text>
                    </xsl:when>
                    <xsl:when test="position() mod 4 = 2">
                      <xsl:text>background: white; color: black;</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:text>background: black;</xsl:text>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:attribute>
                <xsl:value-of select="."/>
              </td>
            </tr>
          </xsl:for-each>
        </table>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
