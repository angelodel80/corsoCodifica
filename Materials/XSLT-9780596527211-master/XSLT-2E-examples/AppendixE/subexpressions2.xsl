<?xml version="1.0" encoding="utf-8"?>
<!-- subexpressions2.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>The string '</xsl:text>
    <xsl:value-of 
      select="replace('Call me at 919-555-1212, please', 
              '([0-9]{3})-([0-9]{3})-([0-9]{4})', 
              '$0')"/>
    <xsl:text>' contains a match!&#xA;</xsl:text>
    <xsl:text>The version with all the replacements: &#xA;  </xsl:text>
    <xsl:value-of 
      select="replace('Call me at 919-555-1212, please', 
              '([0-9]{3})-([0-9]{3})-([0-9]{4})', 
              '($1) $2-$3')"/>
  </xsl:template>

</xsl:stylesheet>
