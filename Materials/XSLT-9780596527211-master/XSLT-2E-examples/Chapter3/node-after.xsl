<?xml version="1.0"?>
<!-- node-after.xsl -->
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:output method="text"/>
 
  <xsl:variable name="Dougs-favorites" as="node()*">
    <xsl:sequence 
      select="/favorite-books/booklist
              /book[contains(@favorite, 'Doug')]"/>
  </xsl:variable>

  <xsl:template match="/">
    <xsl:text>A test of the node-after (>>) operator:</xsl:text>
    <xsl:text>&#xA;&#xA;  Comparing nodes from </xsl:text>
    <xsl:text>the sequence:&#xA;</xsl:text>

    <xsl:value-of 
      select="if (subsequence($Dougs-favorites, 1, 1) >>
                  subsequence($Dougs-favorites, 2, 1))
              then '    node1 >> node2 = true&#xA;'
              else '    node1 >> node2 = false&#xA;'"/>
    <xsl:value-of 
      select="if (subsequence($Dougs-favorites, 2, 1) >>
                  subsequence($Dougs-favorites, 1, 1))
              then '    node2 >> node1 = true&#xA;'
              else '    node2 >> node1 = false&#xA;'"/>
    <xsl:value-of 
      select="if (subsequence($Dougs-favorites, 1, 1) >>
                  subsequence($Dougs-favorites, 1, 1))
              then '    node1 >> node1 = true&#xA;'
              else '    node1 >> node1 = false&#xA;'"/>
  </xsl:template>

</xsl:stylesheet>
