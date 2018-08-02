<?xml version="1.0"?>
<!-- exactly-one.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">

    <xsl:text>&#xA;Here is a test of the exactly-one() </xsl:text>
    <xsl:text>function:&#xA;</xsl:text>

    <xsl:variable name="singleton" as="item()*">
      <xsl:sequence select="0"/>
    </xsl:variable>

    <xsl:text>&#xA;  Our sequence is:&#xA;&#xA;    </xsl:text>
    <xsl:value-of select="$singleton" separator="&#xA;    "/>

    <xsl:if test="count(exactly-one($singleton))">
      <xsl:text>&#xA;&#xA;  Our test sequence has exactly </xsl:text>
      <xsl:text>one item!&#xA;</xsl:text>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
