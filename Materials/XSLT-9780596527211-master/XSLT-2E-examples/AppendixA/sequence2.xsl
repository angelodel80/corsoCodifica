<?xml version="1.0" encoding="utf-8"?>
<!-- sequence2.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">
  
  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:variable name="sales" as="xs:integer*">
      <xsl:for-each select="/report/brand/units">
        <xsl:if test=". > 10000">
          <xsl:sequence select="."/>
        </xsl:if>
      </xsl:for-each>
      <xsl:sequence select="(80000, 75000, 65000)"/>
    </xsl:variable>

    <xsl:value-of select="/report/title"/>
    <xsl:text>&#xA;&#xA;Sales figures:  </xsl:text>
    <xsl:value-of select="$sales" separator=", "/>
    <xsl:text>&#xA;&#xA;Sequence total:   &#x9;</xsl:text>
    <xsl:value-of select="format-number(sum($sales), '$#,###.00')"/>
    <xsl:text>&#xA;Sequence average:&#x9;</xsl:text>
    <xsl:value-of select="format-number(avg($sales), '$#,###.00')"/>
  </xsl:template>

</xsl:stylesheet>
