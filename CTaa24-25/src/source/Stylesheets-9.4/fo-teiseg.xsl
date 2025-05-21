<!-- $Id$ --><xsl:stylesheet xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" version="2.0">
  <!-- General template in teiseg.xsl -->
  <xsl:import href="teiseg.xsl"/>
  
  <xsl:template match="t:seg">
      <xsl:choose>
         <xsl:when test="@type='observed' and @subtype='autopsy'">
            <fo:inline>
               <xsl:apply-imports/>
            </fo:inline>
         </xsl:when>
         <xsl:otherwise>
            <xsl:apply-imports/>
         </xsl:otherwise>
      </xsl:choose>
  </xsl:template>
  
</xsl:stylesheet>