<?xml version="1.0"?>
<!-- perform-sort7.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:variable name="vendorsInOrder" as="xs:string*">
    <xsl:perform-sort>
      <xsl:sort select="." 
        data-type="number" order="descending"/>
      <xsl:sequence select="/report/brand/units"/>
      <xsl:sequence select="('3829', '28852', '18831')"/>
    </xsl:perform-sort>
  </xsl:variable>

  <xsl:template match="/">
    <xsl:text>Here are our sales figures:&#xA;&#xA;</xsl:text>
    <xsl:value-of select="$vendorsInOrder" separator="&#xA;"/> 
  </xsl:template>

</xsl:stylesheet>
