<?xml version="1.0"?>
<!-- id-schema-no-ns.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Here is a test of the id() </xsl:text>
    <xsl:text>function in reverse:&#xA;</xsl:text>

    <xsl:for-each select="/parts-list/part">
      <xsl:text>&#xA;  </xsl:text>
      <xsl:value-of select="name"/>
      <xsl:text> (part #</xsl:text>
      <xsl:value-of select="@part-id"/>
      <xsl:text>) is used in these products:&#xA;    </xsl:text>
      <xsl:for-each 
        select="/parts-list/component
                [partref/@refid=current()/@part-id]">
        <xsl:value-of select="name"/>
        <xsl:if test="position() != last()">
          <xsl:text>&#xA;    </xsl:text>
        </xsl:if>
      </xsl:for-each>
      <xsl:text>&#xA;</xsl:text>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
