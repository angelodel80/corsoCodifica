<?xml version="1.0"?>
<!-- generate-id.xsl -->
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;A test of the generate-id() </xsl:text>
    <xsl:text>function:&#xA;&#xA;</xsl:text>

    <xsl:text>  We'll generate IDs for every node </xsl:text>
    <xsl:text>in the XML source:&#xA;&#xA;</xsl:text>
    <xsl:for-each select="//*">
      <xsl:text>    Node name: &lt;</xsl:text>
      <xsl:value-of select="name()"/>
      <xsl:text>&gt; - generated id: </xsl:text>
      <xsl:value-of select="generate-id()"/>
      <xsl:text>&#xA;</xsl:text>
    </xsl:for-each>

    <xsl:text>&#xA;  Now we'll try it again...&#xA;&#xA;</xsl:text>
    <xsl:for-each select="//*">
      <xsl:text>    Node name: &lt;</xsl:text>
      <xsl:value-of select="name()"/>
      <xsl:text>&gt; - generated id: </xsl:text>
      <xsl:value-of select="generate-id()"/>
      <xsl:text>&#xA;</xsl:text>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
