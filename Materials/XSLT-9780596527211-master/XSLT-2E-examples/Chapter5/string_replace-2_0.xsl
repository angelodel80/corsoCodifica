<?xml version="1.0"?>
<!-- string_replace-2_0.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:apply-templates select="ul/li"/>
  </xsl:template>

  <xsl:template match="li">
    <xsl:variable name="sub1" select="replace(., '&amp;', '^&amp;')"/>
    <xsl:variable name="sub2" select="replace($sub1, '\|', '^|')"/>
    <xsl:value-of select='replace($sub2, "&apos;", "&apos;&apos;")'/>
    <xsl:text>&#xA;</xsl:text>
  </xsl:template>

</xsl:stylesheet>
