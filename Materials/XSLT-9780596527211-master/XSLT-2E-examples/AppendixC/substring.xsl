<?xml version="1.0"?>
<!-- substring.xsl -->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Tests of the substring() function:</xsl:text>

    <xsl:text>&#xA;&#xA;  1. substring('Now is the time', 4)     = "</xsl:text>
    <xsl:value-of select="substring('Now is the time', 4)"/>
    <xsl:text>"&#xA;</xsl:text>
    <xsl:text>  2. substring('Now is the time', 4, 6)  = "</xsl:text>
    <xsl:value-of select="substring('Now is the time', 4, 6)"/>
    <xsl:text>"&#xA;</xsl:text>

    <!-- Xalan chokes on this example, Saxon and MSXSL don't. -->
    <xsl:text>  3. substring('Now is the time', 8, -6) = "</xsl:text>
    <xsl:value-of select="substring('Now is the time', 8, -6)"/>
    <xsl:text>"&#xA;</xsl:text>
    <xsl:text>  4. substring('Now is the time', -3, 6) = "</xsl:text>
    <xsl:value-of select="substring('Now is the time', -3, 6)"/>
    <xsl:text>"&#xA;</xsl:text>
    <xsl:text>  5. substring('Now is the time', 54, 6) = "</xsl:text>
    <xsl:value-of select="substring('Now is the time', 54, 6)"/>
    <xsl:text>"&#xA;&#xA;</xsl:text>
    <xsl:text>  6. substring('Now is the time', 1.7, 6.4) = "</xsl:text>
    <xsl:value-of select="substring('Now is the time', 1.7, 6.4)"/>
    <xsl:text>"&#xA;</xsl:text>
    <xsl:text>  7. substring('Now is the time', 1.7, 6.5) = "</xsl:text>
    <xsl:value-of select="substring('Now is the time', 1.7, 6.5)"/>
    <xsl:text>"&#xA;&#xA;</xsl:text>
    <xsl:text>  count(document('')//*) = </xsl:text>
    <xsl:value-of select="count(document('')//*)"/>
    <xsl:text>&#xA;&#xA;  8. substring('Here is a really, really, </xsl:text>
    <xsl:text>really long string',</xsl:text>
    <xsl:text>&#xA;     count(document('')//*)) = "</xsl:text>
    <xsl:value-of 
      select="substring('Here is a really, really, really long string', 
              count(document('')//*))"/>
    <xsl:text>"&#xA;</xsl:text>
  </xsl:template>

</xsl:stylesheet>
