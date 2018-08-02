<?xml version="1.0"?>
<!-- copy-of-whitespace.xsl -->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:preserve-space elements="manufacturer"/>
  <xsl:strip-space elements="cars"/>

  <xsl:template match="/">
    <xsl:copy-of select="."/>
  </xsl:template>

</xsl:stylesheet>
