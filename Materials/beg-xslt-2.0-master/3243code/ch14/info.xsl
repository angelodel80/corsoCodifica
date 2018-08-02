<?xml version="1.0"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="text" />

<xsl:template match="/">
  <xsl:choose>
    <xsl:when test="number(system-property('xsl:version')) > 1.0">
      <xsl:text>XSLT version </xsl:text>
      <xsl:value-of select="system-property('xsl:version')" />
      <xsl:text> processor</xsl:text>
      <xsl:text>&#xA;Processor: </xsl:text>
      <xsl:value-of select="system-property('xsl:product-name')" />
      <xsl:text>&#xA;Version:   </xsl:text>
      <xsl:value-of select="system-property('xsl:product-version')" />
      <xsl:text>&#xA;Vendor:    </xsl:text>
      <xsl:value-of select="system-property('xsl:vendor-url')" />
    </xsl:when>
    <xsl:otherwise>
      <xsl:text>XSLT version 1.0 processor</xsl:text>
      <xsl:text>&#xA;Processor: </xsl:text>
      <xsl:value-of select="system-property('xsl:vendor')" />
      <xsl:text>&#xA;Vendor:    </xsl:text>
      <xsl:value-of select="system-property('xsl:vendor-url')" />
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>