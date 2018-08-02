<?xml version="1.0"?>
<!-- index-of.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:template match="/">

    <xsl:variable name="now" as="xs:time"
      select="current-time()"/>

    <xsl:variable name="testSequence1" as="item()*">
      <xsl:sequence 
        select="(3, 4, 5, 'blue', $now, current-date(), 8, 'blue',
                'Strasse', 'Stra&#xDF;e')"/>
    </xsl:variable>

    <xsl:text>&#xA;Here's a test of the index-of() </xsl:text>
    <xsl:text>function:&#xA;</xsl:text>

    <xsl:text>&#xA;  Our first test sequence ($testSequence1) </xsl:text>
    <xsl:text>is:&#xA;      </xsl:text>
    <xsl:value-of select="$testSequence1" separator="&#xA;      "/>
    <xsl:text>&#xA;&#xA;</xsl:text>

    <xsl:text>    $now = </xsl:text>
    <xsl:value-of select="$now"/>
    <xsl:text>&#xA;&#xA;</xsl:text>

    <xsl:text>    index-of($testSequence1, 3) = (</xsl:text>
    <xsl:value-of 
      select="index-of($testSequence1, 3)" separator=", "/>
    <xsl:text>)&#xA;&#xA;</xsl:text>

    <xsl:text>    index-of($testSequence1, 'red') = (</xsl:text>
    <xsl:value-of 
      select="index-of($testSequence1, 'red')" separator=", "/>
    <xsl:text>)&#xA;&#xA;</xsl:text>

    <xsl:text>    index-of($testSequence1, 'blue') = (</xsl:text>
    <xsl:value-of 
      select="index-of($testSequence1, 'blue')" separator=", "/>
    <xsl:text>)&#xA;&#xA;</xsl:text>

    <xsl:text>    index-of($testSequence1, $now) = (</xsl:text>
    <xsl:value-of 
      select="index-of($testSequence1, $now)" separator=", "/>
    <xsl:text>)</xsl:text>

    <xsl:text>&#xA;&#xA;    index-of($testSequence1, </xsl:text>
    <xsl:text>'stra&#xDF;e') = (</xsl:text>
    <xsl:value-of 
      select="index-of($testSequence1, 'Strasse')"
      separator=", "/>
    <xsl:text>)&#xA;</xsl:text>

    <xsl:text>&#xA;    index-of($testSequence1, </xsl:text>
    <xsl:text>'stra&#xDF;e', [German collation]) = (</xsl:text>
    <xsl:value-of 
      select="index-of($testSequence1, 'Strasse',
              concat('http://saxon.sf.net/collation?',
                     'class=com.oreilly.xslt.GermanCollation;'))"
      separator=", "/>
    <xsl:text>)&#xA;</xsl:text>
  </xsl:template>

</xsl:stylesheet>
