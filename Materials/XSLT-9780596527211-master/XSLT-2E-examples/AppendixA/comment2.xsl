<?xml version="1.0"?>
<!-- comment2.xsl -->
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html"/>

  <xsl:template match="/">
    <html>
      <head>
        <title>XSLT and CSS Demo</title>
        <style>
          <xsl:comment> 
            p.big   {font-size: 125%; font-weight: bold;} 
            p.odd   {color: purple; font-weight: bold;}
            p.even  {color: blue; font-style: italic; font-weight: bold;}
          </xsl:comment>
        </style>
      </head>
      <body style="font-family: sans-serif;">
        <xsl:apply-templates select="list/title"/>
        <xsl:comment 
          select="concat('The second album is ', list/listitem[2])"/>
        <xsl:apply-templates select="list/listitem"/>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="title">
    <p class="big"><xsl:value-of select="."/></p>
  </xsl:template>

  <xsl:template match="listitem">
    <xsl:choose>
      <xsl:when test="position() mod 2">
        <p class="odd"><xsl:value-of select="."/></p>
      </xsl:when>
      <xsl:otherwise>
        <p class="even"><xsl:value-of select="."/></p>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
</xsl:stylesheet>
