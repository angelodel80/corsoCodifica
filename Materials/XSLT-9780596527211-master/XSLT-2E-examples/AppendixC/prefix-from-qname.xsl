<?xml version="1.0"?>
<!-- prefix-from-qname.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Tests of the prefix-from-QName() </xsl:text>
    <xsl:text>function:&#xA;</xsl:text>

    <xsl:variable name="testQName1" as="xs:QName"
      select="resolve-QName('auth:last-name', 
              /sonnet/*:author/last-name)"/>
    <xsl:text>&#xA;  testQName1 = resolve-QName('auth:last-name', </xsl:text>
    <xsl:text>/sonnet/*:author/last-name)</xsl:text>
    <xsl:text>&#xA;  prefix-from-QName($testQName1) = "</xsl:text>
    <xsl:value-of select="prefix-from-QName($testQName1)"/>
    <xsl:text>"</xsl:text>

    <xsl:variable name="testQName2" as="xs:QName"
      select="resolve-QName('something-else', /sonnet)"/>
    <xsl:text>&#xA;&#xA;  testQName2 = resolve-QName('</xsl:text>
    <xsl:text>something-else', /sonnet)</xsl:text>
    <xsl:text>&#xA;  prefix-from-QName($testQName2) = "</xsl:text>
    <xsl:value-of select="prefix-from-QName($testQName2)"/>
    <xsl:text>"</xsl:text>

    <xsl:variable name="testQName3" as="xs:QName"
      select="QName('http://www.authors.com/', 'pfx:writer')"/>
    <xsl:text>&#xA;&#xA;  testQName3 = QName('http://www.</xsl:text>
    <xsl:text>authors.com/', 'pfx:writer')&#xA;</xsl:text>
    <xsl:text>  prefix-from-QName($testQName3) = "</xsl:text>
    <xsl:value-of select="prefix-from-QName($testQName3)"/>
    <xsl:text>"</xsl:text>

  </xsl:template>

</xsl:stylesheet>
