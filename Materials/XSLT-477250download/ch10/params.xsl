<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

   <xsl:param name="identifier" select="reference/@xml:id"/>
   <xsl:param name="resourcelist" select="document('../reslist_xsl.xml')"/>
   <xsl:param name="meta" select="$resourcelist//entry[@xml:id eq $identifier]"/>
   <xsl:param name="title" select="$meta/title"/>

</xsl:stylesheet>
