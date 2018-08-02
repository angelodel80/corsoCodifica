<?xml version="1.0"?>
<!-- for-each-group_group-starting-with.xsl -->
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="xml" indent="yes"/>

  <xsl:template match="/">
    <chapter>
      <title>Grouping in XSLT</title>
      <xsl:apply-templates select="html/body"/>
    </chapter>
  </xsl:template>

  <xsl:template match="body">
    <xsl:for-each-group select="*" group-starting-with="h1">
      <sect1>
        <xsl:apply-templates select="current-group()"/>
      </sect1>
    </xsl:for-each-group>
  </xsl:template>

  <xsl:template match="h1">
    <title>
      <xsl:apply-templates/>
    </title>
  </xsl:template>

  <xsl:template match="p">
    <para>
      <xsl:apply-templates/>
    </para>
  </xsl:template>

  <xsl:template match="*">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
