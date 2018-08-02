<?xml version="1.0"?>
<!-- some-every.xsl -->
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>
 
  <xsl:variable name="English-months" as="xs:string*"
    select="('January', 'February', 'March', 'April', 
             'May', 'June', 'July', 'August', 
             'September', 'October', 'November', 
             'December')"/>

  <xsl:template match="/">
    <xsl:text>&#xA;An example of the XPath 2.0 every and </xsl:text>
    <xsl:text>some operators:&#xA;&#xA;</xsl:text>
    <xsl:text>  If ANY month name has a string-length() </xsl:text>
    <xsl:text>&#xA;    greater than 4, print 'Yes,' otherwise</xsl:text>
    <xsl:text>&#xA;    print 'No'&#xA;&#xA;         </xsl:text>

    <xsl:value-of 
      select="if (some $m in $English-months satisfies 
              (string-length($m) &gt; 4)) then 'Yes' else 'No'"/>

    <xsl:text>&#xA;</xsl:text>
    <xsl:text>&#xA;&#xA;  If EVERY month name has a string-</xsl:text>
    <xsl:text>length() &#xA;    greater than 4, print 'Yes,' </xsl:text>
    <xsl:text>otherwise&#xA;    print 'No'&#xA;&#xA;         </xsl:text>

    <xsl:value-of 
      select="if (every $m in $English-months satisfies 
              (string-length($m) &gt; 4)) then 'Yes' else 'No'"/>

    <xsl:text>&#xA;</xsl:text>
  </xsl:template>

</xsl:stylesheet>
