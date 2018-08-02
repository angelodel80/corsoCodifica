<?xml version="1.0"?>
<!-- substring-after1.xsl -->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;A test of the substring-after() </xsl:text>
    <xsl:text>function:&#xA;&#xA;</xsl:text>

    <xsl:text>  substring-after('Abracadabra', </xsl:text>
    <xsl:text>'bra')  = "</xsl:text>
    <xsl:value-of 
      select="substring-after('Abracadabra', 'bra')"/>
    <xsl:text>"&#xA;</xsl:text>

    <xsl:text>  substring-after('Abracadabra', </xsl:text>
    <xsl:text>'abra') = "</xsl:text>
    <xsl:value-of 
      select="substring-after('Abracadabra', 'abra')"/>
    <xsl:text>"&#xA;</xsl:text>

    <xsl:text>  substring-after('Abracadabra', </xsl:text>
    <xsl:text>'A')    = "</xsl:text>
    <xsl:value-of 
      select="substring-after('Abracadabra', 'A')"/>
    <xsl:text>"&#xA;</xsl:text>

    <xsl:text>  substring-after('Abracadabra', </xsl:text>
    <xsl:text>'A')    = "</xsl:text>
    <xsl:value-of 
      select="substring-after('Abracadabra', 'a')"/>
    <xsl:text>"&#xA;</xsl:text>

    <xsl:text>  substring-after('Abracadabra', </xsl:text>
    <xsl:text>'')     = "</xsl:text>
    <xsl:value-of 
      select="substring-after('Abracadabra', '')"/>
    <xsl:text>"&#xA;</xsl:text>
  </xsl:template>          
  
</xsl:stylesheet>
