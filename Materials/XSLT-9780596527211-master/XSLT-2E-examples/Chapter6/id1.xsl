<?xml version="1.0"?>
<!-- id1.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Here is a test of the id() </xsl:text>
    <xsl:text>function:&#xA;</xsl:text>

    <xsl:for-each select="/parts-list/component">
      <xsl:text>&#xA;  </xsl:text>
      <xsl:value-of select="name"/>
      <xsl:text> (component #</xsl:text>
      <xsl:value-of select="@component-id"/>
      <xsl:text>) uses these parts:&#xA;    </xsl:text>
      <xsl:for-each select="id(partref/@refid)">
        <xsl:value-of select="name"/>
        <xsl:text>&#xA;    </xsl:text>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
