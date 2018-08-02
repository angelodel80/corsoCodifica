<?xml version="1.0"?>
<!-- number3.xsl -->
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="book">
    <xsl:for-each select="chapter|.//sect1|.//sect2|.//sect3">
      <xsl:number level="single" count="chapter|sect1|sect2|sect3"
        format="1.1.1.1. "/>
        <xsl:value-of select="title"/>
        <xsl:text>&#xA;</xsl:text>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
