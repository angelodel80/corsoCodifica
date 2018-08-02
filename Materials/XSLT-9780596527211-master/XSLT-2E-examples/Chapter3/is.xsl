<?xml version="1.0"?>
<!-- is.xsl -->
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
    <xsl:text>A test of the is operator:</xsl:text>
    <xsl:text>&#xA;&#xA;  Comparing the first nodes of </xsl:text>
    <xsl:text>the sequences:&#xA;</xsl:text>

    <xsl:value-of 
      select="if (subsequence($Dougs-favorites, 1, 1) is 
                  subsequence($Sheris-favorites, 1, 1))
              then '    The first nodes are the same!&#xA;'
              else '    The first nodes aren''t the same!&#xA;'"/>
    
    <xsl:text>  Reversing one sequence and trying it </xsl:text>
    <xsl:text>again:&#xA;</xsl:text>

    <xsl:value-of 
      select="if (subsequence($Dougs-favorites, 1, 1) is
                  subsequence(reverse($Sheris-favorites), 1, 1))
              then '    The first nodes are the same!&#xA;'
              else '    The first nodes aren''t the same!&#xA;'"/>
  </xsl:template>

</xsl:stylesheet>
