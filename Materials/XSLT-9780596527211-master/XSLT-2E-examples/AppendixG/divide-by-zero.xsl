<?xml version="1.0"?>
<!-- divide-by-zero.xsl -->
<xsl:stylesheet version="2.0" 
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Division by zero in XSLT 2.0:&#xA;&#xA;</xsl:text>

    <xsl:text>&lt;xsl:value-of select="1 div 0"/&gt;&#xA;</xsl:text>
    <xsl:text>  [fatal error]&#xA;&#xA;</xsl:text>
    <xsl:text>&lt;xsl:value-of select="1.0 div 0.0"/&gt;&#xA;</xsl:text>
    <xsl:text>  [fatal error]&#xA;&#xA;</xsl:text>
    <xsl:text>&lt;xsl:value-of select="xs:integer(1) </xsl:text>
    <xsl:text>div xs:integer(0)"/&gt;&#xA;</xsl:text>
    <xsl:text>  [fatal error]&#xA;&#xA;</xsl:text>
    <xsl:text>&lt;xsl:value-of select="xs:decimal(1.0) </xsl:text>
    <xsl:text>div xs:decimal(0.0)"/&gt;&#xA;</xsl:text>
    <xsl:text>  [fatal error]&#xA;&#xA;</xsl:text>
    <xsl:text>&lt;xsl:value-of select="xs:double(1.0) </xsl:text>
    <xsl:text>div xs:double(0.0)"/&gt;&#xA;  </xsl:text>
    <xsl:value-of 
      select="(xs:double(1.0) div xs:double(0.0), '&#xA;&#xA;')"/>
    <xsl:text>&lt;xsl:value-of select="xs:float(1.0) </xsl:text>
    <xsl:text>div xs:float(0.0)"/&gt;&#xA;  </xsl:text>
    <xsl:value-of 
      select="(xs:float(1.0) div xs:float(0.0), '&#xA;&#xA;')"/>

    <xsl:text>Dividing durations by zero:&#xA;&#xA;</xsl:text>
    <xsl:text>&lt;xsl:value-of select="xs:yearMonthDuration</xsl:text>
    <xsl:text>('P3Y4M') div xs:double(0.0)"/&gt;&#xA; </xsl:text>
    <xsl:text>  [fatal error]&#xA;&#xA;</xsl:text>
    <xsl:text>&lt;xsl:value-of select="xs:yearMonthDuration</xsl:text>
    <xsl:text>('P3Y4M') div &#xA;                      </xsl:text>
    <xsl:text>xs:yearMonthDuration('P0Y0M')"/&gt;&#xA; </xsl:text>
    <xsl:text>  [fatal error]&#xA;&#xA;</xsl:text>
    <xsl:text>&lt;xsl:value-of select="xs:dayTimeDuration</xsl:text>
    <xsl:text>('P3DT8H') div xs:double(0.0)"/&gt;&#xA; </xsl:text>
    <xsl:text>  [fatal error]&#xA;&#xA;</xsl:text>
    <xsl:text>&lt;xsl:value-of select="xs:dayTimeDuration</xsl:text>
    <xsl:text>('P3DT8H') div &#xA;                      </xsl:text>
    <xsl:text>xs:dayTimeDuration('P0DT0H')"/&gt;&#xA; </xsl:text>
    <xsl:text>  [fatal error]&#xA;&#xA;</xsl:text>
  </xsl:template>

</xsl:stylesheet>
