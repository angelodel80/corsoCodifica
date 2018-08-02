<?xml version="1.0"?>
<!-- output1.xsl -->
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="xml" indent="yes" encoding="ISO-8859-1"/>

  <xsl:template match="/">
    <catalog>
      <xsl:for-each select="/list/listitem">
        <album>
          <xsl:apply-templates/>
        </album>
      </xsl:for-each>
    </catalog>
  </xsl:template>

</xsl:stylesheet>
