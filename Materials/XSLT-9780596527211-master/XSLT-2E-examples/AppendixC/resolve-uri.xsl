<?xml version="1.0"?>
<!-- resolve-uri.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Tests of the resolve-uri() function:</xsl:text>

    <xsl:text>&#xA;&#xA;  The static base URI for the </xsl:text>
    <xsl:text>document root is:&#xA;    </xsl:text>
    <xsl:value-of select="static-base-uri()"/>

    <xsl:text>&#xA;&#xA;  The base URI for the </xsl:text>
    <xsl:text>document root is:&#xA;    </xsl:text>
    <xsl:value-of select="base-uri()"/>

    <xsl:text>&#xA;&#xA;  resolve-uri('doug.html') = </xsl:text>
    <xsl:text>&#xA;    </xsl:text>
    <xsl:value-of select="resolve-uri('doug.html')"/>

    <xsl:text>&#xA;&#xA;  resolve-uri('doug.html', </xsl:text>
    <xsl:text>'http://www.oreilly.com/') = </xsl:text>
    <xsl:text>&#xA;    </xsl:text>
    <xsl:value-of 
      select="resolve-uri('doug.html', 'http://www.oreilly.com/')"/>

  </xsl:template>

</xsl:stylesheet>
