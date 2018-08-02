<?xml version="1.0"?>
<!-- variable.xsl -->
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:variable name="favoriteNumber" select="23"/>
  <xsl:variable name="favoriteColor" select="'blue'"/>
  <xsl:variable name="complicatedVariable">
    <xsl:choose>
      <xsl:when test="count(//listitem) &gt; 10">
        <xsl:text>really long list</xsl:text>
      </xsl:when>
      <xsl:when test="count(//listitem) &gt; 5">
        <xsl:text>moderately long list</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>fairly short list</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:template match="/">
    <xsl:text>Hello!  Your favorite number is </xsl:text>
    <xsl:value-of select="$favoriteNumber"/>
    <xsl:text>.&#xA;Your favorite color is </xsl:text>
    <xsl:value-of select="$favoriteColor"/>
    <xsl:text>.&#xA;&#xA;Here is a </xsl:text>
    <xsl:value-of select="$complicatedVariable"/>
    <xsl:text>:&#xA;</xsl:text>
    <xsl:variable name="listitems" select="list/listitem"/>
    <xsl:call-template name="processListitems">
      <xsl:with-param name="items" select="$listitems"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="processListitems">
    <xsl:param name="items"/>
    <xsl:variable name="favoriteColor">
      <xsl:text>chartreuse</xsl:text>
    </xsl:variable>
    
    <xsl:text>    (Your favorite color is now </xsl:text>
    <xsl:value-of select="$favoriteColor"/>
    <xsl:text>.)&#xA;</xsl:text>
    <xsl:for-each select="$items">
      <xsl:value-of select="position()"/>
      <xsl:text>.  </xsl:text>
      <xsl:value-of select="."/>
      <xsl:text>&#xA;</xsl:text>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
