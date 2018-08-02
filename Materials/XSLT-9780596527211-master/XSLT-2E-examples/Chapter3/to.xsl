<?xml version="1.0"?>
<!-- to.xsl -->
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>
 
  <xsl:variable name="some-numbers" as="xs:integer*"
    select="1 to 5"/>

  <xsl:variable name="reversed-numbers" as="xs:integer*"
    select="reverse(1 to 5)"/>

  <xsl:template match="/">
    <xsl:value-of select="$some-numbers" separator=", "/>
    <xsl:text>&#xA;</xsl:text>
    <xsl:value-of select="$reversed-numbers" separator=", "/>
  </xsl:template>

</xsl:stylesheet>
