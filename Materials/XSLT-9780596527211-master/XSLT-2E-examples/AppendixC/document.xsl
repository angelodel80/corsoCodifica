<?xml version="1.0"?>
<!-- document.xsl -->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;A test of the document() function:&#xA;</xsl:text>

    <xsl:for-each select="/collection/doc">
      <xsl:variable name="latestDoc" select="document(@href)"/>
      <xsl:if 
        test="count($latestDoc/purchase-order/items/item) &gt; 1">
        <xsl:text>&#xA;  </xsl:text>
        <xsl:value-of 
          select="$latestDoc/purchase-order/customer/
                  address/name/first-name"/>
        <xsl:text> </xsl:text>
        <xsl:value-of 
          select="$latestDoc/purchase-order/customer/
                  address/name/last-name"/>
        <xsl:text>&#xA;    ordered </xsl:text>
        <xsl:value-of 
          select="count($latestDoc/purchase-order/items/item)"/>
        <xsl:text> items on </xsl:text>
        <xsl:value-of 
          select="$latestDoc/purchase-order/date/@month"/>
        <xsl:text>/</xsl:text>
        <xsl:value-of 
          select="$latestDoc/purchase-order/date/@day"/>
        <xsl:text>/</xsl:text>
        <xsl:value-of 
          select="$latestDoc/purchase-order/date/@year"/>
        <xsl:text> - see P.O. #</xsl:text>
        <xsl:value-of 
          select="$latestDoc/purchase-order/@id"/>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
