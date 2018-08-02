<?xml version="1.0"?>
<!-- for-each-group_group-by.xsl -->
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html"/>

  <xsl:template match="/">
    <html>
      <head>
        <title>Customers grouped by Zip code</title>
      </head>
      <body style="font-family: sans-serif;">
        <table border="1" cellpadding="5">
          <xsl:for-each-group select="/addressbook/address" 
            group-by="zip">
            <xsl:sort select="current-grouping-key()"/>
            <xsl:for-each select="current-group()">
              <xsl:sort select="name/last-name"/>
              <xsl:sort select="name/first-name"/>
              <tr>
                <xsl:if test="position() = 1">
                  <td style="background: #66FF66; text-align: center; 
                             vertical-align: middle; font-weight: bold;"
                    rowspan="{count(current-group())}">
                    <xsl:text>Zip code </xsl:text>
                    <br/>
                    <span style="font-size: 150%;">
                      <xsl:value-of select="zip"/>
                    </span>
                    <br/>
                    <xsl:value-of select="city"/>
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="state"/>
                  </td>
                </xsl:if>
                <td style="text-align: right; vertical-align: middle;">
                  <xsl:value-of select="name/first-name"/>
                  <xsl:text> </xsl:text>
                  <span style="font-weight: bold; font-size: 125%;">
                    <xsl:value-of select="name/last-name"/>
                  </span>
                </td>
                <td>
                  <xsl:value-of select="street"/>
                  <xsl:text>, </xsl:text>
                  <xsl:value-of select="city"/>
                  <xsl:text>, </xsl:text>
                  <xsl:value-of select="state"/>
                  <xsl:text> </xsl:text>
                  <xsl:value-of select="zip"/>
                </td>
              </tr>
            </xsl:for-each>
          </xsl:for-each-group>
        </table>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
