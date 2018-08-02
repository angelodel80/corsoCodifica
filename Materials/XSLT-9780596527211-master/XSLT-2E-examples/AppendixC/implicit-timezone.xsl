<?xml version="1.0"?>
<!-- implicit-timezone.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Using the implicit-timezone() function:&#xA;&#xA;</xsl:text>
    <xsl:text>  The implicit timezone for the current context is: </xsl:text>
    <xsl:value-of select="implicit-timezone()"/>
  </xsl:template>

</xsl:stylesheet>
