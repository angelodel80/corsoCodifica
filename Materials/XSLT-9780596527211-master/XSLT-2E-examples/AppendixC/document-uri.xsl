<?xml version="1.0"?>
<!-- document-uri.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;A test of the document-uri() function:</xsl:text>

    <xsl:text>&#xA;&#xA;  The document URI for the </xsl:text>
    <xsl:text>root element is:&#xA;    </xsl:text>
    <xsl:value-of select="document-uri(/)"/>
  </xsl:template>

</xsl:stylesheet>
