<?xml version="1.0"?>
<!-- lang.xsl -->
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;A test of the lang() function:&#xA;&#xA;</xsl:text>
    <xsl:for-each select="list/listitem">
      <xsl:choose>
        <xsl:when test="lang('EN')">
          <xsl:text>  Here's an English-language album: </xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>  -------> Here's some World music: </xsl:text>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:value-of select="."/>
      <xsl:text>&#xA;</xsl:text>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
