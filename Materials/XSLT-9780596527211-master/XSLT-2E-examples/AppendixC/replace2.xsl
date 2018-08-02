<?xml version="1.0"?>
<!-- replace2.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;A test of the replace() function:&#xA;&#xA;</xsl:text>
    <xsl:text>  Replacing 'World' with 'Mundo' in </xsl:text>
    <xsl:text>'Hello World!': &#xA;    </xsl:text>
    <xsl:value-of select="replace('Hello World', 'World', 'Mundo')"/>
  </xsl:template>
  
</xsl:stylesheet>
