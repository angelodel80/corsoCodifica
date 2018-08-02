<?xml version="1.0"?>
<!-- replace.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:template match="/">

    <xsl:variable name="string1"
      select="concat('Now is the time for all good men and ',
              'women to aid the party.')"/>
    <xsl:variable name="string2" as="xs:string"
      select="'Visa # 1234-5678-9101-1121'"/>

    <xsl:text>&#xA;Here's a test of the replace() </xsl:text>
    <xsl:text>function:&#xA;</xsl:text>

    <xsl:text>&#xA;  $string1 = &#xA;    </xsl:text>
    <xsl:value-of select="$string1"/>

    <xsl:text>&#xA;&#xA;  Test 1. replace($string1, </xsl:text>
    <xsl:text>'men', 'boys') = &#xA;    </xsl:text>
    <xsl:value-of select="replace($string1, 'men', 'boys')"/>

    <xsl:text>&#xA;&#xA;  Test 2. replace($string1, </xsl:text>
    <xsl:text>' men', ' boys') = &#xA;    </xsl:text>
    <xsl:value-of select="replace($string1, ' men', ' boys')"/>

    <xsl:text>&#xA;&#xA;  Test 3. replace($string1, </xsl:text>
    <xsl:text>'wombats', 'weasels') = &#xA;    </xsl:text>
    <xsl:value-of select="replace($string1, 'wombats', 'weasels')"/>

    <xsl:text>&#xA;&#xA;  $string2 = &#xA;    </xsl:text>
    <xsl:value-of select="$string2"/>

    <xsl:text>&#xA;&#xA;  Test 4. replace($string2, </xsl:text>
    <xsl:text>&#xA;                  </xsl:text>
    <xsl:text>'([0-9]{4})-([0-9]{4})-([0-9]{4})-([0-9]{4})', </xsl:text>
    <xsl:text>&#xA;                  </xsl:text>
    <xsl:text>'XXXX-XXXX-XXXX-$4') = &#xA;    </xsl:text>
    <xsl:value-of 
      select="replace($string2, 
              '([0-9]{4})-([0-9]{4})-([0-9]{4})-([0-9]{4})', 
              'XXXX-XXXX-XXXX-$4')"/>

    <xsl:text>&#xA;&#xA;  Test 5. replace($string2, </xsl:text>
    <xsl:text>&#xA;                  </xsl:text>
    <xsl:text>'([0-9]{4})-([0-9]{4})-([0-9]{4})-([0-9]{4})', </xsl:text>
    <xsl:text>&#xA;                  </xsl:text>
    <xsl:text>'$0 -> XXXX-XXXX-XXXX-$4') = &#xA;    </xsl:text>
    <xsl:value-of 
      select="replace($string2, 
              '([0-9]{4})-([0-9]{4})-([0-9]{4})-([0-9]{4})', 
              '$0 -> XXXX-XXXX-XXXX-$4')"/>

  </xsl:template>

</xsl:stylesheet>
