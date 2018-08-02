<?xml version="1.0"?>
<!-- namespace-alias.xsl -->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xslout="[anything but the XSL namespace]">

  <xsl:output method="xml" indent="yes"/>
 
  <xsl:namespace-alias stylesheet-prefix="xslout"
    result-prefix="xsl"/>

  <xsl:template match="/">
    <xslout:stylesheet version="1.0">
      <xslout:output method="xml"/>
      <xslout:template match="/">
        <xslout:copy-of select="."/>
      </xslout:template>
    </xslout:stylesheet>
  </xsl:template>

</xsl:stylesheet>
