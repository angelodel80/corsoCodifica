<?xml version="1.0" encoding="utf-8"?>
<!-- compare-sequences.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">
  
  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Comparing sequences with values:</xsl:text>
    <xsl:text>&#xA;  Sales figures (/report/brand/units):</xsl:text>
    <xsl:text>&#xA;    </xsl:text>
    <xsl:value-of select="/report/brand/units" separator=", "/>
    <xsl:text>&#xA;&#xA;      /report/brand/units &gt;  27408 : </xsl:text>
    <xsl:value-of select="/report/brand/units &gt; 27408"/>
    <xsl:text>&#xA;      /report/brand/units &gt;= 27408 : </xsl:text>
    <xsl:value-of select="/report/brand/units &gt;= 27408"/>
    <xsl:text>&#xA;      /report/brand/units &lt;  8203  : </xsl:text>
    <xsl:value-of select="/report/brand/units &lt; 8203"/>
    <xsl:text>&#xA;      /report/brand/units &lt;= 8203  : </xsl:text>
    <xsl:value-of select="/report/brand/units &lt;= 8203"/>
    <xsl:text>&#xA;      /report/brand/units =  22101 : </xsl:text>
    <xsl:value-of select="/report/brand/units = 22101"/>
    <xsl:text>&#xA;      /report/brand/units =  17905 : </xsl:text>
    <xsl:value-of select="/report/brand/units = 17905"/>
    <xsl:text>&#xA;  not(/report/brand/units =  17905): </xsl:text>
    <xsl:value-of select="not(/report/brand/units = 17905)"/>

    <xsl:text>&#xA;&#xA;Comparing two sequences:</xsl:text>
    <xsl:variable name="testSequence1" as="xs:integer*"
      select="(8203, 22101, 27408, 19268, 14336)"/>
    <xsl:text>&#xA;  $testSequence1 (xs:integer*):&#xA;    (</xsl:text>
    <xsl:value-of select="$testSequence1" separator=", "/>
    <xsl:text>)&#xA;  $testSequence1 = /report/brand/units: </xsl:text>
    <xsl:value-of select="$testSequence1 = /report/brand/units"/>

    <xsl:variable name="testSequence2" as="xs:integer*"
      select="(19268, 17, 95, 6, 42)"/>
    <xsl:text>&#xA;&#xA;  $testSequence2 (xs:integer*):&#xA;    (</xsl:text>
    <xsl:value-of select="$testSequence2" separator=", "/>
    <xsl:text>)&#xA;  $testSequence2 = /report/brand/units: </xsl:text>
    <xsl:value-of select="$testSequence2 = /report/brand/units"/>
    <xsl:text>&#xA;  $testSequence2 &lt; /report/brand/units: </xsl:text>
    <xsl:value-of select="$testSequence2 &lt; /report/brand/units"/>
    <xsl:text>&#xA;  $testSequence2 &gt; /report/brand/units: </xsl:text>
    <xsl:value-of select="$testSequence2 &gt; /report/brand/units"/>

    <xsl:variable name="testSequence3" as="xs:string*"
      select="('blue', 'white', '19268')"/>
    <xsl:text>&#xA;&#xA;  $testSequence3 (xs:string*):&#xA;    (</xsl:text>
    <xsl:value-of select="$testSequence3" separator=", "/>
    <xsl:text>)&#xA;  $testSequence3 = /report/brand/units: </xsl:text>
    <xsl:value-of select="$testSequence3 = /report/brand/units"/>

    <xsl:variable name="testSequence4" as="xs:yearMonthDuration*"
      select="(xs:yearMonthDuration('P3Y8M'), 
               xs:yearMonthDuration('P4Y8M'), 
               xs:yearMonthDuration('P2Y9M'))"/>
    <xsl:text>&#xA;&#xA;  $testSequence4 (xs:yearMonthDuration*):</xsl:text>
    <xsl:text>&#xA;    (</xsl:text>
    <xsl:value-of select="$testSequence4" separator=", "/>
    <xsl:text>)&#xA;  $testSequence4 &gt; </xsl:text>
    <xsl:text>xs:yearMonthDuration('P4Y7M'): </xsl:text>
    <xsl:value-of select="$testSequence4 > xs:yearMonthDuration('P4Y7M')"/>
      <xsl:value-of select="number(/report/brand[1]/units) gt 20000"/>
  </xsl:template>

</xsl:stylesheet>
