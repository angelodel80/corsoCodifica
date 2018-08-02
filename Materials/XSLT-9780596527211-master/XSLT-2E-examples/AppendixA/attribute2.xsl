<?xml version="1.0" encoding="utf-8"?>
<!-- attribute2.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="xml" omit-xml-declaration="yes"/>

  <xsl:template match="/">
    <sampledoc>
      <xsl:attribute name="example" select="1 to 7" separator=", "/>
    </sampledoc>
  </xsl:template>

</xsl:stylesheet>
