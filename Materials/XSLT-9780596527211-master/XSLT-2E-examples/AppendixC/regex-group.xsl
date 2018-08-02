<?xml version="1.0" encoding="utf-8"?>
<!-- regex-group.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>Formatted phone numbers:&#xA;</xsl:text>
    <xsl:for-each select="phonelist/phonenumber">
      <xsl:analyze-string select="." 
        regex="([0-9]{{3}})-([0-9]{{3}})-([0-9]{{4}})">
        <xsl:matching-substring>
          <xsl:text>&#xA;  The data </xsl:text>
          <xsl:value-of select="regex-group(0)"/>
          <xsl:text> matches.  </xsl:text>
          <xsl:text>&#xA;    The formatted phone number is: +1 (</xsl:text>
          <xsl:value-of select="regex-group(1)"/>
          <xsl:text>) </xsl:text>
          <xsl:value-of select="regex-group(2)"/>
          <xsl:text>-</xsl:text>
          <xsl:value-of select="regex-group(3)"/>
        </xsl:matching-substring>
      </xsl:analyze-string>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
