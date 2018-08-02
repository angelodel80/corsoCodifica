<?xml version="1.0"?>
<!-- doc.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;A test of the doc() function:</xsl:text>

    <xsl:text>&#xA;&#xA;  Here are all the purchase orders </xsl:text>
    <xsl:text>listed in polist.xml:</xsl:text>
    <xsl:for-each select="doc('polist.xml')/collection/doc">
      <xsl:text>&#xA;    </xsl:text>
      <xsl:value-of select="@href"/>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
