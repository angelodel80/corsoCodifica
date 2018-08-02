<?xml version="1.0"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema">

<xsl:strip-space elements="*" />

<xsl:template match="document-node()">
  document:
  <xsl:apply-templates />
</xsl:template>

<xsl:template match="element()">
  <xsl:variable name="name" select="node-name()" as="xs:QName" />
  element: {<xsl:value-of select="namespace-uri-from-QName($name)" />}
            <xsl:value-of select="local-name-from-QName($name)" />
  <xsl:apply-templates select="@*" />
  <xsl:apply-templates />
</xsl:template>

<xsl:template match="attribute()">
  <xsl:variable name="name" select="node-name()" as="xs:QName" />
  attribute: {<xsl:value-of select="namespace-uri-from-QName($name)" />}
              <xsl:value-of select="local-name-from-QName($name)" />:
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