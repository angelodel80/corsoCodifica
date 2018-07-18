<?xml version="1.0"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:math="http://www.example.com/math"
                xmlns:private-math="http://www.example.com/math/private"
                exclude-result-prefixes="xs math private-math">
  
<xsl:template match="/">
  <xsl:sequence select="math:product(2 to 4)" />
</xsl:template>

<xsl:function name="math:product" as="xs:double">
  <xsl:param name="numbers" as="xs:double*" />
  <xsl:sequence select="if (exists($numbers)) 
                        then private-math:product($numbers, 1)
                        else ()" />
</xsl:function>
  
<xsl:function name="private-math:product" as="xs:double">
  <xsl:param name="numbers" as="xs:double*" />
  <xsl:param name="product" as="xs:double" />
  <xsl:sequence 
    select="if (exists($numbers)) 
            then private-math:product($numbers[position() > 1], 
                                      $product * $numbers[1])
            else $product" />
</xsl:function>
  
</xsl:stylesheet>