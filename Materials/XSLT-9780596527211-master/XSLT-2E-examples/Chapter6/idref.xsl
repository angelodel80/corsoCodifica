<?xml version="1.0"?>
<!-- idref.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Here is a test of the idref() </xsl:text>
    <xsl:text>function:&#xA;</xsl:text>

    <xsl:for-each select="/parts-list/part">
      <xsl:text>&#xA;  </xsl:text>
      <xsl:value-of select="name"/>
      <xsl:text> (part #</xsl:text>
      <xsl:value-of select="@part-id"/>
      <xsl:text>) is used in these products:&#xA;    </xsl:text>
      <xsl:value-of select="idref(@part-id)/../../name" 
        separator="&#xA;    "/> 
      <xsl:text>&#xA;</xsl:text>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
