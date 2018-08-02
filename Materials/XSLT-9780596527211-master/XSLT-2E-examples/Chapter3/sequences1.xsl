<?xml version="1.0"?>
<!-- sequences1.xsl -->
<xsl:stylesheet version="2.0" 
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">

    <xsl:variable name="months" as="xs:string*">
      <xsl:sequence 
        select="('January', 'February', 'March', 'April', 
                'May', 'June', 'July', 'August', 
                'September', 'October', 'November', 
                'December')"/>
    </xsl:variable>
    <xsl:text>Here are the months of the year:&#xA;&#xA;</xsl:text>
    <xsl:value-of select="$months" separator="&#xA;"/>
  </xsl:template>

</xsl:stylesheet>
