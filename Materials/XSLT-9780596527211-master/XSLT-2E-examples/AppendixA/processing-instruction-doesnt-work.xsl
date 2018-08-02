<?xml version="1.0"?>
<!-- processing-instruction-doesnt-work.xsl -->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="xml"/>

  <xsl:template match="/">
    <xsl:processing-instruction name="xml-stylesheet">

      <!-- This doesn't work!  You can't put <xsl:attribute>
           elements inside a <xsl:processing-instruction> element. -->

      <xsl:attribute name="href">
        <xsl:text>docbook/html/docbook.xsl</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="type">
        <xsl:text>text/xsl</xsl:text>
      </xsl:attribute>
    </xsl:processing-instruction>
    <xsl:copy-of select="."/>
  </xsl:template>

</xsl:stylesheet>
