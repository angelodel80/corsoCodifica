<?xml version="1.0"?>
<!-- contains1.xsl -->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;A test of the contains() function:&#xA;&#xA;</xsl:text>
    <xsl:text>  Replacing 'World' with 'Mundo' in </xsl:text>
    <xsl:text>'Hello World!': &#xA;    </xsl:text>
    <xsl:variable name="test">
      <xsl:call-template name="replace-substring">
        <xsl:with-param name="original">Hello World!</xsl:with-param>
        <xsl:with-param name="substring">World</xsl:with-param>
        <xsl:with-param name="replacement">Mundo</xsl:with-param>
      </xsl:call-template>
    </xsl:variable>
    <xsl:value-of select="$test"/>
  </xsl:template>

  <xsl:template name="replace-substring">
    <xsl:param name="original" />
    <xsl:param name="substring" />
    <xsl:param name="replacement" />
    <xsl:choose>
      <xsl:when test="contains($original, $substring)">
        <xsl:value-of select="substring-before($original, $substring)" />
        <xsl:value-of select="$replacement" />
        <xsl:call-template name="replace-substring">
          <xsl:with-param name="original" 
            select="substring-after($original, $substring)" />
          <xsl:with-param name="substring" select="$substring" />
          <xsl:with-param name="replacement" select="$replacement" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$original" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>          
  
</xsl:stylesheet>
