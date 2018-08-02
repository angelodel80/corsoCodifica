<?xml version="1.0"?>
<!-- data2.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:datatest="http://www.oreilly.com">

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
    
    <xsl:text>&#xA;Here is a test of the data() function:&#xA;</xsl:text>

    <xsl:text>&#xA;  Our test sequence is:&#xA;&#xA;    </xsl:text>
    <xsl:for-each select="$testSequence">
      <xsl:value-of 
        select="if (. instance of node())
                then concat('Element:         &lt;', name(.), 
                            '&gt;', ., '&lt;/', name(.), '&gt;')
                else concat('Atomic value:    ', .)"/>
      <xsl:text>&#xA;    </xsl:text>
    </xsl:for-each>

    <xsl:text>&#xA;&#xA;  Passing our sequence to data() </xsl:text>
    <xsl:text>gives us:&#xA;&#xA;    </xsl:text>

    <xsl:variable name="atomicSequence" as="item()*"
      select="data($testSequence)"/>
    <xsl:for-each select="$atomicSequence">
      <xsl:value-of 
        select="if (. instance of item())
                then concat('Atomic value:    ', .)
                else concat('Element:         &lt;', name(.), 
                            '&gt;', ., '&lt;/', name(.), '&gt;')"/>
      <xsl:text>&#xA;    </xsl:text>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
