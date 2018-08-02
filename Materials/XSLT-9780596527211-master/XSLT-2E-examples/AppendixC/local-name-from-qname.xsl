<?xml version="1.0"?>
<!-- local-name-from-qname.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Tests of the local-name-from-QName() </xsl:text>
    <xsl:text>function:&#xA;</xsl:text>

    <xsl:variable name="testQName1" as="xs:QName"
      select="QName('http://www.authors.com', 'auth:author')"/>
    
    <xsl:text>&#xA;  QName('http://www.authors.com', </xsl:text>
    <xsl:text>'auth:author') = </xsl:text>
    <xsl:value-of select="$testQName1"/>

    <xsl:text>&#xA;    The local name associated with </xsl:text>
    <xsl:text>this QName: "</xsl:text>
    <xsl:value-of select="local-name-from-QName($testQName1)"/>
    <xsl:text>"</xsl:text>

    <xsl:variable name="testQName2" as="xs:QName"
      select="QName('', 'sonnet')"/>

    <xsl:text>&#xA;&#xA;  QName('', 'sonnet') = </xsl:text>
    <xsl:value-of select="$testQName2"/>

    <xsl:text>&#xA;    The local name associated with </xsl:text>
    <xsl:text>this QName: "</xsl:text>
    <xsl:value-of select="local-name-from-QName($testQName2)"/>
    <xsl:text>"</xsl:text>

  </xsl:template>

</xsl:stylesheet>
