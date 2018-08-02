<?xml version="1.0"?>
<!-- namespace-alias-3.xsl -->
<xsl:stylesheet version="1.0"
  xmlns="[anything but the XSL namespace]"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="xml" indent="yes"/>
 
  <xsl:namespace-alias stylesheet-prefix="#default"
    result-prefix="xsl"/>

  <xsl:template match="/">
    <stylesheet version="1.0">
      <output method="xml"/>
      <template match="/">
        <copy-of select="."/>
      </template>
    </stylesheet>
  </xsl:template>

</xsl:stylesheet>
