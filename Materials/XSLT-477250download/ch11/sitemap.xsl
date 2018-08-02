<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

   <xsl:output method="xml" encoding="UTF-8"/>
   <xsl:param name="date"
      select="format-date(current-date(),'[Y]-[M01]-[D01]')"/>
   <xsl:param name="resourcelist"
      select="document(concat('../reslist_',site/@scheme,'.xml'))"/>
   <xsl:param name="uri">"http://xm.net/docs/"</xsl:param>

   <xsl:template match="/">
      <xsl:variable name="ouput_file" select="concat('sitemap_',$date,'.xml')"/>
      <xsl:result-document href="{$ouput_file}">
         <xsl:variable name="resourcelist"
            select="document(concat('../reslist_',site/@scheme,'.xml'))"/>

         <urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">

            <xsl:for-each select="//topicref">
               <xsl:variable name="identifier" select="@href"/>
               <xsl:variable name="meta"
                  select="$resourcelist//entry[@xml:id=$identifier]"/>
               <xsl:variable name="title" select="$meta/title"/>
               <xsl:variable name="source"
                  select="substring-after(concat($meta/content/@src,@href),'../')"/>
               <url>
                  <loc>
                     <xsl:value-of select="concat($uri,$source,'.html')"/>
                  </loc>
                  <lastmod>
                     <xsl:value-of select="$date"/>
                  </lastmod>
                  <changefreq>daily</changefreq>
                  <priority>0.5</priority>
               </url>
            </xsl:for-each>
         </urlset>
      </xsl:result-document>
   </xsl:template>
</xsl:stylesheet>
