<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:xm="http://xm.net/2007/xsl/function" version="2.0">

   <xsl:function name="xm:getentry-by-id">
      <xsl:param name="id" as="xs:string"/>
      <xsl:param name="scheme" as="xs:string"/>
      <xsl:variable name="linklist"
         select="document(concat('../reslist_',$scheme,'.xml'))"/>
      <xsl:variable name="linkmeta" select="$linklist//entry[@xml:id=$id]"/>
      <xsl:sequence select="$linkmeta"/>
   </xsl:function>
  
   <xsl:function name="xm:getterm-by-id">
      <xsl:param name="id" as="xs:string"/>
      <xsl:param name="scheme" as="xs:string"/>
      <xsl:variable name="termlist"
         select="document(concat('../terms_',$scheme,'.xml'))"/>
      <xsl:variable name="term">
         <xsl:copy-of select="$termlist//term[@xml:id=$id]"/>         
      </xsl:variable>
      <xsl:sequence select="$term"/>
   </xsl:function>

</xsl:stylesheet>
