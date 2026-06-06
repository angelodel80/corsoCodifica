<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0"
                version="2.0">
  <!-- Called from teisupplied.xsl -->
  
  <xsl:template name="supplied-parallel">
    <xsl:call-template name="unicode-underline"/>
  </xsl:template>
  
  <xsl:template name="supplied-previouseditor">
    <xsl:call-template name="unicode-underline"/>
  </xsl:template>
  
  <xsl:template name="unicode-underline">
    <xsl:analyze-string select="." regex="(\p{{L}}|\s)">
      <xsl:matching-substring>
        <xsl:for-each select="regex-group(1)">
          <xsl:value-of select="concat(.,'&#818;')"/>
        </xsl:for-each>
      </xsl:matching-substring>
    </xsl:analyze-string>
  </xsl:template>

    <xsl:template name="supplied-subaudible">
        <xsl:text>(scil. </xsl:text>
        <xsl:apply-templates/>
        <xsl:call-template name="cert-low"/>
        <xsl:text>)</xsl:text>
    </xsl:template>

</xsl:stylesheet>
