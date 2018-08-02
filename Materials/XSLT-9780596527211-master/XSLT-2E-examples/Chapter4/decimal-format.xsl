<?xml version="1.0" encoding="utf-8"?>
<!-- decimal-format.xsl -->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <!-- This format has no name, so it's assumed to be the default. -->
  <xsl:decimal-format decimal-separator="," grouping-separator="."/>

  <xsl:decimal-format name="us_default"/>

  <xsl:decimal-format name="other_options" NaN="[not a number]"
    infinity="unfathomably huge"/>

  <xsl:decimal-format name="hash_mark" digit="!"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Tests of &lt;xsl:decimal-format&gt; and </xsl:text>
    <xsl:text>format-number():</xsl:text>
    <xsl:text>&#xA;&#xA;  1. format-number(3728493.3882, </xsl:text>
    <xsl:text>'#.###,##') : </xsl:text>
    <xsl:value-of 
      select="format-number(3728493.3882, '#.###,##')"/>

    <xsl:text>&#xA;&#xA;  2. format-number(3728493.3882, </xsl:text>
    <xsl:text>'#,###.##', 'us_default') : </xsl:text>
    <xsl:value-of 
      select="format-number(3728493.3882, '#,###.##', 'us_default')"/>

    <xsl:text>&#xA;&#xA;  3. format-number(number(1) div 0, '#.#') : </xsl:text>
    <xsl:value-of select="format-number(number(1) div 0, '#.#')"/>

    <xsl:text>&#xA;&#xA;  4. format-number(number(1) div 0, '#.#', </xsl:text>
    <xsl:text>'other_options') : &#xA;       </xsl:text>
    <xsl:value-of 
      select="format-number(number(1) div 0, '#.#', 'other_options')"/>

    <xsl:text>&#xA;&#xA;  5. format-number(number('blue') * </xsl:text>
    <xsl:text>number('orange'), '#') : </xsl:text>
    <xsl:value-of 
      select="format-number(number('blue') * number('orange'), '#')"/>

    <xsl:text>&#xA;&#xA;  6. format-number(number('blue') * </xsl:text>
    <xsl:text>number('orange'), '#', 'other_options') : </xsl:text>
    <xsl:text>&#xA;       </xsl:text>
    <xsl:value-of 
      select="format-number(number('blue') * number('orange'), '#', 
              'other_options')"/>

    <xsl:text>&#xA;&#xA;  7. format-number(42, '#!', </xsl:text>
    <xsl:text>'hash_mark') : </xsl:text>
    <xsl:value-of select="format-number(42, '#!', 'hash_mark')"/>
  </xsl:template>

</xsl:stylesheet>
