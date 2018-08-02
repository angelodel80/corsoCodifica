<?xml version="1.0" encoding="UTF-8"?>
<!-- escape-html-uri.xsl -->
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Tests of the escape-html-uri() function:</xsl:text>

    <xsl:text>&#xA;&#xA;  escape-html-uri</xsl:text>
    <xsl:text>('http://www.example.com/~b&#xE9;b&#xE9;') = &#xA;    </xsl:text>
    <xsl:value-of
      select="escape-html-uri('http://www.example.com/~b&#xE9;b&#xE9;')"/>
  </xsl:template>

</xsl:stylesheet>
