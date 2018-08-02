<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
   xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs">

   <xsl:include href="date.xsl"/>

   <xsl:output method="xml" encoding="UTF-8" indent="yes"/>

   <xsl:variable name="resourcelist"
      select="document(concat('reslist_',tasklist/@scheme,'_update.xml'))"/>
   <xsl:variable name="outputfile"
      select="concat('reslist_',tasklist/@scheme,'_new.xml')"/>
   <xsl:variable name="update" select="."/>

   <xsl:variable name="doc_url">http://xm.net/docs/</xsl:variable>
   <xsl:variable name="term_url">http://xm.net/terms/</xsl:variable>
   <xsl:variable name="tagdomain">xm.net</xsl:variable>

   <xsl:template match="/">

      <xsl:variable name="archive">

         <collection xml:id="{$resourcelist/collection/@xml:id}"
            lastupdate="{$date}">
            <xsl:copy-of select="$resourcelist/collection/title"/>

            <xsl:for-each select="$resourcelist//entry">

               <xsl:variable name="match"
                  select="current()/@xml:id=$update//topicref/@href"/>

               <xsl:choose>
                  <xsl:when test="$match">
                     <xsl:variable name="match2"
                     select="$update//topicref[@href=current()/@xml:id]"/>
                     
                     <entry xml:id="{@xml:id}">
                        <xsl:choose>
                           <xsl:when test="$match2[@status='new']">
                              <xsl:apply-templates
                                 select="title | summary | content | category"/>
                              <published>
                                 <xsl:value-of select="$date_time"/>
                              </published>
                           </xsl:when>
                           <xsl:otherwise>
                              <xsl:apply-templates
                                 select="title | summary | content | category | published"/>
                              <updated>
                                 <xsl:value-of select="$date_time"/>
                              </updated>
                           </xsl:otherwise>
                        </xsl:choose>
                     </entry>
                     
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:copy-of select="."/>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:for-each>
         </collection>

      </xsl:variable>

      <xsl:result-document href="{$outputfile}">
         <xsl:copy-of select="$archive"/>
      </xsl:result-document>

      <xsl:result-document href="xslt_update.atom">

         <feed xmlns:atom="http://www.w3.org/2005/Atom">
            <author>Ian Williams</author>
            <id>
               <xsl:value-of
                  select="concat('tag:',$tagdomain,',',$date,':',$archive/collection/@xml:id)"
               />
            </id>
            <link rel="self" type="application/atom+xml">
               <xsl:attribute name="href">
                  <xsl:value-of
                     select="concat($doc_url,$archive/collection/@xml:id,'.atom')"
                  />
               </xsl:attribute>
            </link>
            <title>
               <xsl:value-of select="$archive/collection/title"/>
            </title>
            <updated>
               <xsl:value-of select="$archive/collection/@lastupdate"/>
            </updated>


            <xsl:for-each select="$archive//entry">
               <xsl:sort select="xs:dateTime(published)" order="descending"/>
               <xsl:sort select="xs:dateTime(updated)" order="descending"/>

               <xsl:variable name="tagdate"
                  select="substring-before(published,'T')"/>
               <entry>
                  <xsl:copy-of select="title"/>
                  <id>
                     <xsl:value-of
                        select="concat('tag:',$tagdomain,',',$tagdate,':',@xml:id)"
                     />
                  </id>
                  <link rel="alternate" type="application/xhtml+xml">
                     <xsl:attribute name="href">
                        <xsl:value-of
                           select="concat($doc_url,substring-after(content/@src,'../'),current()/@xml:id,'.html')"
                        />
                     </xsl:attribute>
                  </link>
                  <xsl:copy-of select="updated"/>
                  <xsl:copy-of select="published"/>
                  <xsl:for-each select="category">
                     <category term="{@term}">
                        <xsl:attribute name="scheme">
                           <xsl:value-of select="concat($term_url,@scheme)"/>
                        </xsl:attribute>
                     </category>

                  </xsl:for-each>

               </entry>
            </xsl:for-each>
         </feed>
      </xsl:result-document>

   </xsl:template>

   <xsl:template
      match="title | summary | content | updated | published |category">
      <xsl:copy-of select="."/>
   </xsl:template>


</xsl:stylesheet>
