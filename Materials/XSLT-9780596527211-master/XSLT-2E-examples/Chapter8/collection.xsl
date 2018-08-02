<?xml version="1.0"?>
<!-- collection.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;A test of the collection() function:</xsl:text>

    <xsl:variable name="docPile" as="node()*" 
      select="collection('polist.xml')"/>

    <xsl:text>&#xA;&#xA;  The customers in the </xsl:text>
    <xsl:text>collection are: &#xA;    </xsl:text>
    <xsl:for-each select="$docPile/purchase-order/customer">
      <xsl:sort select="address/name/last-name"/>
      <xsl:value-of 
        select="address/name/title, 
                address/name/first-name, 
                address/name/last-name" 
        separator=" "/>
      <xsl:text>    &#xA;    </xsl:text>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
