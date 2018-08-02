<?xml version="1.0"?>
<!-- sequences2.xsl -->
<xsl:stylesheet version="2.0" 
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:variable name="cities" as="xs:string*">
      <xsl:sequence select="addressbook/address/city"/>
      <xsl:sequence select="('London', 'Adelaide', 'Rome')"/>
      <xsl:sequence select="('Jakarta', 'Sao Paulo', 'Timbuktu')"/>
    </xsl:variable>
    <xsl:text>Our customers live in these cities:&#xA;&#xA;</xsl:text>
    <xsl:value-of select="$cities" separator="&#xA;"/>
  </xsl:template>

</xsl:stylesheet>
