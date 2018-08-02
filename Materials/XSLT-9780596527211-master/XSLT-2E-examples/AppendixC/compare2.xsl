<?xml version="1.0"?>
<!-- compare1.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Here are some tests of the XPath </xsl:text>
    <xsl:text>comparison operators:&#xA;</xsl:text>

    <xsl:text>&#xA;  'Lily' gt 'lily' = </xsl:text>
    <xsl:value-of select="if ('Lily' gt 'lily')
                          then '''Lily'' is greater'
                          else '''lily'' is greater'"/>

    <xsl:text>&#xA;  compare('Lily', 'Lily') = </xsl:text>
    <xsl:value-of select="compare('Lily', 'Lily')"/>

    <xsl:text>&#xA;  compare('Lily', </xsl:text>
    <xsl:text>'&amp;#x4C;&amp;#x69;&amp;#x6C;&amp;#x79;') = </xsl:text>
    <xsl:value-of select="compare('Lily', '&#x4C;&#x69;&#x6C;&#x79;')"/>

    <xsl:text>&#xA;  compare('Lily', 'Doug') = </xsl:text>
    <xsl:value-of select="compare('Lily', 'Doug')"/>

    <xsl:text>&#xA;&#xA;  if (not(compare('Lily', 'Lily'))) : </xsl:text>
    <xsl:value-of select="if (not(compare('Lily', 'Lily'))) 
                          then 'The two test strings are equal!'
                          else 'The two test strings aren''t equal!'"/>
  </xsl:template>

</xsl:stylesheet>
