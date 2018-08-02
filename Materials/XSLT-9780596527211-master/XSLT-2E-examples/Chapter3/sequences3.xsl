<?xml version="1.0"?>
<!-- sequences3.xsl -->
<xsl:stylesheet version="2.0" 
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:variable name="cities" as="item()*">
      <xsl:sequence select="addressbook/address/city"/>
      <xsl:sequence select="('London', 'Adelaide', 'Rome')"/>
      <xsl:sequence select="('Jakarta', 'Sao Paulo', 'Timbuktu')"/>
    </xsl:variable>
    <xsl:text>Our customers live in these cities:&#xA;&#xA;</xsl:text>
    <xsl:for-each select="$cities">
      <xsl:choose>
        <xsl:when test=". instance of element()">
          <xsl:text>        Node: </xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>Atomic value: </xsl:text>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:value-of select="."/>
      <xsl:text>&#xA;</xsl:text>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
