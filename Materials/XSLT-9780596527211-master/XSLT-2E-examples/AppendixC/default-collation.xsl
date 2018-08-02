<?xml version="1.0"?>
<!-- default-collation.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;The default collation is: &#xA;  </xsl:text>
    <xsl:value-of select="default-collation()"/>
  </xsl:template>

</xsl:stylesheet>
