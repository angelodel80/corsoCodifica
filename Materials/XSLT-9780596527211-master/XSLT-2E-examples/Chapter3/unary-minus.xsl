<?xml version="1.0"?>
<!-- unary-minus.xsl -->
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:variable name="x" as="xs:integer" select="xs:integer(-10)"/>

    <xsl:text>An example of the unary minus </xsl:text>
    <xsl:text>operator:&#xA;    </xsl:text>
    <xsl:value-of select="('$x =', $x, '&#xA;   -$x = ', -$x)"/>
  </xsl:template>

</xsl:stylesheet>
