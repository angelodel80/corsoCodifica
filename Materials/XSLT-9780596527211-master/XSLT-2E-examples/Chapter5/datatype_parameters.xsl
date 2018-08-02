<?xml version="1.0" encoding="utf-8"?>
<!-- datatype_parameters.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:call-template name="date-formatter">
      <xsl:with-param name="date" select="current-date()"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="date-formatter">
    <xsl:param name="date" as="xs:date" required="yes"/>
    <xsl:value-of select="format-date($date, '[M01]/[D01]/[Y0001]')"/>
  </xsl:template>

</xsl:stylesheet>
