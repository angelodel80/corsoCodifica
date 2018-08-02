<?xml version="1.0"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:str="http://www.example.com/string"
                exclude-result-prefixes="xs str">
                
<xsl:template match="/">
  <xsl:value-of select="str:characters('')"
                separator=", " />
</xsl:template>

<xsl:function name="str:characters" as="xs:string*">
  <xsl:param name="string" as="xs:string" />
  <xsl:if test="$string">
    <xsl:sequence select="substring($string, 1, 1)" />
    <xsl:variable name="remainder" select="substring($string, 2)" as="xs:string" />
    <xsl:if test="$remainder">
      <xsl:sequence select="str:characters($remainder)" />
    </xsl:if>
  </xsl:if>
</xsl:function>
  
</xsl:stylesheet>