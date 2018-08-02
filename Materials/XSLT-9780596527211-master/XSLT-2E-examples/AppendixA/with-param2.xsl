<?xml version="1.0"?>
<!-- with-param2.xsl -->
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:zip="http://www.oreilly.com/xslt/zip"
  xmlns="http://www.oreilly.com/xslt/zip"
  xmlns:po="http://www.oreilly.com/xslt">

  <xsl:import-schema namespace="http://www.oreilly.com/xslt/zip"
    schema-location="zip.xsd" />  

  <xsl:import-schema namespace="http://www.oreilly.com/xslt"
    schema-location="po.xsd" />  

  <xsl:output method="text"/>
  
  <xsl:template match="/">
    <xsl:choose>
      <xsl:when 
        test="/po:purchase-order/po:customer/po:address/po:zip 
              castable as zip:zipcode">
        <xsl:call-template name="postalCode">
          <xsl:with-param name="zip" as="zip:zipcode"
            select="/po:purchase-order/po:customer/po:address/po:zip"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>The &lt;zip&gt; element isn't valid!&#xA;</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="postalCode">
    <xsl:param name="zip" as="zip:zipcode"/>
    <xsl:text>The value </xsl:text>
    <xsl:value-of select="$zip"/>
    <xsl:text> is a valid Zip code!&#xA;</xsl:text>
  </xsl:template>

</xsl:stylesheet>
