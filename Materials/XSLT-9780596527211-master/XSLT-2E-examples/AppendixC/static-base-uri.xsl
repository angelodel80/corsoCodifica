<?xml version="1.0"?>
<!-- static-base-uri.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Tests of the static-base-uri() function:</xsl:text>

    <xsl:text>&#xA;&#xA;  The static base URI for the </xsl:text>
    <xsl:text>document root is:&#xA;    </xsl:text>
    <xsl:value-of select="static-base-uri()"/>
    <xsl:text>&#xA;&#xA;</xsl:text>

    <xsl:for-each select="/cars/manufacturer">
      <xsl:text>  The static base URI for manufacturer </xsl:text>
      <xsl:value-of select="@name"/>
      <xsl:text> is: &#xA;    </xsl:text>
      <xsl:value-of select="static-base-uri()"/>
      <xsl:text>&#xA;</xsl:text>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
