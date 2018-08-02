<?xml version="1.0"?>
<!-- except.xsl -->
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:output method="text"/>
 
  <xsl:variable name="Dougs-favorites" as="node()*">
    <xsl:sequence 
      select="/favorite-books/booklist
              /book[contains(@favorite, 'Doug')]"/>
  </xsl:variable>

  <xsl:variable name="Sheris-favorites" as="node()*">
    <xsl:sequence 
      select="/favorite-books/booklist
              /book[contains(@favorite, 'Sheri')]"/>
  </xsl:variable>

  <xsl:template match="/">
    <xsl:text>&#xA;Books Doug likes but Sheri doesn't:</xsl:text>
    <xsl:text>&#xA;&#xA;  </xsl:text>

    <xsl:for-each select="$Dougs-favorites except $Sheris-favorites">
      <xsl:sort select="."/>
      <xsl:value-of select="."/>
      <xsl:text>&#xA;  </xsl:text>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
