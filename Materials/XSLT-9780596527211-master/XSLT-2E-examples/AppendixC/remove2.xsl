<?xml version="1.0"?>
<!-- remove2.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:template match="/">

    <xsl:variable name="longSequence" as="item()*">
      <xsl:sequence 
        select="(3, 4, 5, current-date(), current-time(), 8, 'blue',
                'red', xs:float(3.14), 42, xs:date('1995-04-21'))"/>
    </xsl:variable>

    <xsl:text>&#xA;Here's another test of the remove() </xsl:text>
    <xsl:text>function:&#xA;</xsl:text>

    <xsl:text>&#xA;  Our sequence ($longSequence) </xsl:text>
    <xsl:text>is:&#xA;      </xsl:text>
    <xsl:value-of select="$longSequence" separator="&#xA;      "/>
    <xsl:text>&#xA;&#xA;    Test 1. remove($longSequence, 1) </xsl:text>
    <xsl:text>= &#xA;      </xsl:text>
    <xsl:value-of select="remove($longSequence, 1)" 
      separator="&#xA;      "/>
    <xsl:text>&#xA;&#xA;    Test 2. remove($longSequence, 1) =</xsl:text>
    <xsl:text>&#xA;        [We're running this test again to show the </xsl:text>
    <xsl:text>variable didn't change]&#xA;      </xsl:text>
    <xsl:value-of select="remove($longSequence, 1)" 
      separator="&#xA;      "/>
    <xsl:text>&#xA;&#xA;    Test 3. remove(remove($longSequence, 7), 1) </xsl:text>
    <xsl:text>= &#xA;      </xsl:text>
    <xsl:value-of select="remove(remove($longSequence, 7), 1)" 
      separator="&#xA;      "/>

    <xsl:text>&#xA;&#xA;    Creating a new variable based on </xsl:text>
    <xsl:text>remove($longSequence, 1): &#xA;      </xsl:text>
    <xsl:text>updatedSequence = remove($longSequence, 1): &#xA;      </xsl:text>
    <xsl:variable name="updatedSequence" as="item()*"
      select="remove($longSequence, 1)"/>
    <xsl:text>&#xA;    Test 4. $updatedSequence = &#xA;      </xsl:text>
    <xsl:value-of select="$updatedSequence" separator="&#xA;      "/>

  </xsl:template>

</xsl:stylesheet>
