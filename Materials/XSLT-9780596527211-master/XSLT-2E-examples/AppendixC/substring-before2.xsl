<?xml version="1.0"?>
<!-- substring-before2.xsl -->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Another test of the substring-before() </xsl:text>
    <xsl:text>function:&#xA;&#xA;</xsl:text>

    <xsl:text>  substring-before('Schoenaicherstrasse', </xsl:text>
    <xsl:text>'stra&#xDF;3') = &#xA;    "</xsl:text>
    <xsl:value-of 
      select="substring-before('Schoenaicherstrasse', 'stra&#xDF;e')"/>
    <xsl:text>"&#xA;</xsl:text>

    <xsl:text>  substring-before('Schoenaicherstrasse', </xsl:text>
    <xsl:text>'stra&#xDF;e', [German collation]) = &#xA;    "</xsl:text>
    <xsl:value-of 
      select="substring-before('Schoenaicherstrasse', 'stra&#xDF;e',
              concat('http://saxon.sf.net/collation?', 
                     'class=com.oreilly.xslt.GermanCollation;'))"/>
    <xsl:text>"&#xA;</xsl:text>
  </xsl:template>          
  
</xsl:stylesheet>
