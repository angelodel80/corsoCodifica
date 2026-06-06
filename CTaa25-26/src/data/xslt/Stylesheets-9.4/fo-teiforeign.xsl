<!-- $Id$ --><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="t" version="2.0">
  
  <xsl:template match="t:foreign">
      <fo:inline>
      <!-- Found in htm-tpl-lang.xsl -->
      <xsl:call-template name="attr-lang"/>
         <xsl:apply-templates/>
      </fo:inline>
  </xsl:template>
  
</xsl:stylesheet>