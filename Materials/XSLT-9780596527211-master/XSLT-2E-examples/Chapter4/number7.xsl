<?xml version="1.0" encoding="utf-8"?>
<!-- number7.xsl -->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>Automobile manufacturers and their cars&#xA;</xsl:text>
    <xsl:for-each select="cars/manufacturer">
      <xsl:value-of select="@name"/>
      <xsl:text>&#xA;</xsl:text>
      <xsl:for-each select="car">
        <xsl:sort select="."/>
        <xsl:text>  </xsl:text>
        <xsl:if test="(position() mod 2) = 0">
          <xsl:number count="manufacturer" level="multiple"
            format="1."/>
          <xsl:value-of select="position()"/>
          <xsl:text>. </xsl:text>
        </xsl:if>
        <xsl:value-of select="."/>
        <xsl:text>&#xA;</xsl:text>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
