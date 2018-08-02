<?xml version="1.0"?>
<!-- for.xsl -->
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>
 
  <xsl:variable name="English-months" as="xs:string*"
    select="('January', 'February', 'March', 'April', 
             'May', 'June', 'July', 'August', 
             'September', 'October', 'November', 
             'December')"/>
  <xsl:variable name="German-months" as="xs:string*"
    select="('Januar', 'Februar', 'M&#xE4;rz', 'April', 
             'Mai', 'Juni', 'Juli', 'August', 
             'September', 'Oktober', 'November', 
             'Dezember')"/>

  <xsl:template match="/">
    <xsl:value-of 
      select="for $m in ($English-months, $German-months) return
                if (starts-with($m, 'J')) 
                  then concat ($m, ' starts with J!&#xA;')
                  else ''"
      separator=""/>
  </xsl:template>

</xsl:stylesheet>
