<?xml version="1.0"?>
<!-- distinct-values3.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;A final test of the </xsl:text>
    <xsl:text>distinct-values() function:&#xA;&#xA;</xsl:text>

    <xsl:variable name="testStrings" as="xs:string*">
      <xsl:sequence
        select="'street', 'Strasse', 'Stra&#xDF;e'"/>
    </xsl:variable>

    <xsl:text>  The test sequence: &#xA;    </xsl:text>
    <xsl:value-of select="$testStrings" separator=", "/>
    <xsl:text>&#xA;  distinct-values($testStrings):</xsl:text>
    <xsl:text>&#xA;    </xsl:text>
    <xsl:value-of select="distinct-values($testStrings)" 
      separator=", "/>

    <xsl:text>&#xA;  distinct-values($testStrings, </xsl:text>
    <xsl:text>[German collation]):&#xA;    </xsl:text>
    <xsl:value-of 
      select="distinct-values($testStrings, 
              concat('http://saxon.sf.net/collation?', 
                     'class=com.oreilly.xslt.GermanCollation;'))"
      separator=", "/>
  </xsl:template>

</xsl:stylesheet>
