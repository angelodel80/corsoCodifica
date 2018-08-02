<?xml version="1.0" encoding="utf-8"?>
<!-- attribute3.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:zip="http://www.oreilly.com/xslt/zip"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  exclude-result-prefixes="xs">

  <xsl:output method="xml" indent="yes"/>

  <xsl:import-schema namespace="http://www.oreilly.com/xslt/zip">
    <xsd:schema 
      xmlns="http://www.oreilly.com/xslt/zip"
      targetNamespace="http://www.oreilly.com/xslt/zip"
      xmlns:xsd="http://www.w3.org/2001/XMLSchema">
      
      <xsd:simpleType name="zipcode">
        <xsd:restriction base="xsd:string">
          <xsd:pattern value="[0-9]{5}(-[0-9]{4})?"/>
        </xsd:restriction>
      </xsd:simpleType>
    </xsd:schema>
  </xsl:import-schema>

  <xsl:template match="/">
    <postcodes>
      <xsl:for-each select="postcodes/postcode">
        <postcode>
          <xsl:choose>
            <xsl:when test=". castable as zip:zipcode">
              <xsl:attribute name="zip:zip" type="zip:zipcode">
                <xsl:value-of select=". cast as zip:zipcode"/>
              </xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
              <xsl:attribute name="other" type="xs:string">
                <xsl:value-of select="."/>
              </xsl:attribute>
            </xsl:otherwise>
          </xsl:choose>
        </postcode>
      </xsl:for-each>
    </postcodes>
  </xsl:template>

</xsl:stylesheet>
