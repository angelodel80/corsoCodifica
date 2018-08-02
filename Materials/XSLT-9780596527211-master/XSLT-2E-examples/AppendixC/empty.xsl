<?xml version="1.0"?>
<!-- empty.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:template match="/">

    <xsl:variable name="emptySequence" as="item()*">
      <xsl:sequence select="()"/>
    </xsl:variable>

    <xsl:variable name="singleton" as="item()*">
      <xsl:sequence select="(3)"/>
    </xsl:variable>

    <xsl:variable name="longSequence" as="item()*">
      <xsl:sequence 
        select="(3, 4, 5, current-date(), current-time(), 8, 'blue',
                'red', xs:float(3.14), 42, xs:date('1995-04-21'))"/>
    </xsl:variable>

    <xsl:text>&#xA;Here are some tests of the empty() </xsl:text>
    <xsl:text>function:&#xA;</xsl:text>

    <xsl:text>&#xA;  Our first sequence is:&#xA;    </xsl:text>
    <xsl:value-of select="$emptySequence" separator="&#xA;    "/>
    <xsl:text>&#xA;&#xA;</xsl:text>
    <xsl:value-of select="if (empty($emptySequence)) 
                          then 'This is the empty sequence!'
                          else 'This is not the empty sequence!'"/>
    <xsl:text>&#xA;&#xA;</xsl:text>

    <xsl:text>&#xA;  Our next sequence is:&#xA;    </xsl:text>
    <xsl:value-of select="$singleton" separator="&#xA;    "/>
    <xsl:text>&#xA;&#xA;</xsl:text>
    <xsl:value-of select="if (empty($singleton)) 
                          then 'This is the empty sequence!'
                          else 'This is not the empty sequence!'"/>
    <xsl:text>&#xA;&#xA;</xsl:text>

    <xsl:text>&#xA;  Our final sequence is:&#xA;    </xsl:text>
    <xsl:value-of select="$longSequence" separator="&#xA;    "/>
    <xsl:text>&#xA;&#xA;</xsl:text>
    <xsl:value-of select="if (empty($longSequence)) 
                          then 'This is the empty sequence!'
                          else 'This is not the empty sequence!'"/>
    <xsl:text>&#xA;&#xA;</xsl:text>

  </xsl:template>

</xsl:stylesheet>
