<?xml version="1.0"?>
<!-- unordered.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:template match="/">

    <xsl:text>&#xA;Here is a test of the unordered() </xsl:text>
    <xsl:text>function:&#xA;</xsl:text>

    <xsl:for-each select="//first-name">
      <xsl:text>&#xA;  Element &lt;first-name&gt;</xsl:text>
      <xsl:value-of select="."/>
      <xsl:text>&lt;/first-name&gt;:&#xA;    </xsl:text>
      <xsl:text>&#xA;    Ancestors:&#xA;      </xsl:text>
      <xsl:value-of select="ancestor::*/name()" separator=", "/>
      <xsl:text>&#xA;&#xA;    Unordered ancestors:&#xA;      </xsl:text>
      <xsl:value-of select="unordered(ancestor::*/name())" 
        separator=", "/>
    </xsl:for-each>

  </xsl:template>

</xsl:stylesheet>
