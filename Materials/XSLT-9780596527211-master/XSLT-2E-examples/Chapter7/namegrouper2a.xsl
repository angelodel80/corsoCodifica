<?xml version="1.0"?>
<!-- namegrouper2a.xsl -->
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="xml" indent="no"/>

  <xsl:strip-space elements="*"/>

  <xsl:template match="/">
    <addressbook>
      <xsl:for-each select="addressbook/address">
        <xsl:sort select="zip"/>
        <xsl:copy-of select="."/>
      </xsl:for-each>
    </addressbook>
  </xsl:template>
</xsl:stylesheet>
