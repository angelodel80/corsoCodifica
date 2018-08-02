<?xml version="1.0"?>
<!-- call-template.xsl -->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html"/>

  <xsl:template match="report">
    <html>
      <head>
        <xsl:call-template name="report-title">
          <xsl:with-param name="in-heading" select="true()"/>
          <xsl:with-param name="title" select="title"/>
        </xsl:call-template>
      </head>
      <body>
        <xsl:call-template name="insert-header"/>
        <xsl:call-template name="report-title">
          <xsl:with-param name="in-heading" select="false()"/>
          <xsl:with-param name="title" select="title"/>
        </xsl:call-template>
        <table cellpadding="5">
          <xsl:call-template name="table-heading"/>
          <xsl:apply-templates select="brand"/>
        </table>
        <xsl:call-template name="insert-footer"/>
      </body>
    </html>
  </xsl:template>

  <xsl:template name="insert-header">
    <p style="font-size: 75%; font-style: italic;">
      This confidential report is the property of DougCo, Inc.
    </p>
    <hr/>
  </xsl:template>

  <xsl:template name="report-title">
    <xsl:param name="in-heading"/>
    <xsl:param name="title"/>
    <xsl:choose>
      <xsl:when test="$in-heading">
        <title><xsl:value-of select="$title"/></title>
      </xsl:when>
      <xsl:otherwise>
        <h1><xsl:value-of select="$title"/></h1>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="table-heading">
    <tr>
      <td style="background: black; color: white; font-weight: bold;">
        Brand</td>
      <td style="background: black; color: white; font-weight: bold;">
        Sales</td>
    </tr>
  </xsl:template>

  <xsl:template name="insert-footer">
    <hr/>
    <p style="font-size: 75%; font-style: italic;">
      &#xA9; Copyright 2008, DougCo, Inc.
    </p>
  </xsl:template>

  <xsl:template match="brand">
    <tr>
      <td><xsl:value-of select="name"/></td>
      <td><xsl:value-of select="units"/></td>
    </tr>
  </xsl:template>

</xsl:stylesheet>
