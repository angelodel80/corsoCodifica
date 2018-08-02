<?xml version="1.0"?>
<!-- remove1.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:template match="/">

    <xsl:variable name="singleton" as="item()*">
      <xsl:sequence select="(3)"/>
    </xsl:variable>

    <xsl:text>&#xA;Here is a test of the remove() </xsl:text>
    <xsl:text>function:&#xA;</xsl:text>

    <xsl:text>&#xA;  Our sequence ($singleton) </xsl:text>
    <xsl:text>is:&#xA;      </xsl:text>
    <xsl:value-of select="$singleton" separator="&#xA;    "/>
    <xsl:text>&#xA;&#xA;    remove($singleton, 0) = </xsl:text>
    <xsl:value-of select="remove($singleton, 0)" separator="&#xA;    "/>
    <xsl:text>&#xA;&#xA;    remove($singleton, 7) = </xsl:text>
    <xsl:value-of select="remove($singleton, 7)" separator="&#xA;    "/>
    <xsl:text>&#xA;&#xA;    remove($singleton, 1) = </xsl:text>
    <xsl:value-of select="remove($singleton, 1)" separator="&#xA;    "/>
    <xsl:text>&#xA;&#xA;    empty(remove($singleton, 1)) = </xsl:text>
    <xsl:value-of select="empty(remove($singleton, 1))"/>

  </xsl:template>

</xsl:stylesheet>
