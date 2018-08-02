<?xml version="1.0" encoding="utf-8"?>
<!-- analyze-string2.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:for-each select="phonelist/phonenumber">
      <xsl:analyze-string select="." 
        regex="([0-9]{{3}})(-|\.)([0-9]{{3}})(-|\.)([0-9]{{4}})">
        <xsl:matching-substring>
          <xsl:text>&#xA;+1 (</xsl:text>
          <xsl:value-of select="regex-group(1)"/>
          <xsl:text>) </xsl:text>
          <xsl:value-of select="regex-group(3)"/>
          <xsl:text>-</xsl:text>
          <xsl:value-of select="regex-group(5)"/>
        </xsl:matching-substring>
        <xsl:non-matching-substring>
          <xsl:text>&#xA;   Unrecognized phone number: </xsl:text>
          <xsl:value-of select="."/>
        </xsl:non-matching-substring>
      </xsl:analyze-string>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
