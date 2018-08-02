<?xml version="1.0"?>
<!-- insert-before.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:template match="/">

    <xsl:variable name="longSequence" as="item()*">
      <xsl:sequence 
        select="(3, 4, 5, current-date(), current-time(), 8, 'blue')"/>
    </xsl:variable>

    <xsl:variable name="shortSequence" as="item()*"
      select="(current-dateTime(), xs:yearMonthDuration('P3Y8M'))"/>

    <xsl:text>&#xA;Here's a test of the insert-before() </xsl:text>
    <xsl:text>function:&#xA;</xsl:text>

    <xsl:text>&#xA;  Our first sequence ($longSequence) </xsl:text>
    <xsl:text>is:&#xA;      </xsl:text>
    <xsl:value-of select="$longSequence" separator="&#xA;      "/>

    <xsl:text>&#xA;&#xA;  Our second sequence ($shortSequence) </xsl:text>
    <xsl:text>is:&#xA;      </xsl:text>
    <xsl:value-of select="$shortSequence" separator="&#xA;      "/>

    <xsl:text>&#xA;&#xA;    Test 1. insert-before($longSequence, </xsl:text>
    <xsl:text>3, (23)) </xsl:text>
    <xsl:text>= &#xA;      </xsl:text>
    <xsl:value-of select="insert-before($longSequence, 3, (23))" 
      separator="&#xA;      "/>

    <xsl:text>&#xA;&#xA;    Test 2. insert-before($longSequence, </xsl:text>
    <xsl:text>4, $shortSequence) </xsl:text>
    <xsl:text>= &#xA;      </xsl:text>
    <xsl:value-of 
      select="insert-before($longSequence, 4, $shortSequence)" 
      separator="&#xA;      "/>

    <xsl:text>&#xA;&#xA;    Test 3. insert-before($longSequence, </xsl:text>
    <xsl:text>4, $shortSequence) </xsl:text>
    <xsl:text>= &#xA;      </xsl:text>
    <xsl:value-of 
      select="insert-before($longSequence, 4, $shortSequence)" 
      separator="&#xA;      "/>

    <xsl:text>&#xA;&#xA;    Test 4. insert-before($longSequence, 0, </xsl:text>
    <xsl:text>$shortSequence) </xsl:text>
    <xsl:text>= &#xA;      </xsl:text>
    <xsl:value-of select="insert-before($longSequence, 0, $shortSequence)"
      separator="&#xA;      "/>

    <xsl:text>&#xA;&#xA;    Test 5. insert-before($longSequence, 42, </xsl:text>
    <xsl:text>$shortSequence) </xsl:text>
    <xsl:text>= &#xA;      </xsl:text>
    <xsl:value-of select="insert-before($longSequence, 42, $shortSequence)"
      separator="&#xA;      "/>

    <xsl:text>&#xA;&#xA;    Creating a new variable based on </xsl:text>
    <xsl:text>&#xA;        </xsl:text>
    <xsl:text>insert-before($longSequence, 4, $shortSequence): </xsl:text>
    <xsl:text>&#xA;      </xsl:text>
    <xsl:text>updatedSequence = insert-before($longSequence, 4, </xsl:text>
    <xsl:text>$shortSequence) : &#xA;      </xsl:text>
    <xsl:variable name="updatedSequence" as="item()*"
      select="insert-before($longSequence, 4, $shortSequence)"/>
    <xsl:text>&#xA;    Test 6. $updatedSequence = &#xA;      </xsl:text>
    <xsl:value-of select="$updatedSequence" separator="&#xA;      "/>

  </xsl:template>

</xsl:stylesheet>
