<?xml version="1.0"?>
<!-- contains2.xsl -->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:variable name="string1" 
      select="'Sch&#xF6;naicherstra&#xDF;e'"/>
    <xsl:variable name="string2" select="'strasse'"/>

    <xsl:text>&#xA;Another test of the contains() </xsl:text>
    <xsl:text>function:&#xA;&#xA;</xsl:text>

    <xsl:text>  contains('</xsl:text>
    <xsl:value-of select="$string1"/>
    <xsl:text>', '</xsl:text>
    <xsl:value-of select="$string2"/>
    <xsl:text>') = </xsl:text>
    <xsl:value-of select="contains($string1, $string2)"/>
    <xsl:text>&#xA;</xsl:text>

    <xsl:text>  contains('</xsl:text>
    <xsl:value-of select="$string1"/>
    <xsl:text>', '</xsl:text>
    <xsl:value-of select="$string2"/>
    <xsl:text>', [German collation]) = </xsl:text>
    <xsl:value-of 
      select="contains($string1, $string2,
              concat('http://saxon.sf.net/collation?',
                     'class=com.oreilly.xslt.GermanCollation;'))"/>
    <xsl:text>&#xA;</xsl:text>
  </xsl:template>
  
</xsl:stylesheet>
