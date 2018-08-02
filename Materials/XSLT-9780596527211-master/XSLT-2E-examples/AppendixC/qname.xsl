<?xml version="1.0"?>
<!-- qname.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Tests of the QName() constructor function:&#xA;</xsl:text>

    <xsl:variable name="testQName1" as="xs:QName"
      select="QName('http://www.authors.com', 'auth:author')"/>
    
    <xsl:text>&#xA;  testQName1 = QName('http://www.</xsl:text>
    <xsl:text>authors.com', 'auth:author')</xsl:text>
    <xsl:text>&#xA;  prefix-from-QName</xsl:text>
    <xsl:text>($testQName1) = "</xsl:text>
    <xsl:value-of select="prefix-from-QName($testQName1)"/>
    <xsl:text>"&#xA;  local-name-from-QName($testQName1) = "</xsl:text>
    <xsl:value-of select="local-name-from-QName($testQName1)"/>
    <xsl:text>"&#xA;  namespace-uri-from-QName($testQName1) = "</xsl:text>
    <xsl:value-of select="namespace-uri-from-QName($testQName1)"/>
    <xsl:text>"</xsl:text>

    <xsl:variable name="testQName2" as="xs:QName"
      select="QName('', 'sonnet')"/>

    <xsl:text>&#xA;&#xA;  testQName2 = QName('', 'sonnet')</xsl:text>
    <xsl:text>&#xA;  prefix-from-QName</xsl:text>
    <xsl:text>($testQName2) = "</xsl:text>
    <xsl:value-of select="prefix-from-QName($testQName2)"/>
    <xsl:text>"&#xA;  local-name-from-QName($testQName2) = "</xsl:text>
    <xsl:value-of select="local-name-from-QName($testQName2)"/>
    <xsl:text>"&#xA;  namespace-uri-from-QName($testQName2) = "</xsl:text>
    <xsl:value-of select="namespace-uri-from-QName($testQName2)"/>
    <xsl:text>"</xsl:text>

    <xsl:variable name="testQName3" as="xs:QName"
      select="QName('http://www.authors.com/', 'writer')"/>

    <xsl:text>&#xA;&#xA;  testQName3 = QName('http://www.</xsl:text>
    <xsl:text>authors.com/', 'writer')</xsl:text>
    <xsl:text>&#xA;  prefix-from-QName</xsl:text>
    <xsl:text>($testQName3) = "</xsl:text>
    <xsl:value-of select="prefix-from-QName($testQName3)"/>
    <xsl:text>"&#xA;  local-name-from-QName($testQName3) = "</xsl:text>
    <xsl:value-of select="local-name-from-QName($testQName3)"/>
    <xsl:text>"&#xA;  namespace-uri-from-QName($testQName3) = "</xsl:text>
    <xsl:value-of select="namespace-uri-from-QName($testQName3)"/>
    <xsl:text>"</xsl:text>

  </xsl:template>

</xsl:stylesheet>
