<!-- $Id$ --><xsl:stylesheet xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" version="2.0">
  
  <xsl:template match="t:listBibl">
      <fo:list-block provisional-distance-between-starts="0.55cm" provisional-label-separation="6mm" margin-bottom="6.25pt">
         <xsl:apply-templates/>
      </fo:list-block>
  </xsl:template>


  <xsl:template match="t:listBibl//t:bibl">
      <fo:list-item>
          <fo:list-item-label>
              <fo:block>*</fo:block>
          </fo:list-item-label>
          <fo:list-item-body>
              <fo:block><xsl:apply-templates/></fo:block>
          </fo:list-item-body>
      </fo:list-item>
  </xsl:template>

</xsl:stylesheet>