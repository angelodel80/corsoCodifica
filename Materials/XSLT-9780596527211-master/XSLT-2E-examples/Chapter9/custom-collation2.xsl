<?xml version="1.0"?>
<!-- custom-collation2.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:variable name="string1" select="'Stra&#xDF;e'"/>
    <xsl:variable name="string2" select="'Strasse'"/> 

    <xsl:text>&#xA;Here is a test of the compare() </xsl:text>
    <xsl:text>function, using &#xA;</xsl:text>
    <xsl:text>  an extension function to compare German </xsl:text>
    <xsl:text>characters:&#xA;&#xA;</xsl:text>
    
    <xsl:text>  compare('</xsl:text>
    <xsl:value-of select="$string1"/>
    <xsl:text>', '</xsl:text>
    <xsl:value-of select="$string2"/>
    <xsl:text>') = </xsl:text>
    <xsl:value-of select="compare($string1, $string2)"/>
    <xsl:text>&#xA;</xsl:text>

    <xsl:text>  compare('</xsl:text>
    <xsl:value-of select="$string1"/>
    <xsl:text>', '</xsl:text>
    <xsl:value-of select="$string2"/>
    <xsl:text>', [German collation]) = </xsl:text>
    <xsl:value-of 
      select="compare($string1, $string2,
              concat('http://saxon.sf.net/collation?',
                     'class=com.oreilly.xslt.GermanCollation;'))"/>
    <xsl:text>&#xA;</xsl:text>
  </xsl:template>

</xsl:stylesheet>
