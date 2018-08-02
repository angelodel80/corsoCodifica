<?xml version="1.0"?>
<!-- matches.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:template match="/">

    <xsl:variable name="string1"
      select="concat('Now is the time for all good men&#xA;',
              'and women &#xA;',
              'to aid the party.')"/>

    <xsl:text>&#xA;Here's a test of the matches() </xsl:text>
    <xsl:text>function:&#xA;</xsl:text>

    <xsl:text>&#xA;  $string1 = &#xA;</xsl:text>
    <xsl:value-of select="$string1"/>

    <xsl:text>&#xA;&#xA;  Test 1. matches($string1, </xsl:text>
    <xsl:text>'Now.*men') = </xsl:text>
    <xsl:value-of select="matches($string1, 'Now.*men')"/>

    <xsl:text>&#xA;&#xA;  Test 2. matches($string1, </xsl:text>
    <xsl:text>'Now.*men$') = </xsl:text>
    <xsl:value-of select="matches($string1, 'Now.*men$')"/>

    <xsl:text>&#xA;&#xA;  Test 3. matches($string1, </xsl:text>
    <xsl:text>'Now.*men$', 'm') = </xsl:text>
    <xsl:value-of select="matches($string1, 'Now.*men$', 'm')"/>

    <xsl:text>&#xA;&#xA;  Test 4. matches($string1, </xsl:text>
    <xsl:text>'women $', 'm') = </xsl:text>
    <xsl:value-of select="matches($string1, 'women $', 'm')"/>

    <xsl:text>&#xA;&#xA;  Test 5. matches($string1, </xsl:text>
    <xsl:text>'party.$') = </xsl:text>
    <xsl:value-of select="matches($string1, 'party.$')"/>

    <xsl:text>&#xA;&#xA;  Test 6. matches($string1, </xsl:text>
    <xsl:text>'^and' 'm') = </xsl:text>
    <xsl:value-of select="matches($string1, '^and', 'm')"/>

    <xsl:text>&#xA;&#xA;  Test 7. matches($string1, </xsl:text>
    <xsl:text>'women .?to' 's') = </xsl:text>
    <xsl:value-of select="matches($string1, 'women .?to', 's')"/>

    <xsl:text>&#xA;&#xA;  Test 8. matches($string1, </xsl:text>
    <xsl:text>'women .?to' 's') = </xsl:text>
    <xsl:value-of select="matches('9eA3', '^[0-9][a-f][A-F][0-9]$')"/>

  </xsl:template>

</xsl:stylesheet>
