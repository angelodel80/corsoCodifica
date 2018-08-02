<?xml version="1.0"?>
<!-- document.xsl -->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.oreilly.com/xslt"
  xmlns:po="http://www.oreilly.com/xslt">

  <xsl:output method="xml" indent="yes"/>

  <xsl:import-schema namespace="http://www.oreilly.com/xslt"
    schema-location="po.xsd" />  
  
  <xsl:template match="/">
    <xsl:document validation="lax">
      <xsl:element name="name">
        <xsl:element name="title">
          <xsl:text>Mr.</xsl:text>
        </xsl:element>
        <xsl:element name="first-name">
          <xsl:text>Kent Lyle</xsl:text>
        </xsl:element>
        <xsl:element name="last-name">
          <xsl:text>Birdley</xsl:text>
        </xsl:element>
      </xsl:element>
    </xsl:document>
  </xsl:template>

</xsl:stylesheet>
