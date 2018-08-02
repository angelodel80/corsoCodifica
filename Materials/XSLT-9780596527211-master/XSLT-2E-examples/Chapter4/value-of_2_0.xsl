<?xml version="1.0" encoding="utf-8"?>
<!-- value-of_2_0.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:value-of select="cars/manufacturer/@name" separator=", "/>
  </xsl:template>

</xsl:stylesheet>
