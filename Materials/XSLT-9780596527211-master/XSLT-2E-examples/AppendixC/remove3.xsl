<?xml version="1.0"?>
<!-- remove3.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:template match="/">

    <xsl:variable name="emptySequence" as="item()*">
      <xsl:sequence select="()"/>
    </xsl:variable>

    <xsl:text>&#xA;Here's a final test of the remove() </xsl:text>
    <xsl:text>function:&#xA;</xsl:text>

    <xsl:text>&#xA;  Our sequence ($emptySequence) is </xsl:text>
    <xsl:text>empty:&#xA;      empty($emptySequence) = </xsl:text>
    <xsl:value-of select="empty($emptySequence)"/>
    <xsl:text>&#xA;&#xA;      remove($emptySequence, 1) = </xsl:text>
    <xsl:value-of select="remove($emptySequence, 1)"/>
    <xsl:text>&#xA;&#xA;      empty(remove($emptySequence, 1)) </xsl:text>
    <xsl:text>= </xsl:text>
    <xsl:value-of select="empty(remove($emptySequence, 1))"/>

  </xsl:template>

</xsl:stylesheet>
