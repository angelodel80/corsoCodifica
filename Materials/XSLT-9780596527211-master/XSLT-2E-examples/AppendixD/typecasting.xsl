<?xml version="1.0"?>
<!-- typecasting.xsl -->
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
          <xs:minInclusive value="0"/>
          <xs:maxInclusive value="130"/>
        </xs:restriction>
      </xs:simpleType>
    </xs:schema>
  </xsl:import-schema>

  <xsl:template match="/">
    <xsl:variable name="age" as="age:age-type" 
      select="age:age-type(42)"/>
    <xsl:variable name="age-int" as="xs:integer"
      select="$age cast as xs:integer"/>
    <xsl:variable name="float-age" as="age:age-type"
      select="xs:float(42.0) cast as age:age-type"/>
    <xsl:value-of select="$age, $age-int, $float-age" 
      separator=", "/>
  </xsl:template>
</xsl:stylesheet>
