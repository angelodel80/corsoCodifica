<?xml version="1.0"?>
<!-- attribute-set.xsl -->
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html"/>

  <xsl:attribute-set name="bold-table">
    <xsl:attribute name="style">
      font-weight: bold; 
    </xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="spacious-table" 
    use-attribute-sets="bold-table">
    <xsl:attribute name="cellpadding">8</xsl:attribute>
    <xsl:attribute name="cellspacing">8</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="reverse-table"> 
    <xsl:attribute name="bgcolor">black</xsl:attribute>
    <xsl:attribute name="style">color: white;</xsl:attribute>
  </xsl:attribute-set>

  <xsl:template match="/">
    <html>
      <head>
        <title><xsl:value-of select="/list/title"/></title>
      </head>
      <body style="font-family: sans-serif;">
        <xsl:apply-templates select="*"/>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="list">
    <h1><xsl:value-of select="title"/></h1>
    <table xsl:use-attribute-sets="spacious-table" border="2">
      <xsl:for-each select="listitem">
        <tr>
          <td xsl:use-attribute-sets="reverse-table">
            <xsl:value-of select="."/>
          </td>
        </tr>
      </xsl:for-each>
    </table>
    <h1>Here's the same table with different attribute sets:</h1>
    <table border="2" xsl:use-attribute-sets="bold-table">
      <xsl:for-each select="listitem">
        <tr>
          <td>
            <xsl:value-of select="."/>
          </td>
        </tr>
      </xsl:for-each>
    </table>
  </xsl:template>

</xsl:stylesheet>
