<?xml version="1.0"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:math="http://www.example.com/math"
                xmlns:private-math="http://www.example.com/math/private"
                exclude-result-prefixes="xs math private-math">
                
<xsl:template match="/">
  <xsl:value-of select="math:squareRoot(10)" />
</xsl:template>

<xsl:function name="math:squareRoot" as="xs:double">
  <xsl:param name="number" as="xs:double" />
  <xsl:sequence select="math:squareRoot($number, 4)" />
</xsl:function>

<xsl:function name="math:squareRoot" as="xs:double">
  <xsl:param name="number" as="xs:double" />
  <xsl:param name="precision" as="xs:integer" />
  <xsl:sequence select="private-math:squareRoot($number, $precision, 1)" />
</xsl:function>

<xsl:function name="private-math:squareRoot" as="xs:double">
  <xsl:param name="number" as="xs:double" />
  <xsl:param name="precision" as="xs:integer" />
  <xsl:param name="estimate" as="xs:double" />
  <xsl:variable name="nextEstimate" as="xs:double"
    select="$estimate + (($number - $estimate * $estimate) div
                         (2 * $estimate))" />
   <xsl:variable name="roundedEstimate" as="xs:double"
     select="round-half-to-even($nextEstimate, $precision) " />
  <xsl:sequence
     select="if ($estimate = $roundedEstimate) then $estimate
             else private-math:squareRoot($number, $precision, $roundedEstimate)" />
</xsl:function>
  
</xsl:stylesheet>