<?xml version="1.0"?>
<!-- nilled.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:po="http://www.oreilly.com/xslt">
  
  <xsl:output method="text"/>
  <xsl:import-schema namespace="http://www.oreilly.com/xslt"
    schema-location="person.xsd" />  

  <xsl:template match="/">
    <xsl:text>&#xA;A test of the nilled() function:&#xA;</xsl:text>

    <xsl:for-each select="//*">
      <xsl:text>&#xA;    Element &lt;</xsl:text>
      <xsl:value-of select="name()"/>
      <xsl:text>&gt; </xsl:text>
      <xsl:value-of select="if (nilled(.)) 
                            then '===>>> IS nilled!'
                            else 'is not nilled!'"/>
    </xsl:for-each>
  </xsl:template>
  
</xsl:stylesheet>
