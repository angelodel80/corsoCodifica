<?xml version="1.0"?>
<!-- perform-sort4.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:variable name="vendorsInOrder" as="xs:string*">
    <xsl:perform-sort select="/report/brand/name">
      <xsl:sort select="."/>
    </xsl:perform-sort>
  </xsl:variable>

  <xsl:template match="/">
    <xsl:text>We sell these brands of chocolate:&#xA;&#xA;</xsl:text>
    <xsl:value-of select="$vendorsInOrder" separator="&#xA;"/>
  </xsl:template>

</xsl:stylesheet>