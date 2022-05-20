<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" 
    xmlns="http://www.w3.org/1999/xhtml" 
    xmlns:html="http://www.w3.org/1999/xhtml" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
    <xsl:output 
      method="text" 
      indent="yes" />

    <xsl:template match="/">
      <xsl:apply-templates select="test/msg" />
    </xsl:template>

    <xsl:template match="text()">
      <xsl:text>TEST: </xsl:text>
      <xsl:copy-of select="." />
    </xsl:template>

</xsl:stylesheet>