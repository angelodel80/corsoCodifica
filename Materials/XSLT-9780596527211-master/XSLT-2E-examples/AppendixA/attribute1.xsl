<?xml version="1.0"?>
<!-- attribute1.xsl -->
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html"/>

  <xsl:template match="/">
    <html>
      <head>
        <title><xsl:value-of select="list/title"/></title>
      </head>
      <body style="font-family: sans-serif;">
        <xsl:apply-templates select="list"/>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="list">
    <table border="1" cellpadding="5" cellspacing="5">
      <tr>
        <td style="background: black; color: white; 
                   font-weight: bold; font-size: 125%;" 
                   width="100" align="right">
          <xsl:if test="count(listitem) > 1">
            <xsl:attribute name="rowspan">
              <xsl:value-of select="count(listitem)"/>
            </xsl:attribute>
          </xsl:if>
          <xsl:value-of select="title"/>
        </td>
        <td>
          <xsl:value-of select="listitem[1]"/>
        </td>
      </tr>
      <xsl:for-each select="listitem[position() &gt; 1]">
        <tr>
          <td>
            <xsl:value-of select="."/>
          </td>
        </tr>
      </xsl:for-each>
    </table>
  </xsl:template>

</xsl:stylesheet>
