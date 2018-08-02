<?xml version="1.0"?>
<!-- substring-after2.xsl -->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Another test of the substring-after() </xsl:text>
    <xsl:text>function:&#xA;&#xA;</xsl:text>

    <xsl:text>  substring-after('Schoenaicherstrasse', </xsl:text>
    <xsl:text>'Sch&#xF6;n') = &#xA;    "</xsl:text>
    <xsl:value-of 
      select="substring-after('Schoenaicherstrasse', 'Sch&#xF6;n')"/>
    <xsl:text>"&#xA;</xsl:text>

    <xsl:text>  substring-after('Schoenaicherstrasse', </xsl:text>
    <xsl:text>'Sch&#xF6;n', [German collation]) = &#xA;    "</xsl:text>
    <xsl:value-of 
      select="substring-after('Schoenaicherstrasse', 'Sch&#xF6;n',
              concat('http://saxon.sf.net/collation?', 
                     'class=com.oreilly.xslt.GermanCollation;'))"/>
    <xsl:text>"&#xA;</xsl:text>
  </xsl:template>          
  
</xsl:stylesheet>
