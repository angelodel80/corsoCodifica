<?xml version="1.0"?>
<!-- substring-before1.xsl -->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;A test of the substring-before() </xsl:text>
    <xsl:text>function:&#xA;&#xA;</xsl:text>

    <xsl:text>  substring-before('Abracadabra', </xsl:text>
    <xsl:text>'abra')        = "</xsl:text>
    <xsl:value-of 
      select="substring-before('Abracadabra', 'abra')"/>
    <xsl:text>"&#xA;</xsl:text>

    <xsl:text>  substring-before('Abracadabra', </xsl:text>
    <xsl:text>'Abracadabra') = "</xsl:text>
    <xsl:value-of 
      select="substring-before('Abracadabra', 'Abracadabra')"/>
    <xsl:text>"&#xA;</xsl:text>

    <xsl:text>  substring-before('Abracadabra', </xsl:text>
    <xsl:text>'A')           = "</xsl:text>
    <xsl:value-of 
      select="substring-before('Abracadabra', 'A')"/>
    <xsl:text>"&#xA;</xsl:text>

    <xsl:text>  substring-before('Abracadabra', </xsl:text>
    <xsl:text>'a')           = "</xsl:text>
    <xsl:value-of 
      select="substring-before('Abracadabra', 'a')"/>
    <xsl:text>"&#xA;</xsl:text>

    <xsl:text>  substring-before('Abracadabra', </xsl:text>
    <xsl:text>'')            = "</xsl:text>
    <xsl:value-of 
      select="substring-before('Abracadabra', '')"/>
    <xsl:text>"&#xA;</xsl:text>
  </xsl:template>          
  
</xsl:stylesheet>
