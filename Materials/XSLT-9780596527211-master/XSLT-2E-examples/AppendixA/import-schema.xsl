<?xml version="1.0"?>
<!-- import-schema.xsl -->
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:po="http://www.oreilly.com/xslt">

  <xsl:import-schema namespace="http://www.oreilly.com/xslt"
    schema-location="po.xsd" />  

  <xsl:output method="text"/>

  <xsl:template match="schema-element(po:purchase-order)">
    <xsl:text>&#xA;This is a test of the &lt;xsl:import-</xsl:text>
    <xsl:text>schema&gt; element.&#xA;&#xA;</xsl:text>
    <xsl:text>Here are all the items in this purchase </xsl:text>
    <xsl:text>order:&#xA;</xsl:text>
    <xsl:for-each select="po:items/po:item">
      <xsl:text>  * </xsl:text>
      <xsl:value-of select="po:partname"/>
      <xsl:text>&#xA;</xsl:text>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="*">
    <xsl:message terminate="yes">
      <xsl:text>This is not a valid purchase order!</xsl:text>
    </xsl:message>
  </xsl:template>

</xsl:stylesheet>
