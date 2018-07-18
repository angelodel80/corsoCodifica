<?xml version="1.0"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:math="http://www.example.com/math"
                xmlns:private-math="http://www.example.com/math/private"
                exclude-result-prefixes="xs math private-math">

<xsl:template match="/">
  <xsl:sequence select="math:power(2, 8)" />
</xsl:template>

<xsl:function name="math:power" as="xs:double">
  <xsl:param name="number" as="xs:double" />
  <xsl:param name="power" as="xs:integer" />
  <xsl:sequence select="private-math:power($number, $power, 1)" />
</xsl:function>

<xsl:function name="private-math:power" as="xs:double">
  <xsl:param name="number" as="xs:double" />
  <xsl:param name="power" as="xs:integer" />
  <xsl:param name="result" as="xs:double" />
  <xsl:sequence 
    select="if ($power = 0) then $result
            else private-math:power($number, $power - 1, $result * $number)" />
</xsl:function>

</xsl:stylesheet>