<?xml version="1.0"?>
<!-- error1.xsl -->
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Test #1 of the error() function:</xsl:text>

    <xsl:value-of select="error()"/>
  </xsl:template>

</xsl:stylesheet>
