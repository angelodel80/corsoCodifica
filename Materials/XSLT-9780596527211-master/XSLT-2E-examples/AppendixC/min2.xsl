<?xml version="1.0"?>
<!-- min2.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:variable name="seq1" 
      select="('stra&#xDF;e', 'strasse')"/>
    <xsl:variable name="seq2" select="reverse($seq1)"/>

    <xsl:text>&#xA;Here are some tests of the min() function:&#xA;</xsl:text>

    <xsl:text>&#xA;  min(</xsl:text>
    <xsl:value-of select="$seq1" separator=", "/>
    <xsl:text>) = </xsl:text>
    <xsl:value-of select="min($seq1)"/>

    <xsl:text>&#xA;  min(</xsl:text>
    <xsl:value-of select="$seq1" separator=", "/>
    <xsl:text> [German collation]) = </xsl:text>
    <xsl:value-of 
      select="min($seq1, 
              concat('http://saxon.sf.net/collation?', 
                     'class=com.oreilly.xslt.GermanCollation;'))"/>

    <xsl:text>&#xA;  min(</xsl:text>
    <xsl:value-of select="$seq2" separator=", "/>
    <xsl:text> [German collation]) = </xsl:text>
    <xsl:value-of 
      select="min($seq2, 
              concat('http://saxon.sf.net/collation?', 
                     'class=com.oreilly.xslt.GermanCollation;'))"/>

  </xsl:template>

</xsl:stylesheet>
