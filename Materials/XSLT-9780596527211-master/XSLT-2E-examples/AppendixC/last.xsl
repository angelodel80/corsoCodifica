<?xml version="1.0"?>
<!-- last.xsl -->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;A test of the last() function:&#xA;</xsl:text>
    <xsl:for-each select="list/listitem">
      <xsl:text>&#xA;  </xsl:text>
      <xsl:if test="position()=last()">
        <xsl:text>&#xA;  LAST, but not least:  </xsl:text>
      </xsl:if>
      <xsl:value-of select="."/>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
