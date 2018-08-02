<?xml version="1.0"?>
<!-- value-of_sequences.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>

  <xsl:variable name="months" as="xs:string*"
    select="'January', 'February', 'March', 'April', 
            'May', 'June', 'July', 'August', 
            'September', 'October', 'November', 'December'"/>

  <xsl:template match="/">
    <xsl:value-of select="1 to 7" separator=", "/>
    <xsl:text>&#xA;</xsl:text>
    <xsl:value-of select="$months" separator="&#xA;"/>
  </xsl:template>

</xsl:stylesheet>
