<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:tv="http://www.example.com/TVGuide"
                exclude-result-prefixes="xs tv"
                xmlns="http://www.w3.org/1999/xhtml">
  
<xsl:variable name="ChannelList" as="element()+">
  <p><xsl:apply-templates select="$Channels" mode="ChannelList" /></p>
</xsl:variable>
  
<xsl:template match="tv:Channel" mode="ChannelList">
  <xsl:call-template name="link">
    <xsl:with-param name="href" as="xs:anyURI" select="xs:anyURI(concat('#', translate(tv:Name, ' ', '')))" />
    <xsl:with-param name="content" as="xs:string" select="tv:Name" />
  </xsl:call-template>
  <xsl:if test="position() != last()"> | </xsl:if>
</xsl:template>
    
</xsl:stylesheet>