<?xml version="1.0" encoding="utf-8"?>
<!-- anchors.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>matches('abcdefghij', 'cde'): </xsl:text>
    <xsl:value-of 
      select="if (matches('abcdefghij', 'cde'))
              then 'It''s a match!'
              else 'No match'"/>
    <xsl:text>&#xA;matches('abcdefghij', 'cde$'): </xsl:text>
    <xsl:value-of 
      select="if (matches('abcdefghij', 'cde$'))
              then 'It''s a match!'
              else 'No match'"/>
    <xsl:text>&#xA;matches('abcdefghij', 'hij$'): </xsl:text>
    <xsl:value-of 
      select="if (matches('abcdefghij', 'hij$'))
              then 'It''s a match!'
              else 'No match'"/>
    <xsl:text>&#xA;matches('ab&amp;#xA;cdefghij', '^cde', 'm'): </xsl:text>
    <xsl:value-of 
      select="if (matches('ab&#xA;cdefghij', '^cde', 'm'))
              then 'It''s a match!'
              else 'No match'"/>
  </xsl:template>

</xsl:stylesheet>
