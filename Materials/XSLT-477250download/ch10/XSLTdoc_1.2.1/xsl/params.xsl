<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xd="http://www.pnp-software.com/XSLTdoc" version="2.0">
   <xd:doc type="stylesheet">
      <xd:short>Defines the styesheet parameters.</xd:short>
   </xd:doc>
   <xd:doc>
      <xd:short>Sets the <code>identifier</code> parameter from the source document's <code>xml:id</code> attribute.</xd:short>
   </xd:doc>  
   <xsl:param name="identifier" select="reference/@xml:id"/>
   <xd:doc>
      <xd:short>The resource metadata file.</xd:short>
   </xd:doc>   
   <xsl:param name="resourcelist" select="document('../reslist_xsl.xml')"/>
   <xd:doc>
      <xd:short>The metadata <code>entry</code> element matching the <code>identifier</code> parameter.</xd:short>
   </xd:doc>
   <xsl:param name="meta" select="$resourcelist//entry[@xml:id eq $identifier]"/>
   <xd:doc>
      <xd:short>The  <code>title</code> element in the matching <code>entry</code> element.</xd:short>
   </xd:doc>
   <xsl:param name="title" select="$meta/title"/>
</xsl:stylesheet>
