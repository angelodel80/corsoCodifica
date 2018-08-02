<?xml version="1.0"?>
<!-- for-each-group_group-adjacent2.xsl -->
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html" include-content-type="no"/>

  <xsl:template match="/">
    <html>
      <head>
        <title>Grouping with group-adjacent</title>
      </head>
      <body style="font-family: sans-serif;">
        <h1>Grouping with group-adjacent</h1>
        <xsl:for-each-group select="html/body/*"
          group-adjacent="if (self::p[@class='item']) then 1 
                          else if (self::p[@class='note']) then 2 
                          else 3">
          <xsl:choose>

            <!-- group for <p class="item"> -->
            <xsl:when test="current-grouping-key() = 1">
              <ul>
                <xsl:for-each select="current-group()">
                  <li>
                    <xsl:copy-of select="@*[not(name()='class')]"/>
                    <xsl:apply-templates select="*|text()"/>
                  </li>
                </xsl:for-each>
              </ul>
            </xsl:when>

            <!-- group for <p class="note"> -->
            <xsl:when test="current-grouping-key() = 2">
              <xsl:variable name="starting-point">
                <xsl:number count="p[@class='note']" level="any" format="1"/>
              </xsl:variable>
              <table border="0" cellpadding="5" width="40%">
                <tr>
                  <td width="10%">
                    <p><xsl:text>&#x20;</xsl:text></p>
                  </td>
                  <td style="background: #CCCCCC;">
                    <p style="font-weight: bold;">
                      <xsl:value-of 
                        select="if (count(current-group()) gt 1)
                                then 'Notes' 
                                else 'Note'"/>
                    </p>
                    <ol start="{$starting-point}">
                      <xsl:for-each select="current-group()">
                        <li>
                          <xsl:copy-of select="@*[not(name()='class')]"/>
                          <xsl:apply-templates select="*|text()"/>
                        </li>
                      </xsl:for-each>
                    </ol> 
                  </td>
                </tr>
              </table> 
            </xsl:when>

            <!-- group for everything else -->
            <xsl:otherwise>
              <xsl:for-each select="current-group()">
                <xsl:apply-templates select="."/>
              </xsl:for-each>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:for-each-group>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="*">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
