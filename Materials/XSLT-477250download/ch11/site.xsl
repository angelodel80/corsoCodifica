<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

   <xsl:include href="ref2xhtml.xsl"/>

   <xsl:param name="container">test_xsl</xsl:param>
   <xsl:param name="logo">../graphics/logo_xsl.png</xsl:param>
   <xsl:param name="style">../style.css</xsl:param>
   <xsl:variable name="sitetitle" select="site/@sitetitle"/>
   <xsl:variable name="resourcelist"
      select="document(concat('../reslist_',site/@scheme,'.xml'))"/>
   <xsl:variable name="scheme" select="site/@scheme"/>
   <xsl:param name="id" select="/*/topicref[1]/@href"/>
   <xsl:param name="dir">file:///c:/eclipse/</xsl:param>

   <xsl:template match="/">
      <xsl:for-each select="//topicref">

         <xsl:variable name="file">
            <xsl:value-of select="concat(@href,'.html')"/>
         </xsl:variable>
         <xsl:variable name="folder" select="ancestor::map/@folder"/>

         <xsl:result-document href="{$dir}/{$container}/{$folder}/{$file}">

            <xsl:variable name="identifier" select="@href"/>
            <xsl:variable name="meta"
               select="$resourcelist//entry[@xml:id=$identifier]"/>
            <xsl:variable name="title" select="$meta/title"/>
            <xsl:variable name="type" select="$meta/resourceType/@term"/>
            <xsl:variable name="source"
               select="concat($meta/content/@src,@href,'.xml')"/>
            <xsl:variable name="resource" select="document($source)"/>

            <html>
               <xsl:call-template name="head">
                  <xsl:with-param name="title">
                     <xsl:value-of select="$title"/>
                  </xsl:with-param>
                  <xsl:with-param name="style" select="$style"/>
               </xsl:call-template>

               <body>
                  <h1 id="site_title">
                     <xsl:value-of select="$sitetitle"/>
                  </h1>

                  <table class="header">
                     <tr>
                        <td class="logo">
                           <img src="{$logo}"/>
                        </td>
                        <td class="navcontainer">
                           <ul class="navlist">
                              <xsl:call-template name="tabs">
                                 <xsl:with-param name="mapID"
                                    select="ancestor::map/@id"/>
                              </xsl:call-template>
                           </ul>
                        </td>
                     </tr>
                  </table>
                  <div id="pageName">

                     <div id="pageNav">
                        <xsl:for-each select="ancestor::map//section">
                           <div class="relatedLinks">
                              <h3>
                                 <xsl:value-of select="@label"/>
                              </h3>
                              <xsl:apply-templates select="current()//topicref"
                                 mode="toc">
                                 <xsl:with-param name="thistopic"
                                    select="$identifier"/>
                                 <xsl:with-param name="thismeta" select="$meta"
                                    tunnel="yes"/>
                                 <xsl:with-param name="reslist"
                                    select="$resourcelist" tunnel="yes"/>
                              </xsl:apply-templates>
                           </div>
                        </xsl:for-each>
                     </div>

                     <div id="content">
                        <h1>
                           <xsl:value-of select="$title"/>
                        </h1>
                       <xsl:apply-templates select="$resource//body/*">
                           <xsl:with-param name="source_id" select="$identifier"
                              tunnel="yes"/>
                           <xsl:with-param name="default_scheme"
                              select="$scheme" tunnel="yes"/>
                        </xsl:apply-templates>
                     </div>
                     
                  </div>
                  <div id="siteInfo"> Legal notice | <xsl:value-of
                        select="$copyright"/>
                  </div>
               </body>
            </html>
         </xsl:result-document>
      </xsl:for-each>


   </xsl:template>

   <xsl:template match="topicref" mode="toc">
      <xsl:param name="thistopic">default</xsl:param>

      <xsl:for-each select=".">
         <xsl:variable name="topic"
            select="$resourcelist//entry[@xml:id=current()/@href]"/>
         <a>
            <xsl:attribute name="href">
               <xsl:value-of select="concat($topic/content/@src,@href,'.html')"
               />
            </xsl:attribute>
            <!--            mark current topic  -->
            <xsl:if test="$thistopic=current()/@href">
               <xsl:attribute name="class">currentref</xsl:attribute>
            </xsl:if>
            <xsl:value-of select="$topic/title"/>
         </a>

         <xsl:apply-templates/>
      </xsl:for-each>
   </xsl:template>



   <xsl:template name="tabs">
      <xsl:param name="mapID"/>
      <xsl:for-each select="//map">
         <li>
            <!-- get 'tab' label and first topic link in each section -->
            <xsl:variable name="linkID" select="section[1]/topicref[1]/@href"/>

            <xsl:call-template name="navtab">
               <xsl:with-param name="id" select="$linkID"/>
               <xsl:with-param name="mapID" select="$mapID"/>
               <xsl:with-param name="label" select="@tab"/>
            </xsl:call-template>

         </li>
      </xsl:for-each>

   </xsl:template>

   <xsl:template name="navtab">
      <xsl:param name="id"/>
      <xsl:param name="mapID"/>
      <xsl:param name="label"/>

      <xsl:variable name="linkmeta" select="$resourcelist//entry[@xml:id=$id]"/>
      <a>
         <xsl:if test="$mapID=current()/@id">
            <xsl:attribute name="class">current</xsl:attribute>
         </xsl:if>
         <xsl:attribute name="href">
            <xsl:value-of select="concat($linkmeta//content/@src,$id,'.html')"/>
         </xsl:attribute>
         <xsl:attribute name="title">
            <xsl:value-of select="$linkmeta/title"/>
         </xsl:attribute>
         <xsl:value-of select="$label"/>
      </a>
   </xsl:template>

</xsl:stylesheet>
