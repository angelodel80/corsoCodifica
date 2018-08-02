<?xml version="1.0"?>
<!-- deep-equal.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">
  
  <xsl:output method="text"/>

  <xsl:variable name="testTree" as="node()*">
    <ora:report month="8" year="2006"
      xmlns:ora="http://www.oreilly.com">
      <ora:title>Chocolate bar sales</ora:title>
      <ora:brand>
        <ora:name>Lindt</ora:name>
        <ora:units>27408</ora:units>
      </ora:brand>
    </ora:report>
    
    <dw:report month="8" year="2006"
      xmlns:dw="http://www.oreilly.com">
      <dw:title>Chocolate bar sales</dw:title>
      <dw:brand>
        <dw:name>Lindt</dw:name>
        <dw:units>27408</dw:units>
      </dw:brand>
    </dw:report>
    
    <report month="8" year="2006">
      <title>Chocolate bar sales</title>
      <brand>
        <name>Lindt</name>
        <units>27408</units>
      </brand>
    </report>
    
    <address>
      <company>IBM Boeblingen</company>
      <street>Schoenaicherstrasse 220</street>
    </address>
    
    <address>
      <company>IBM B&#xF6;blingen</company>
      <street>Sch&#xF6;naicherstra&#xDF;e 220</street>
    </address>
  </xsl:variable>
  
  <xsl:variable name="sequence1" as="item()*">
    <xsl:sequence select="(3, 4, 5)"/>
  </xsl:variable>
  
  <xsl:variable name="sequence2" as="item()*">
    <xsl:sequence select="(3, 5, 4)"/>
  </xsl:variable>
  
  <xsl:variable name="sequence3" as="item()*">
    <xsl:sequence select="(3, 4, 5)"/>
  </xsl:variable>
  
  <xsl:template match="/">
    <xsl:text>&#xA;Tests of the deep-equal() function:</xsl:text>

    <xsl:text>&#xA;&#xA;  $sequence1 = (</xsl:text>
    <xsl:value-of select="$sequence1" separator=", "/>
    <xsl:text>)</xsl:text>
    <xsl:text>&#xA;  $sequence2 = (</xsl:text>
    <xsl:value-of select="$sequence2" separator=", "/>
    <xsl:text>)</xsl:text>
    <xsl:text>&#xA;  $sequence3 = (</xsl:text>
    <xsl:value-of select="$sequence3" separator=", "/>
    <xsl:text>)</xsl:text>

    <xsl:text>&#xA;&#xA;  deep-equal(</xsl:text>
    <xsl:text>$sequence1, $sequence2) = </xsl:text>
    <xsl:value-of select="deep-equal($sequence1, $sequence2)"/>

    <xsl:text>&#xA;&#xA;  deep-equal(</xsl:text>
    <xsl:text>$sequence1, $sequence3) = </xsl:text>
    <xsl:value-of select="deep-equal($sequence1, $sequence3)"/>

    <xsl:text>&#xA;&#xA;  deep-equal(</xsl:text>
    <xsl:text>subsequence($sequence1, 3, 1), &#xA;</xsl:text>
    <xsl:text>             subsequence($sequence2, 2, 1) = </xsl:text>
    <xsl:value-of 
      select="deep-equal(subsequence($sequence1, 3, 1), 
              subsequence($sequence2, 2, 1))"/>

    <xsl:text>&#xA;&#xA;  Comparing the first two </xsl:text>
    <xsl:text>subtrees in $testTree:</xsl:text>
    <xsl:text>&#xA;    deep-equal(subsequence($testTree, 1, 1),&#xA;</xsl:text>
    <xsl:text>               subsequence($testTree, 2, 1)) = </xsl:text>
    <xsl:value-of 
      select="deep-equal(subsequence($testTree, 1, 1), 
              subsequence($testTree, 2, 1))"/>

    <xsl:text>&#xA;&#xA;  Comparing part of our input </xsl:text>
    <xsl:text>document to &#xA;      part of the third subtree </xsl:text>
    <xsl:text>in $testTree:</xsl:text>
    <xsl:text>&#xA;    deep-equal(/report/brand[1]/units,&#xA;</xsl:text>
    <xsl:text>               subsequence($testTree, 3, 1)</xsl:text>
    <xsl:text>/brand[1]/units) = </xsl:text>
    <xsl:value-of 
      select="deep-equal(/report/brand[1]/units, 
              subsequence($testTree, 3, 1)/brand[1]/units)"/>

    <xsl:text>&#xA;&#xA;  Comparing two German addresses:</xsl:text>
    <xsl:text>&#xA;    deep-equal(subsequence($testTree, 4, 1),&#xA;</xsl:text>
    <xsl:text>               subsequence($testTree, 5, 1)) = </xsl:text>
    <xsl:value-of 
      select="deep-equal(subsequence($testTree, 4, 1), 
              subsequence($testTree, 5, 1))"/>

    <xsl:text>&#xA;&#xA;  Comparing two German addresses </xsl:text>
    <xsl:text>using German collation: </xsl:text>
    <xsl:text>&#xA;    deep-equal(subsequence($testTree, 4, 1),&#xA;</xsl:text>
    <xsl:text>               subsequence($testTree, 5, 1), &#xA;</xsl:text>
    <xsl:text>               $GermanCollation) = </xsl:text>
    <xsl:value-of 
      select="deep-equal(subsequence($testTree, 4, 1), 
              subsequence($testTree, 5, 1),
              concat('http://saxon.sf.net/collation?',
                     'class=com.oreilly.xslt.GermanCollation;'))"/>
  </xsl:template>

</xsl:stylesheet>
