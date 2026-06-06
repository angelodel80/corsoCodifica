<!-- $Id$ --><xsl:stylesheet xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" version="2.0">

  <xsl:template match="t:p">
      <fo:block>
         <xsl:apply-templates/>
      </fo:block>
  </xsl:template>
  
</xsl:stylesheet>