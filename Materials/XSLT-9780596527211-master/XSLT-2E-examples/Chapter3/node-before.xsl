<?xml version="1.0"?>
<!-- node-before.xsl -->
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:output method="text"/>
 
  <xsl:variable name="Dougs-favorites" as="node()*">
    <xsl:sequence 
      select="/favorite-books/booklist
              /book[contains(@favorite, 'Doug')]"/>
  </xsl:variable>

  <xsl:template match="/">
    <xsl:text>A test of the node-before (&lt;&lt;) operator:</xsl:text>
    <xsl:text>&#xA;&#xA;  Comparing nodes from </xsl:text>
    <xsl:text>the sequence:&#xA;</xsl:text>

    <xsl:value-of 
      select="if (subsequence($Dougs-favorites, 1, 1) &lt;&lt;
                  subsequence($Dougs-favorites, 2, 1))
              then '    node1 &lt;&lt; node2 = true&#xA;'
              else '    node1 &lt;&lt; node2 = false&#xA;'"/>
    <xsl:value-of 
      select="if (subsequence($Dougs-favorites, 2, 1) &lt;&lt;
                  subsequence($Dougs-favorites, 1, 1))
              then '    node2 &lt;&lt; node1 = true&#xA;'
              else '    node2 &lt;&lt; node1 = false&#xA;'"/>
    <xsl:value-of 
      select="if (subsequence($Dougs-favorites, 1, 1) &lt;&lt;
                  subsequence($Dougs-favorites, 1, 1))
              then '    node1 &lt;&lt; node1 = true&#xA;'
              else '    node1 &lt;&lt; node1 = false&#xA;'"/>
  </xsl:template>

</xsl:stylesheet>
