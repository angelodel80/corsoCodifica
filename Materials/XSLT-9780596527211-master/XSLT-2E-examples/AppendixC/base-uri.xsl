<?xml version="1.0"?>
<!-- base-uri.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Tests of the base-uri() function:</xsl:text>

    <xsl:text>&#xA;&#xA;  The base URI for the </xsl:text>
    <xsl:text>document root is:&#xA;    </xsl:text>
    <xsl:value-of select="base-uri()"/>

    <xsl:text>&#xA;&#xA;  The base URI for the </xsl:text>
    <xsl:text>&lt;cars&gt; element is:&#xA;    </xsl:text>
    <xsl:value-of select="base-uri(cars)"/>

    <xsl:for-each select="/cars/manufacturer">
      <xsl:text>&#xA;&#xA;  The base URI for the </xsl:text>
      <xsl:text>manufacturer named </xsl:text>
      <xsl:value-of select="@name"/>
      <xsl:text>: &#xA;    </xsl:text>
      <xsl:value-of select="base-uri()"/>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
