<?xml version="1.0"?>
<!-- copy3.xsl -->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="xml"/>

  <xsl:template match="report">
    <report>
      <xsl:apply-templates select="brand"/>
    </report>
  </xsl:template>

  <xsl:template match="brand|name|units">
    <xsl:copy>
      <xsl:apply-templates/>
    </xsl:copy>    
  </xsl:template>

</xsl:stylesheet>
