<?xml version="1.0"?>
<!-- normalize-space1.xsl -->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:variable name="newline">
    <xsl:text>&#xA;</xsl:text>
  </xsl:variable>

  <xsl:variable name="testString">
    <xsl:text>                 This
is


a string
that had        &#x9;&#x9;    lots of

&#xA;&#xA;&#xA;
whitespace.

</xsl:text>
    </xsl:variable>

  <xsl:template match="/">
    <xsl:text>&#xA;Tests of the normalize-space() function:</xsl:text>

    <xsl:text>&#xA;&#xA;  normalize-space('       </xsl:text>
    <xsl:text>Hello,            World!')="</xsl:text>
    <xsl:value-of 
      select="normalize-space('       Hello,            World!')"/>
    <xsl:text>"</xsl:text>
    <xsl:text>&#xA;  normalize-space($newline)="</xsl:text>
    <xsl:value-of select="normalize-space($newline)"/>
    <xsl:text>"&#xA;</xsl:text>
    <xsl:text>  normalize-space($testString)=&#xA;    "</xsl:text>
    <xsl:value-of select="normalize-space($testString)"/>
    <xsl:text>"</xsl:text>
  </xsl:template>

</xsl:stylesheet>
