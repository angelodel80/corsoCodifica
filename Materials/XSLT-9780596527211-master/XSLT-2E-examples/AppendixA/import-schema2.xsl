<?xml version="1.0"?>
<!-- import-schema2.xsl -->
<xsl:stylesheet version="2.0" 
  xmlns="http://www.oreilly.com/xslt"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:po="http://www.oreilly.com/xslt"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:import-schema namespace="http://www.oreilly.com/xslt">
    <xs:schema 
      targetNamespace="http://www.oreilly.com/xslt"
      xmlns:xs="http://www.w3.org/2001/XMLSchema">
      
      <xs:element name="purchase-order">
        <xs:complexType>
          <xs:sequence>
            <xs:element ref="date" 
              minOccurs="1" maxOccurs="1"/>
            <xs:element ref="customer"
              minOccurs="1" maxOccurs="1"/>
            <xs:element ref="items"
              minOccurs="1" maxOccurs="1"/>
          </xs:sequence>
          <xs:attribute name="id" type="xs:string"/>
        </xs:complexType>
      </xs:element>
      
      <xs:element name="date">
        <xs:complexType>
          <xs:attribute name="year" type="xs:integer"/>
          <xs:attribute name="month" type="xs:integer"/>
          <xs:attribute name="day" type="xs:integer"/>
        </xs:complexType>
      </xs:element>
      
      <xs:element name="customer">
        <xs:complexType>
          <xs:sequence>
            <xs:element ref="address" minOccurs="1"/>
          </xs:sequence>
          <xs:attribute name="id" type="xs:integer"/>
          <xs:attribute name="level" type="xs:string"/>
        </xs:complexType>
      </xs:element>
      
      <xs:element name="address">
        <xs:complexType>
          <xs:sequence>
            <xs:element ref="name"
              minOccurs="1" maxOccurs="1"/>
            <xs:element ref="street"
              minOccurs="1" maxOccurs="1"/>
            <xs:element ref="city"
              minOccurs="1" maxOccurs="1"/>
            <xs:element ref="state"
              minOccurs="1" maxOccurs="1"/>
            <xs:element ref="zip"
              minOccurs="1" maxOccurs="1"/>
          </xs:sequence>
          <xs:attribute name="type" type="xs:string"/>
        </xs:complexType>
      </xs:element>
      
      <xs:element name="name">
        <xs:complexType>
          <xs:sequence>
            <xs:element ref="title"
              minOccurs="0" maxOccurs="1"/>
            <xs:element ref="first-name"
              minOccurs="1" maxOccurs="1"/>
            <xs:element ref="last-name"
              minOccurs="1" maxOccurs="1"/>
          </xs:sequence>
        </xs:complexType>
      </xs:element>
      
      <xs:element name="title" type="xs:string"/>
      <xs:element name="first-name" type="xs:string"/>
      <xs:element name="last-name" type="xs:string"/>
      
      <xs:element name="street" type="xs:string"/>
      <xs:element name="city" type="xs:string"/>
      <xs:element name="state" type="xs:string"/>
      <xs:element name="zip" type="xs:string"/>
      
      <xs:element name="items">
        <xs:complexType>
          <xs:sequence>
            <xs:element ref="item" minOccurs="1" maxOccurs="unbounded"/>
          </xs:sequence>
        </xs:complexType>
      </xs:element>
      
      <xs:element name="item">
        <xs:complexType>
          <xs:sequence>
            <xs:element ref="partname" 
              minOccurs="1" maxOccurs="1"/>
            <xs:element ref="qty"
              minOccurs="1" maxOccurs="1"/>
            <xs:element ref="price"
              minOccurs="1" maxOccurs="1"/>
          </xs:sequence>
          <xs:attribute name="part-no" type="xs:string"/>
        </xs:complexType>
      </xs:element>
      
      <xs:element name="partname" type="xs:string"/>
      <xs:element name="qty" type="xs:integer"/>
      <xs:element name="price" type="xs:float"/>
      
    </xs:schema>
  </xsl:import-schema>

  <xsl:output method="text"/>

  <xsl:template match="schema-element(po:purchase-order)">
    <xsl:text>&#xA;This is a test of the &lt;xsl:import-</xsl:text>
    <xsl:text>schema&gt; element.&#xA;&#xA;</xsl:text>
    <xsl:text>Here are all the items in this purchase </xsl:text>
    <xsl:text>order:&#xA;</xsl:text>
    <xsl:for-each select="po:items/po:item">
      <xsl:text>  * </xsl:text>
      <xsl:value-of select="po:partname"/>
      <xsl:text>&#xA;</xsl:text>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="*">
    <xsl:message terminate="yes">
      <xsl:text>This is not a valid purchase order!</xsl:text>
    </xsl:message>
  </xsl:template>

</xsl:stylesheet>
