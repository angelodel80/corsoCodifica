<?xml version="1.0" encoding="utf-8"?>
<!-- analyze-string3.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:analyze-string select="'&#x212A;'" 
      regex="k" flags="i">
      <xsl:matching-substring>
        <xsl:text>It matches!</xsl:text>
      </xsl:matching-substring>
      <xsl:non-matching-substring>
        <xsl:text>It doesn't match!</xsl:text>
      </xsl:non-matching-substring>
    </xsl:analyze-string>
  </xsl:template>

</xsl:stylesheet>
