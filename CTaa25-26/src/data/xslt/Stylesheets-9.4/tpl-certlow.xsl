<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" 
                version="2.0">
  <!-- Called by many different elements -->
  
  <xsl:template name="cert-low">
      <xsl:param name="parm-edition-type" tunnel="yes" required="no"></xsl:param>
      <xsl:param name="parm-leiden-style" tunnel="yes" required="no"></xsl:param>
      <xsl:if test="@cert='low' and $parm-edition-type != 'diplomatic'">
          <xsl:if test="not($parm-leiden-style = ('london','panciera','iospe') and local-name() = ('ex','supplied'))">
           <xsl:text>(</xsl:text>
        </xsl:if>
        <xsl:text>?</xsl:text>
          <xsl:if test="not($parm-leiden-style = ('london','panciera','iospe') and local-name() = ('ex','supplied'))">
           <xsl:text>)</xsl:text>
        </xsl:if>
      </xsl:if>
  </xsl:template>
  
</xsl:stylesheet>