<?xml version="1.0"?>
<!-- system-property3.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Getting Java system properties with </xsl:text>
    <xsl:text>system-property():</xsl:text>
    <xsl:text>&#xA;&#xA;  java.version = "</xsl:text>
    <xsl:value-of select="system-property('java.version')"/>
    <xsl:text>"&#xA;  path.separator = "</xsl:text>
    <xsl:value-of select="system-property('path.separator')"/>
    <xsl:text>"&#xA;  file.separator = "</xsl:text>
    <xsl:value-of select="system-property('file.separator')"/>
    <xsl:text>"&#xA;  user.name = "</xsl:text>
    <xsl:value-of select="system-property('user.name')"/>
    <xsl:text>"&#xA;  user.country = "</xsl:text>
    <xsl:value-of select="system-property('user.country')"/>
    <xsl:text>"</xsl:text>
  </xsl:template>

</xsl:stylesheet>
