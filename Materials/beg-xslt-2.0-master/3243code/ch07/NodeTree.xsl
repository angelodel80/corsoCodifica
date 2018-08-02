<?xml version="1.0"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="document-node()">
  document:
  <xsl:apply-templates />
</xsl:template>

<xsl:template match="element()">
  element: <xsl:value-of select="name()" />
  <xsl:apply-templates select="@*" />
  <xsl:apply-templates />
</xsl:template>

<xsl:template match="attribute()">
  attribute: <xsl:value-of select="name()" />:
             <xsl:value-of select="." />
</xsl:template>

<xsl:template match="text()">
  text: <xsl:value-of select="." />
</xsl:template>

<xsl:template match="processing-instruction()">
  processing instruction: <xsl:value-of select="name()" />:
                          <xsl:value-of select="." />
</xsl:template>

<xsl:template match="comment()">
  comment: <xsl:value-of select="." />
</xsl:template>

</xsl:stylesheet>