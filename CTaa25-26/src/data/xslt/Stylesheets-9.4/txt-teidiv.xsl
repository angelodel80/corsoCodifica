<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0"
                version="2.0">

  <!-- div[@type = 'edition']" and div[starts-with(@type, 'textpart')] can be found in txt-teidivedition.xsl -->
  
  <xsl:template match="t:div">
      <xsl:text>
&#xD;</xsl:text>
      <xsl:apply-templates/>
  </xsl:template>
  
</xsl:stylesheet>
