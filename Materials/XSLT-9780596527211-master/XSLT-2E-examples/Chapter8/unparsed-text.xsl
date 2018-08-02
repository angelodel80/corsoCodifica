<?xml version="1.0"?>
<!-- unparsed-text.xsl -->
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html"/>

  <xsl:template match="/">
    <html>
      <head>
        <title>Customer Addresses</title>
      </head>
      <body style="font-family: sans-serif;">
        <h1>Customer Addresses</h1>
        <table width="60%" border="0">
          <tr style="background: #66FF66;">
            <th>Name</th>
            <th>Street</th>
            <th>City</th>
            <th>State</th>
            <th>Zip</th>
          </tr>
          <xsl:for-each 
            select="tokenize(unparsed-text('addresses.csv'), '\r?\n')">
            <xsl:variable name="tokens" select="tokenize(., ',')"/>
            <xsl:if test="count($tokens)">
              <tr style="{if (position() mod 2) 
                         then 'background: #CCCCFF;'
                         else 'background: #66FF66;'}">
                <td width="40%">
                  <xsl:value-of 
                    select="subsequence($tokens, 1, 2)" separator=" "/>
                  <xsl:text> </xsl:text>
                  <span style="font-weight: bold; font-size: 125%;">
                    <xsl:value-of select="subsequence($tokens, 3, 1)"/>
                  </span>
                </td>
                <td width="20%">
                  <xsl:value-of select="subsequence($tokens, 4, 1)"/>
                </td>
                <td width="20%">
                  <xsl:value-of select="subsequence($tokens, 5, 1)"/>
                </td>
                <td width="10%" style="text-align: center;">
                  <xsl:value-of select="subsequence($tokens, 6, 1)"/>
                </td>
                <td width="10%" style="text-align: center;">
                  <xsl:value-of select="subsequence($tokens, 7, 1)"/>
                </td>
              </tr>
            </xsl:if>
          </xsl:for-each>
        </table>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
