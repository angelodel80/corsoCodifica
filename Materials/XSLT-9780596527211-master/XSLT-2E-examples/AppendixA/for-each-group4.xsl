<?xml version="1.0"?>
<!-- for-each-group4.xsl -->
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  exclude-result-prefixes="xs">

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
        <xsl:choose>
          <xsl:when test="count(current-group()) = 3">
            <xsl:for-each select="current-group()">
              <xsl:apply-templates select="."/>
            </xsl:for-each>
          </xsl:when>
          <xsl:when test="count(current-group()) = 2">
            <xsl:apply-templates select="current-group()[1]"/>
            <xsl:apply-templates select="current-group()[2]"/>
            <td bgcolor="#CCCCCC">
              &#x20;&#x20;
            </td>
          </xsl:when>
          <xsl:otherwise>
            <xsl:apply-templates select="current-group()[1]"/>
            <td bgcolor="#CCCCCC" colspan="2">
              &#x20;&#x20;
            </td>
          </xsl:otherwise>
        </xsl:choose>
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
