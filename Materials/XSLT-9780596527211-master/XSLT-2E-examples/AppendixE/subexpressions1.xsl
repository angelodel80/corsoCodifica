<?xml version="1.0" encoding="utf-8"?>
<!-- subexpressions1.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:analyze-string select="'Call me at 919-555-1212, please.'" 
      regex="([0-9]{{3}})-(\p{{Nd}}{{3}})-([0-9]{{4}})">
      <xsl:matching-substring>
        <xsl:text>The matching substring is '</xsl:text>

        <!-- <xsl:value-of select="."/> does the same thing here -->
        <xsl:value-of select="regex-group(0)"/>
        <xsl:text>'&#xA;</xsl:text>
        <xsl:text>The formatted string is '</xsl:text>
        <xsl:value-of 
          select="('(', regex-group(1), ') ', regex-group(2), 
                   '-', regex-group(3), '''')" 
          separator=""/>
      </xsl:matching-substring>
    </xsl:analyze-string>
  </xsl:template>

</xsl:stylesheet>
