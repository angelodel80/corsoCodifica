<?xml version="1.0" encoding="utf-8"?>
<!-- iri-to-uri.xsl -->
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Tests of the iri-to-uri() function:</xsl:text>

    <xsl:text>&#xA;&#xA;  iri-to-uri('http://www.example.com/</xsl:text>
    <xsl:text>00/Weather/CA/Los Angeles#ocean') = &#xA;    </xsl:text>
    <xsl:value-of 
      select="iri-to-uri('http://www.example.com/00/Weather/CA/Los Angeles#ocean')"/>

    <xsl:text>&#xA;&#xA;  iri-to-uri('http://www.example.com/</xsl:text>
    <xsl:text>~b&#xE9;b&#xE9;') = &#xA;    </xsl:text>
    <xsl:value-of
      select="iri-to-uri('http://www.example.com/~b&#xE9;b&#xE9;')"/>

    <!-- The character &#x5BB6; is Japanese for "home," I hope... -->
    <xsl:text>&#xA;&#xA;  iri-to-uri('http://www.example.co.jp/</xsl:text>
    <xsl:text>&#x5BB6;') = &#xA;    </xsl:text>
    <xsl:value-of 
      select="iri-to-uri('http://www.example.co.jp/&#x5BB6;')"/>
  </xsl:template>

</xsl:stylesheet>
