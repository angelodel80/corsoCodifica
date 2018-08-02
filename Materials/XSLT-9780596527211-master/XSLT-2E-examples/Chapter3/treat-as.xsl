<?xml version="1.0"?>
<!-- treat-as.xsl -->
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>
 
  <xsl:variable name="numbers" as="xs:integer*">
    <xsl:sequence select="/numbers/number"/>
  </xsl:variable>

  <xsl:template match="/">
    <xsl:variable name="number" as="xs:integer"
      select="$numbers treat as xs:integer"/>

    <xsl:text>&#xA;An example of the XPath 2.0 treat as </xsl:text>
    <xsl:text>operator:&#xA;&#xA;</xsl:text>
    <xsl:text>  Treat a sequence of integers as a single integer:</xsl:text>
    <xsl:text>&#xA;         </xsl:text>

    <xsl:value-of select="$number"/>
  </xsl:template>

</xsl:stylesheet>
