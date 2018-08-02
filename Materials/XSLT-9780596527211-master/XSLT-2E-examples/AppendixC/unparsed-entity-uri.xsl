<?xml version="1.0"?>
<!-- unparsed-entity-uri.xsl -->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;A test of the unparsed-entity-</xsl:text>
    <xsl:text>uri() function:</xsl:text>

    <xsl:text>&#xA;&#xA;   </xsl:text>
    <xsl:text>The URI of the cover image is:&#xA;      </xsl:text>
    <xsl:value-of 
      select="unparsed-entity-uri(/book/prolog/@cover-image)"/>
    <xsl:text>.&#xA;</xsl:text>
  </xsl:template>

</xsl:stylesheet>
