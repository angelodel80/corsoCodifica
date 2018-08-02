<?xml version="1.0"?>
<!-- system-property1.xsl -->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;A test of the system-property() function:</xsl:text>
    <xsl:text>&#xA;&#xA;  xsl:version = "</xsl:text>
    <xsl:value-of select="system-property('xsl:version')"/>
    <xsl:text>"&#xA;</xsl:text>
    <xsl:text>  xsl:vendor = "</xsl:text>
    <xsl:value-of select="system-property('xsl:vendor')"/>
    <xsl:text>"&#xA;</xsl:text>
    <xsl:text>  xsl:vendor-url = "</xsl:text>
    <xsl:value-of select="system-property('xsl:vendor-url')"/>
    <xsl:text>"</xsl:text>
  </xsl:template>

</xsl:stylesheet>
