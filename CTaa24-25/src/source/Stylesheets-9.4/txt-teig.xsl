<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0"
                version="2.0">
  
  <!-- Import templates can be found in teig.xsl -->
  <xsl:import href="teig.xsl"/>

  <xsl:template match="t:g">
      <xsl:param name="parm-leiden-style" tunnel="yes" required="no"></xsl:param>
      <xsl:call-template name="lb-dash"/>
      <xsl:call-template name="w-space"/>

      <xsl:choose>
        <xsl:when test="$parm-leiden-style=('edh-names','edh-itx')"/>
          <xsl:when test="$parm-leiden-style = ('ddbdp','dclp','sammelbuch')">
            <xsl:call-template name="g-ddbdp"/>
         </xsl:when>
          <xsl:when test="$parm-leiden-style = 'dohnicht'">
            <xsl:text>⊂</xsl:text>
            <xsl:apply-imports/>
            <xsl:text>⊃</xsl:text>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text>((</xsl:text>
            <xsl:apply-imports/>
            <xsl:text>))</xsl:text>
         </xsl:otherwise>
      </xsl:choose>
    
      <!-- Found in teig.xsl -->
    <xsl:call-template name="w-space"/>
  </xsl:template>

</xsl:stylesheet>
