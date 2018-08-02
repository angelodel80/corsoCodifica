<?xml version="1.0"?>
<!-- for-each-group2.xsl -->
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html" include-content-type="no"/>

  <xsl:template match="/">
    <html>
      <head>
        <title>Grouping with group-adjacent</title>
      </head>
      <body>
        <xsl:for-each-group select="html/body/*"
          group-adjacent="boolean(self::p)">
          <xsl:choose>
            <xsl:when test="current-grouping-key()">
              <ul>
                <xsl:for-each select="current-group()">
                  <li><xsl:apply-templates select="*|text()"/></li>
                </xsl:for-each>
              </ul>
            </xsl:when>
            <xsl:otherwise>
              <xsl:apply-templates select="current-group()" />
            </xsl:otherwise>
          </xsl:choose>
        </xsl:for-each-group>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="*">
    <xsl:copy>
      <xsl:for-each select="@*">
        <xsl:copy/>          
      </xsl:for-each>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
