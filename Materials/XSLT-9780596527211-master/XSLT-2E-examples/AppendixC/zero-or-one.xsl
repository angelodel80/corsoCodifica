<?xml version="1.0"?>
<!-- zero-or-one.xsl -->
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

    <xsl:text>&#xA;Here are two tests of the zero-or-one() </xsl:text>
    <xsl:text>function:&#xA;</xsl:text>

    <xsl:text>&#xA;  Calling zero-or-one() with the empty </xsl:text>
    <xsl:text>sequence:&#xA;    </xsl:text>

    <xsl:if test="count(zero-or-one($emptySequence) &lt; 2)">
      <xsl:text>&#xA;    Our sequence has zero or one items!</xsl:text>
    </xsl:if>

    <xsl:text>&#xA;&#xA;  Calling zero-or-one() with a </xsl:text>
    <xsl:text>singleton:&#xA;</xsl:text>
    <xsl:text>&#xA;    Our sequence is:&#xA;      </xsl:text>
    <xsl:value-of select="$singleton" separator="&#xA;    "/>

    <xsl:if test="count(zero-or-one($singleton) &lt; 2)">
      <xsl:text>&#xA;&#xA;    Our sequence has zero or one items!</xsl:text>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
