<?xml version="1.0"?>
<!-- namespace-uri.xsl -->
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;A test of the namespace-uri() function:&#xA;&#xA;</xsl:text>

    <xsl:for-each select="//*">
      <xsl:text>  Namespace URI for &lt;</xsl:text>
      <xsl:value-of select="node-name(.)"/>
      <xsl:text>&gt;: </xsl:text>
      <xsl:value-of select="namespace-uri()"/>
      <xsl:text>&#xA;</xsl:text>
      <xsl:for-each select="@*">
        <xsl:text>    Namespace URI for attribute "</xsl:text>
        <xsl:value-of select="node-name(.)"/>
        <xsl:text>": </xsl:text>
        <xsl:value-of select="namespace-uri()"/>
        <xsl:text>&#xA;</xsl:text>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
