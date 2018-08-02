<?xml version="1.0"?>
<!-- trace.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:datatest="http://www.oreilly.com">

  <xsl:output method="text"/>

  <xsl:template match="/">

    <xsl:variable name="testSequence" as="item()*">
      <xsl:sequence select="(3)"/>
      <xsl:element name="currentDate">
        <xsl:value-of select="current-date()"/>
      </xsl:element>
      <xsl:element name="currentTime">
        <xsl:value-of select="current-time()"/>
      </xsl:element>
      <xsl:element name="integerTest">
        <xsl:value-of select="xs:integer(8)"/>
      </xsl:element>
      <xsl:sequence select="('blue', 'red')"/>
      <xsl:element name="floatTest1">
        <xsl:value-of select="xs:float(3.14)"/>
      </xsl:element>
      <xsl:element name="floatTest2">
        <xsl:value-of select="xs:float(42)"/>
      </xsl:element>
      <xsl:element name="dateTest">
        <xsl:value-of select="xs:date('1995-04-21')"/>
      </xsl:element>
    </xsl:variable>

    <xsl:text>&#xA;Here is a test of the </xsl:text>
    <xsl:text>trace() function:&#xA;&#xA;</xsl:text>
    <xsl:value-of select="$testSequence" separator="&#xA;"/>

    <xsl:value-of 
      select="for $i in (1 to count($testSequence))
              return (datatest:print-item(
              subsequence($testSequence, $i, 1)))"/>
  </xsl:template>

  <xsl:function name="datatest:print-item" as="xs:string">
    <xsl:param name="item" as="item()"/>
    <xsl:choose>
      <xsl:when test="$item instance of element()">
        <xsl:analyze-string regex="!!!.?"
          select="string(trace($item, 'trace()  element '))">
          <xsl:matching-substring></xsl:matching-substring>
        </xsl:analyze-string>
      </xsl:when>
      <xsl:otherwise>
        <xsl:analyze-string regex="!!!.?"
          select="string(trace($item, 'trace()  atom '))">
          <xsl:matching-substring></xsl:matching-substring>
        </xsl:analyze-string>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text> </xsl:text>
  </xsl:function>

</xsl:stylesheet>
