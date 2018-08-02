<?xml version="1.0" encoding="utf-8"?>
<!-- encode-for-uri.xsl -->
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Tests of the encode-for-uri() function:</xsl:text>

    <xsl:text>&#xA;&#xA;  encode-for-uri</xsl:text>
    <xsl:text>('http://www.oreilly.com/') = &#xA;    </xsl:text>
    <xsl:value-of 
      select="encode-for-uri('http://www.oreilly.com/')"/>

    <xsl:text>&#xA;&#xA;  concat('http://www.example.com/', </xsl:text>
    <xsl:text>&#xA;         encode-for-uri</xsl:text>
    <xsl:text>('~b&#xE9;b&#xE9;')) = &#xA;    </xsl:text>
    <xsl:value-of
      select="concat('http://www.example.com/', 
              encode-for-uri('~b&#xE9;b&#xE9;'))"/>

    <xsl:text>&#xA;&#xA;  concat('http://www.example.com/', </xsl:text>
    <xsl:text>&#xA;         encode-for-uri</xsl:text>
    <xsl:text>('100% organic')) = &#xA;    </xsl:text>
    <xsl:value-of 
      select="concat('http://www.example.com/', 
              encode-for-uri('100% organic'))"/>
  </xsl:template>

</xsl:stylesheet>
