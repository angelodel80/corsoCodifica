<?xml version="1.0"?>
<!-- resolve-qname.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Tests of the resolve-QName() function:&#xA;</xsl:text>

    <xsl:variable name="testQName1" as="xs:QName"
      select="resolve-QName('auth:last-name', 
              /sonnet/*:author/last-name)"/>

    <xsl:text>&#xA;  testQName1 = resolve-QName('auth:</xsl:text>
    <xsl:text>last-name', /sonnet/author/last-name)</xsl:text>
    <xsl:text>&#xA;  prefix-from-QName</xsl:text>
    <xsl:text>($testQName1) = "</xsl:text>
    <xsl:value-of select="prefix-from-QName($testQName1)"/>
    <xsl:text>"&#xA;  local-name-from-QName($testQName1) = "</xsl:text>
    <xsl:value-of select="local-name-from-QName($testQName1)"/>
    <xsl:text>"&#xA;  namespace-uri-from-QName($testQName1) = "</xsl:text>
    <xsl:value-of select="namespace-uri-from-QName($testQName1)"/>
    <xsl:text>"&#xA;</xsl:text>

    <xsl:variable name="testQName2" as="xs:QName"
      select="resolve-QName('something-else', /sonnet)"/>

    <xsl:text>&#xA;  testQName2 = resolve-QName('something-</xsl:text>
    <xsl:text>else', /sonnet)</xsl:text>
    <xsl:text>&#xA;  prefix-from-QName</xsl:text>
    <xsl:text>($testQName2) = "</xsl:text>
    <xsl:value-of select="prefix-from-QName($testQName2)"/>
    <xsl:text>"&#xA;  local-name-from-QName($testQName2) = "</xsl:text>
    <xsl:value-of select="local-name-from-QName($testQName2)"/>
    <xsl:text>"&#xA;  namespace-uri-from-QName($testQName2) = "</xsl:text>
    <xsl:value-of select="namespace-uri-from-QName($testQName2)"/>
    <xsl:text>"</xsl:text>

    <!-- This raises an error; the 'auth' prefix isn't in scope for -->
    <!-- the <sonnet> element. -->
    <!--    <xsl:variable name="testQName3" as="xs:QName"
              select="resolve-QName('auth:new-element', /sonnet)"/> -->
  </xsl:template>

</xsl:stylesheet>
