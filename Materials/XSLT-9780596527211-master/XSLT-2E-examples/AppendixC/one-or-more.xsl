<?xml version="1.0"?>
<!-- one-or-more.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:template match="/">

    <xsl:variable name="testSequence" as="item()*">
      <xsl:sequence 
        select="(3, 4, 5, current-date(), current-time(), 8, 'blue',
                'red', xs:float(3.14), 42, xs:date('1995-04-21'))"/>
    </xsl:variable>

    <xsl:text>&#xA;Here is a test of the one-or-more() </xsl:text>
    <xsl:text>function:&#xA;</xsl:text>

    <xsl:text>&#xA;  Our sequence is:&#xA;&#xA;    </xsl:text>
    <xsl:value-of select="$testSequence" separator="&#xA;    "/>

    <xsl:if test="count(one-or-more($testSequence))">
      <xsl:text>&#xA;&#xA;  Our test sequence has one or </xsl:text>
      <xsl:text>more items!</xsl:text>
    </xsl:if>

  </xsl:template>

</xsl:stylesheet>
