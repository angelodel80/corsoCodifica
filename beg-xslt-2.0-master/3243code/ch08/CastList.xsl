<?xml version="1.0"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema">

<xsl:template match="ul">
  <CastList><xsl:apply-templates /></CastList>
</xsl:template>

<xsl:template match="li">
  <CastMember><xsl:apply-templates /></CastMember>
</xsl:template>

<xsl:template match="span">
  <xsl:variable name="name" as="xs:string" 
                select="concat(upper-case(substring(@class, 1, 1)),
                               substring(@class, 2))" />
  <xsl:element name="{$name}">
    <Name><xsl:value-of select="." /></Name>
  </xsl:element>
</xsl:template>

</xsl:stylesheet>