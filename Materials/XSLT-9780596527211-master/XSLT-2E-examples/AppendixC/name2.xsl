<?xml version="1.0"?>
<!-- name2.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.oreilly.com/xslt"
  xmlns:auth="http://www.authors.com/">
  
  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Tests of the name() function:&#xA;</xsl:text>

    <xsl:variable name="authorDetails" as="element()*" 
      select="/sonnet/auth:author/*"/>
    <xsl:for-each select="$authorDetails">
      <xsl:text>&#xA;  Element </xsl:text>
      <xsl:value-of select="position()"/>
      <xsl:text>: </xsl:text>
      <xsl:value-of select="name()"/>
    </xsl:for-each> 
  </xsl:template>

</xsl:stylesheet>
