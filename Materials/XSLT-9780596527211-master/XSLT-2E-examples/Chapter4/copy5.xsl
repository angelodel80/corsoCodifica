<?xml version="1.0"?>
<!-- copy5.xsl -->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:auth="http://www.authors.com/">

  <xsl:template match="sonnet">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates select="auth:author|title"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="*">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
