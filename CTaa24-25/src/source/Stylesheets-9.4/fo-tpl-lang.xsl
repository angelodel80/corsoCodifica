<!-- $Id$ --><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="t" version="2.0">
  <!-- Contains all language related named templates -->  
  
  <xsl:template name="attr-lang">
      <xsl:if test="ancestor-or-self::t:*[@xml:lang]">
         <xsl:attribute name="xml:lang">
            <xsl:value-of select="ancestor-or-self::t:*[@xml:lang][1]/@xml:lang"/>
         </xsl:attribute>
      </xsl:if>
  </xsl:template>
  
</xsl:stylesheet>