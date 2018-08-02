<?xml version="1.0"?>
<!-- boolean2.xsl -->
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;</xsl:text>
    <xsl:text>Tests of the boolean() function:</xsl:text>

    <xsl:text>&#xA;&#xA;  boolean(()) = </xsl:text>
    <xsl:value-of select="boolean(())"/>

    <xsl:variable name="testSequence1" as="item()*">
      <xsl:sequence select="(3)"/>
    </xsl:variable>

    <xsl:text>&#xA;&#xA;  $testSequence1 = (</xsl:text>
    <xsl:value-of select="$testSequence1" separator=", "/>
    <xsl:text>)&#xA;  boolean($testSequence1) = </xsl:text>
    <xsl:value-of select="boolean($testSequence1)"/>

    <xsl:variable name="testSequence2" as="item()*">
      <xsl:sequence select="/report/brand/units"/>
      <xsl:sequence select="(3, 4, 5)"/>
    </xsl:variable>

    <xsl:text>&#xA;&#xA;  $testSequence2 = (</xsl:text>
    <xsl:value-of select="$testSequence2" separator=", "/>
    <xsl:text>)&#xA;  boolean($testSequence2) = </xsl:text>
    <xsl:value-of select="boolean($testSequence2)"/>
  </xsl:template>

</xsl:stylesheet>
