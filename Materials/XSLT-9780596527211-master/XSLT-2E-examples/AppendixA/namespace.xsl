<?xml version="1.0"?>
<!-- namespace.xsl -->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="xml" indent="yes"/>
 
  <xsl:template match="/">
    <data xsi:type="xs:integer" 
      xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
      <xsl:namespace name="xs" select="'http://www.w3.org/2001/XMLSchema'"/>
      <xsl:text>42</xsl:text>
    </data>
  </xsl:template>

</xsl:stylesheet>
