<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:tv="http://www.example.com/TVGuide"
                xmlns:str="http://www.example.com/string"
                exclude-result-prefixes="xs tv str"
                xmlns="http://www.w3.org/1999/xhtml">
  
<xsl:template name="link" as="element()">
  <xsl:param name="href" as="xs:anyURI"  required="yes" />
  <xsl:param name="content" as="item()*" required="yes" />
  <a href="{$href}">
    <xsl:sequence select="$content" />
  </a>
</xsl:template>
  
<xsl:function name="tv:is-interesting-program" as="xs:boolean">
  <xsl:param name="program" as="element()" />
  <xsl:param name="keyword" as="xs:string" />
  <xsl:sequence select="$program/@flag = ('favorite', 'interesting') or 
                        $program/@rating > 6 or
                        (some $n in $program/(tv:Series, tv:Title, tv:Description)
                         satisfies contains(lower-case($n), $keyword))" />
</xsl:function>

<xsl:function name="tv:is-interesting-program" as="xs:boolean">
  <xsl:param name="program" as="element()" />
  <xsl:sequence select="tv:is-interesting-program($program, 'news')" />
</xsl:function>
  
<xsl:function name="str:characters" as="xs:string*">
  <xsl:param name="string" as="xs:string" />
  <xsl:if test="$string">
    <xsl:sequence select="substring($string, 1, 1)" />
    <xsl:variable name="remainder" select="substring($string, 2)" as="xs:string" />
    <xsl:if test="$remainder">
      <xsl:sequence select="str:characters($remainder)" />
    </xsl:if>
  </xsl:if>
</xsl:function>
  
</xsl:stylesheet>