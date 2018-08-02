<?xml version="1.0"?>
<!-- string_replace-1_0.xsl -->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:apply-templates select="ul/li"/>
  </xsl:template>

  <xsl:template match="li">
    <xsl:variable name="single-quote">
      <xsl:text>&apos;</xsl:text>
    </xsl:variable>
    <xsl:variable name="two-quotes">
      <xsl:text>&apos;&apos;</xsl:text>
    </xsl:variable>

    <xsl:variable name="sub1">
      <xsl:call-template name="replace-substring">
        <xsl:with-param name="original" select="."/>
        <xsl:with-param name="substring" select="'&amp;'"/>
        <xsl:with-param name="replacement" select="'^&amp;'"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="sub2">
      <xsl:call-template name="replace-substring">
        <xsl:with-param name="original" select="$sub1"/>
        <xsl:with-param name="substring" select="'|'"/>
        <xsl:with-param name="replacement" select="'^|'"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:call-template name="replace-substring">
      <xsl:with-param name="original" select="$sub2"/>
      <xsl:with-param name="substring" select="$single-quote"/>
      <xsl:with-param name="replacement" select="$two-quotes"/>
    </xsl:call-template>
    <xsl:text>&#xA;</xsl:text>
  </xsl:template>

  <xsl:template name="replace-substring">
    <xsl:param name="original" />
    <xsl:param name="substring" />
    <xsl:param name="replacement" />
    <xsl:choose>
      <xsl:when test="contains($original, $substring)">
        <xsl:value-of 
          select="substring-before($original, $substring)" />
        <xsl:value-of select="$replacement" />
        <xsl:call-template name="replace-substring">
          <xsl:with-param name="original" 
            select="substring-after($original, $substring)" />
          <xsl:with-param 
            name="substring" select="$substring" />
          <xsl:with-param 
            name="replacement" select="$replacement" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$original" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>          
  
</xsl:stylesheet>
