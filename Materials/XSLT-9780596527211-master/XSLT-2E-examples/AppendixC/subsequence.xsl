<?xml version="1.0"?>
<!-- subsequence.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:template match="/">

    <!-- Before we test the data() function, we create a sequence. -->
    <xsl:variable name="testSequence" as="item()*">
      <xsl:sequence select="(3, 4, 5)"/>
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

    <xsl:variable name="emptySequence" as="item()*">
      <xsl:sequence select="()"/>
    </xsl:variable>
    
    <xsl:text>&#xA;Here is a test of the subsequence() </xsl:text>
    <xsl:text>function:&#xA;</xsl:text>

    <xsl:text>&#xA;  Our original sequence is:&#xA;&#xA;    </xsl:text>
    <xsl:value-of select="$testSequence" 
      separator="&#xA;    "/>

    <xsl:text>&#xA;&#xA;  subsequence($testSequence, 8) = </xsl:text>
    <xsl:text>&#xA;    </xsl:text>
    <xsl:value-of select="subsequence($testSequence, 8)"
      separator="&#xA;    "/>

    <xsl:text>&#xA;&#xA;  subsequence($testSequence, 3, 3) = </xsl:text>
    <xsl:text>&#xA;    </xsl:text>
    <xsl:value-of select="subsequence($testSequence, 3, 3)"
      separator="&#xA;    "/>

    <xsl:text>&#xA;&#xA;  subsequence($testSequence, 1, 1) = </xsl:text>
    <xsl:text>&#xA;    </xsl:text>
    <xsl:value-of select="subsequence($testSequence, 1, 1)"
      separator="&#xA;    "/>

    <xsl:text>&#xA;&#xA;  subsequence($testSequence, -1, 3) = </xsl:text>
    <xsl:text>&#xA;    </xsl:text>
    <xsl:value-of select="subsequence($testSequence, -1, 3)"
      separator="&#xA;    "/>

    <xsl:text>&#xA;&#xA;  subsequence($testSequence, 14, 2) = </xsl:text>
    <xsl:text>&#xA;    </xsl:text>
    <xsl:value-of select="subsequence($testSequence, 14, 2)"
      separator="&#xA;    "/>

    <xsl:text>&#xA;&#xA;  subsequence($testSequence, 2.3, 1.7) = </xsl:text>
    <xsl:text>&#xA;    </xsl:text>
    <xsl:value-of select="subsequence($testSequence, 2.3, 1.7)"
      separator="&#xA;    "/>

    <xsl:text>&#xA;&#xA;  subsequence($emptySequence, 1) = </xsl:text>
    <xsl:text>&#xA;    </xsl:text>
    <xsl:value-of select="subsequence($emptySequence, 1)"/>
  </xsl:template>

</xsl:stylesheet>
