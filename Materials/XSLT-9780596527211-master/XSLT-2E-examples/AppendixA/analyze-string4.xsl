<?xml version="1.0" encoding="utf-8"?>
<!-- analyze-string4.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>Test of incorrectly-written regex&#xA;&#xA;</xsl:text>
    <xsl:call-template name="bad-regex">
      <xsl:with-param name="test-value" select="'37174'"/>
    </xsl:call-template>
    <xsl:call-template name="bad-regex">
      <xsl:with-param name="test-value" select="'95'"/>
    </xsl:call-template>
  </xsl:template>
  
  <xsl:template name="bad-regex">
    <xsl:param name="test-value" required="yes"/>
    <xsl:value-of select="$test-value"/>
    <xsl:analyze-string select="$test-value" regex="[0-9]{5}">
      <xsl:matching-substring>
        <xsl:text> matches!&#xA;</xsl:text>
      </xsl:matching-substring>
      <xsl:non-matching-substring>
        <xsl:text> doesn't match!&#xA;</xsl:text>
      </xsl:non-matching-substring>
    </xsl:analyze-string>
  </xsl:template>

</xsl:stylesheet>
