<?xml version="1.0"?>
<!-- stylesheet2.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xpath-default-namespace="http://www.oreilly.com">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>Here are this month's sales figures:&#xA;&#xA;</xsl:text>
    <xsl:for-each select="/report/brand">
      <xsl:value-of select="name"/>
      <xsl:text>&#x9;</xsl:text>
      <xsl:value-of select="units"/>
      <xsl:text>&#xA;</xsl:text>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
