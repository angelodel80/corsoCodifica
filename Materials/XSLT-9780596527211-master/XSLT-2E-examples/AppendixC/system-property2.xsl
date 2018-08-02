<?xml version="1.0"?>
<!-- system-property2.xsl -->
<xsl:stylesheet version="2.0"
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
    <xsl:text>"&#xA;&#xA;XSLT 2.0 properties:&#xA;&#xA;</xsl:text>
    <xsl:text>  xsl:product-name = "</xsl:text>
    <xsl:value-of select="system-property('xsl:product-name')"/>
    <xsl:text>"&#xA;</xsl:text>
    <xsl:text>  xsl:product-version = "</xsl:text>
    <xsl:value-of select="system-property('xsl:product-version')"/>
    <xsl:text>"&#xA;</xsl:text>
    <xsl:text>  xsl:is-schema-aware = "</xsl:text>
    <xsl:value-of select="system-property('xsl:is-schema-aware')"/>
    <xsl:text>"&#xA;</xsl:text>
    <xsl:text>  xsl:supports-serialization = "</xsl:text>
    <xsl:value-of 
      select="system-property('xsl:supports-serialization')"/>
    <xsl:text>"&#xA;</xsl:text>
    <xsl:text>  xsl:supports-backwards-compatibility = "</xsl:text>
    <xsl:value-of 
      select="system-property('xsl:supports-backwards-compatibility')"/>
    <xsl:text>"</xsl:text>
  </xsl:template>

</xsl:stylesheet>
