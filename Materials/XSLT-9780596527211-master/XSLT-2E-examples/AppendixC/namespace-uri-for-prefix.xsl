<?xml version="1.0" encoding="UTF-8"?>
<!-- namespace-uri-for-prefix.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>
  
  <xsl:template match="/">
    <xsl:text>&#xA;Tests of the namespace-uri-for-prefix() </xsl:text>
    <xsl:text>function:&#xA;</xsl:text>

    <xsl:text>&#xA; namespace-uri-for-prefix</xsl:text>
    <xsl:text>('auth', //last-name) = "</xsl:text>
    <xsl:value-of
      select="namespace-uri-for-prefix('auth', //last-name)"/>
    <xsl:text>"</xsl:text>

    <xsl:text>&#xA; namespace-uri-for-prefix</xsl:text>
    <xsl:text>('auth', //*:author) = "</xsl:text>
    <xsl:value-of
      select="namespace-uri-for-prefix('auth', //*:author)"/>
    <xsl:text>"</xsl:text>

    <xsl:text>&#xA; namespace-uri-for-prefix</xsl:text>
    <xsl:text>('auth', /sonnet) = "</xsl:text>
    <xsl:value-of
      select="namespace-uri-for-prefix('auth', /sonnet)"/>
    <xsl:text>"</xsl:text>
  </xsl:template>

</xsl:stylesheet>