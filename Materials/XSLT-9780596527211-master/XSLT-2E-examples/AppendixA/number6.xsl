<?xml version="1.0"?>
<!-- number6.xsl -->
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="book">
    <xsl:for-each select="chapter|.//sect1|.//sect2|.//sect3">
      <xsl:variable name="value1">
        <xsl:number level="any" count="chapter|sect1|sect2|sect3"/>
      </xsl:variable>
      <xsl:number value="$value1 + 999"
        grouping-separator="," grouping-size="3"/>
      <xsl:text>. </xsl:text>
      <xsl:value-of select="title"/>
      <xsl:text>&#xA;</xsl:text>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
