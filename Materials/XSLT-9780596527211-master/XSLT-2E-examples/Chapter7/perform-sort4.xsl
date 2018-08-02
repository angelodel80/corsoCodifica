<?xml version="1.0"?>
<!-- perform-sort4.xsl -->
<xsl:stylesheet version="2.0" 
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:variable name="sortedCities" as="xs:string*">
      <xsl:perform-sort>
        <xsl:sort select="."/>
        <xsl:apply-templates select="addressbook/address/city"/>
        <xsl:sequence select="('London', 'Adelaide', 'Rome')"/>
        <xsl:sequence select="('Jakarta', 'Sao Paulo', 'Timbuktu')"/>
      </xsl:perform-sort>
    </xsl:variable>
    <xsl:text>Our customers live in these cities:&#xA;&#xA;</xsl:text>
    <xsl:value-of select="distinct-values($sortedCities)" 
      separator="&#xA;"/>
  </xsl:template>

</xsl:stylesheet>
