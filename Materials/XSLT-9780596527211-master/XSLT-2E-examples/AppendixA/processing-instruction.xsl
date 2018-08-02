<?xml version="1.0"?>
<!-- processing-instruction.xsl -->
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml"/>

  <xsl:template match="/">
    <xsl:processing-instruction name="xml-stylesheet">href="docbook/html/docbook.xsl" type="text/xsl"</xsl:processing-instruction>
    <xsl:copy-of select="."/>
  </xsl:template>

</xsl:stylesheet>
