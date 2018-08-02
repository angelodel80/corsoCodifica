<?xml version="1.0"?>
<!-- for-each-group_group-ending-with.xsl -->
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html" include-content-type="no"/>

  <xsl:template match="/">
    <html>
      <head>
        <title>Car Makes and Models</title>
      </head>
      <body style="font-family: sans-serif;">
        <h1>Car Makes and Models</h1>
        <p>Here are the car makes and models in 
        our input document.</p>
        <table border="1" cellpadding="5">
          <xsl:apply-templates select="cars"/>
        </table>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="cars">
    <xsl:for-each-group select="make|model" 
      group-ending-with="*[position() mod 3 = 0]">
      <tr>
        <xsl:apply-templates select="current-group()"/>
        <xsl:if test="count(current-group()) lt 3">
          <td style="background: #CCCCCC;"
            colspan="{3 - count(current-group())}">
          </td>
        </xsl:if>
      </tr>
    </xsl:for-each-group>
  </xsl:template>

  <xsl:template match="make">
    <td style="font-weight: bold;">
      <xsl:apply-templates/>
    </td>
  </xsl:template>

  <xsl:template match="model">
    <td style="font-style: italic; font-weight: bold;">
      <xsl:apply-templates/>
    </td>
  </xsl:template>
  
</xsl:stylesheet>
