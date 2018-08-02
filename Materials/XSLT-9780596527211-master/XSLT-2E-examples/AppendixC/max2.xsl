<?xml version="1.0"?>
<!-- max2.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:variable name="seq1" 
      select="('strasse', 'stra&#xDF;e')"/>
    <xsl:variable name="seq2" select="reverse($seq1)"/>

    <xsl:text>&#xA;Here are some tests of the max() function:&#xA;</xsl:text>

    <xsl:text>&#xA;  max(</xsl:text>
    <xsl:value-of select="$seq1" separator=", "/>
    <xsl:text>) = </xsl:text>
    <xsl:value-of select="max($seq1)"/>

    <xsl:text>&#xA;  max(</xsl:text>
    <xsl:value-of select="$seq1" separator=", "/>
    <xsl:text> [German collation]) = </xsl:text>
    <xsl:value-of 
      select="max($seq1, 
              concat('http://saxon.sf.net/collation?', 
                     'class=com.oreilly.xslt.GermanCollation;'))"/>

    <xsl:text>&#xA;  max(</xsl:text>
    <xsl:value-of select="$seq2" separator=", "/>
    <xsl:text> [German collation]) = </xsl:text>
    <xsl:value-of 
      select="max($seq2, 
              concat('http://saxon.sf.net/collation?', 
                     'class=com.oreilly.xslt.GermanCollation;'))"/>

  </xsl:template>

</xsl:stylesheet>
