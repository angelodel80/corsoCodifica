<?xml version="1.0"?>
<!-- type-available2.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:age="http://www.oreilly.com/xslt"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:output method="text"/>

  <xsl:import-schema namespace="http://www.oreilly.com/xslt">
    <xs:schema 
      targetNamespace="http://www.oreilly.com/xslt"
      xmlns:xs="http://www.w3.org/2001/XMLSchema">
      <xs:simpleType name="age-type">
        <xs:restriction base="xs:integer">
          <xs:minInclusive value="1"/>
          <xs:maxInclusive value="110"/>
        </xs:restriction>
      </xs:simpleType>
    </xs:schema>
  </xsl:import-schema>

  <xsl:template match="/">
    <xsl:text>&#xA;A test of the type-available() function:&#xA;</xsl:text>
    <xsl:text>&#xA;    xs:integer is available:  </xsl:text>
    <xsl:value-of select="type-available('xs:integer')"/>
    <xsl:text>&#xA;    age:age-type is available:  </xsl:text>
    <xsl:value-of select="type-available('age:age-type')"/>
  </xsl:template>
  
</xsl:stylesheet>
