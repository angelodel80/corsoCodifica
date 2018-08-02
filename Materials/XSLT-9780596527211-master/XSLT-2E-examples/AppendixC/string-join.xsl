<?xml version="1.0"?>
<!-- string-join.xsl -->
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;A test of the string-join() function:&#xA;</xsl:text>

    <xsl:variable name="testSequence" as="xs:string*">
      <xsl:sequence 
        select="('Brooklyn', 'Manhattan', 'Williamsburg',
                'George Washington', 'Tribeca')"/>
    </xsl:variable>
 
    <xsl:text>&#xA;  Our sequence of strings:&#xA;    </xsl:text>
    <xsl:value-of select="$testSequence" separator="&#xA;    "/>

    <xsl:text>&#xA;&#xA;  string-join($testSequeqnce, ' - ') = </xsl:text>
    <xsl:text>&#xA;    </xsl:text>
    <xsl:value-of select="string-join($testSequence, ' - ')"/>

    <xsl:text>&#xA;&#xA;  Courtesy of the specs, here's </xsl:text>
    <xsl:text>another example:&#xA;&#xA;    Ancestors of all </xsl:text>
    <xsl:text>the elements:&#xA;      using string-join&#xA;</xsl:text>
    <xsl:text>            (for $i in unordered</xsl:text>
    <xsl:text>(ancestor-or-self::*) return name($i), </xsl:text>
    <xsl:text>&#xA;             '/'):&#xA;</xsl:text>

    <xsl:for-each select="//*">
      <xsl:text>&#xA;      </xsl:text>
      <xsl:value-of 
        select="string-join(for $i in ancestor-or-self::* 
                return name($i), '/')"/>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
