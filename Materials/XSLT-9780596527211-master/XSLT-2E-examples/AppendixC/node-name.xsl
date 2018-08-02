<?xml version="1.0"?>
<!-- node-name.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">

    <xsl:text>&#xA;Here's a test of the node-name() </xsl:text>
    <xsl:text>function:&#xA;</xsl:text>
    
    <xsl:apply-templates 
      select="*|comment()|processing-instruction()|text()"/>
  </xsl:template>

  <xsl:template match="*">
    <xsl:text>&#xA;</xsl:text>
    <xsl:text>  Element node: node-name(.) = '</xsl:text>
    <xsl:value-of select="node-name(.)"/>
    <xsl:if test="prefix-from-QName(node-name(.))">
      <xsl:text>'&#xA;    Prefix: '</xsl:text>
      <xsl:value-of select="prefix-from-QName(node-name(.))"/>
    </xsl:if>
    <xsl:text>'&#xA;    Local name: '</xsl:text>
    <xsl:value-of select="local-name-from-QName(node-name(.))"/>
    <xsl:if test="namespace-uri-from-QName(node-name(.))">
      <xsl:text>'&#xA;    Namespace URI: '</xsl:text>
      <xsl:value-of select="namespace-uri-from-QName(node-name(.))"/>
    </xsl:if>
    <xsl:text>'&#xA;</xsl:text>

    <xsl:if test="count(@*)">
      <xsl:for-each select="@*">
        <xsl:text>    Attribute node: node-name(.) = '</xsl:text>
        <xsl:value-of select="node-name(.)"/>
        <xsl:text>'&#xA;</xsl:text>
      </xsl:for-each>
    </xsl:if>

    <xsl:for-each select="namespace::*">
      <xsl:call-template name="namespace-node"/>
    </xsl:for-each>

    <xsl:for-each 
      select="*|comment()|processing-instruction()|text()">
      <xsl:apply-templates select="."/>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="comment()">
    <xsl:text>&#xA;</xsl:text>
    <xsl:text>  Comment node: node-name(.) = '</xsl:text>
    <xsl:value-of select="node-name(.)"/>
    <xsl:text>'&#xA;</xsl:text>
  </xsl:template>

  <xsl:template match="processing-instruction()">
    <xsl:text>&#xA;</xsl:text>
    <xsl:text>  Processing instruction node: </xsl:text>
    <xsl:text>node-name(.) = '</xsl:text>
    <xsl:value-of select="node-name(.)"/>
    <xsl:text>'&#xA;</xsl:text>
  </xsl:template>

  <xsl:template match="text()">
    <xsl:if test="string-length(normalize-space(.))">
      <xsl:text>  Text node: node-name(.) = '</xsl:text>
      <xsl:value-of select="node-name(.)"/>
      <xsl:text>'&#xA;</xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template name="namespace-node">
    <xsl:if test="string(node-name(.)) != 'xml'">
      <xsl:text>  Namespace node: node-name(.) = '</xsl:text>
      <xsl:value-of select="node-name(.)"/>
      <xsl:text>'&#xA;</xsl:text>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>