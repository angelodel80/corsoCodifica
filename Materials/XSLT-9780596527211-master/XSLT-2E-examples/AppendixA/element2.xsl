<?xml version="1.0"?>
<!-- element2.xsl -->
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns="http://www.oreilly.com/xslt"
  xmlns:po="http://www.oreilly.com/xslt"
  exclude-result-prefixes="xs po">

  <xsl:import-schema namespace="http://www.oreilly.com/xslt"
    schema-location="po.xsd" />  

  <xsl:output method="xml" indent="yes"/>

  <xsl:variable name="now" as="xs:date" select="current-date()"/>

  <xsl:template match="po">
    <xsl:element name="purchase-order" validation="strict">
      <xsl:attribute name="id" select="@order-num"/>
      <date>
        <xsl:attribute name="year" select="year-from-date($now)"/>
        <xsl:attribute name="month" select="month-from-date($now)"/>
        <xsl:attribute name="day" select="day-from-date($now)"/>
      </date>
      <customer>
        <xsl:attribute name="id" select="customer/@id"/>
        <xsl:attribute name="level" select="customer/@standing"/>
        <xsl:apply-templates select="customer/address"/>
      </customer>
      <xsl:apply-templates select="line-items"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="address">
    <address>
      <xsl:attribute name="type" select="'business'"/>
      <xsl:apply-templates select="name"/>
      <street>
        <xsl:value-of select="street"/>
      </street>
      <city>
        <xsl:value-of select="city"/>
      </city>
      <state>
        <xsl:value-of select="state"/>
      </state>
      <zip>
        <xsl:value-of select="zip"/>
      </zip>
    </address>
  </xsl:template>

  <xsl:template match="line-items">
    <items>
      <xsl:for-each select="line-item">
        <item>
          <xsl:attribute name="part-no" select="partnum"/>
          <partname>
            <xsl:value-of select="partname"/>
          </partname>
          <qty>
            <xsl:value-of select="quantity"/>
          </qty>
          <price>
            <xsl:value-of select="price"/>
          </price>
        </item>
      </xsl:for-each>
    </items>
  </xsl:template>

  <xsl:template match="name">
    <name>
      <xsl:if test="courtesy">
        <title>
          <xsl:value-of select="courtesy"/>
        </title>
      </xsl:if>
      <first-name>
        <xsl:value-of select="given-name"/>
      </first-name>
      <last-name>
        <xsl:value-of select="surname"/>
      </last-name>
    </name>
  </xsl:template>

</xsl:stylesheet>
