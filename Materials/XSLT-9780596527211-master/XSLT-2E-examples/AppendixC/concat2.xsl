<?xml version="1.0"?>
<!-- concat2.xsl -->
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Another test of the concat() function: &#xA;</xsl:text>
    
    <xsl:text>&#xA;  concat(3, 4, current-time(), 'blue', </xsl:text>
    <xsl:text>/list/title) = &#xA;    </xsl:text>
    <xsl:value-of 
      select="concat(3, 4, current-time(), 'blue', /list/title)"/>
  </xsl:template>

</xsl:stylesheet>
