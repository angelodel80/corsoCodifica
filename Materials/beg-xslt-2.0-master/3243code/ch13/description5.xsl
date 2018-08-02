<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:tv="http://www.example.com/TVGuide"
                exclude-result-prefixes="xs tv"
                xmlns="http://www.w3.org/1999/xhtml">

<xsl:template match="tv:Description//tv:Link">
  <xsl:variable name="content" as="item()+">
    <xsl:apply-templates />
  </xsl:variable>
  <xsl:call-template name="link">
    <xsl:with-param name="href" as="xs:anyURI" select="@href" />
    <xsl:with-param name="content" select="$content" />
  </xsl:call-template>
</xsl:template>

<xsl:template match="schema-element(tv:_Inline)">
  <span class="{lower-case(local-name(.))}"><xsl:apply-templates /></span>
</xsl:template>
  
</xsl:stylesheet>