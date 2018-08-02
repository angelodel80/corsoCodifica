<?xml version="1.0"?>
<!-- exists.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:template match="/">

    <xsl:text>&#xA;Here is a test of the exists() </xsl:text>
    <xsl:text>function:&#xA;&#xA;  </xsl:text>

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

    <xsl:choose>
      <xsl:when test="exists($emptySequence)">
        <xsl:text>The empty sequence does exist!</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>The empty sequence doesn't exist!</xsl:text>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:text>&#xA;  </xsl:text>
    <xsl:value-of select="if (exists($singleton))
                          then 'The singleton sequence does exist!'
                          else 'The singleton sequence doesn''t exist!'"/>

    <xsl:text>&#xA;  </xsl:text>
    <xsl:value-of select="if (exists($longSequence))
                          then 'The long sequence does exist!'
                          else 'The long sequence doesn''t exist!'"/>
  </xsl:template>

</xsl:stylesheet>
