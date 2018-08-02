<?xml version="1.0"?>
<!-- number9.xsl -->
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="book">
    <xsl:for-each select=".//sect2">
      <xsl:number level="any" count="chapter|sect1|sect2|sect3"
        format="w - " lang="de"/>
        <xsl:value-of select="title"/>
        <xsl:text>&#xA;</xsl:text>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
