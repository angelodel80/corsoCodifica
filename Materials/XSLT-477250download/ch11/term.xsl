<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
   xmlns:xm="http://xm.net/2007/xsl/function" exclude-result-prefixes="xm">


   <!-- inserts a linked label and definition popup, or an inline definition
       -->
   <xsl:template match="dfn">
      <xsl:variable name="def">
         <xsl:copy-of select="xm:getterm-by-id(@term,@scheme)"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="@class='popup'">
            <xsl:variable name="pop" select="normalize-space($def/term/definition)"></xsl:variable>
 
            <a title="{$pop}">
               <xsl:attribute name="href"
                  select="concat('../terms_',@scheme,'/',@term,'.','.html')"/>
               <xsl:value-of select="$def/term/label"/>
            </a>
            <xsl:if test="$def/term/altlabel"> [<xsl:value-of
                  select="$def/term/altlabel"/>] </xsl:if>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of
               select="concat($def/term/label,': ',$def/term/definition)"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <!-- creates a embedded 'glossary' sorted by label from references to individual terms in one or more schemes terms are not linked     
   -->
   <xsl:template name="getterms">
      <xsl:param name="default_scheme" required="yes"/>
      <xsl:param name="label" required="yes"/>
      <xsl:param name="show_related">no</xsl:param>

      <h2>
         <xsl:value-of select="$labels//label[@name=$label]"/>
         <xsl:if test="count(current()//link)&gt;1">s</xsl:if>
      </h2>

      <xsl:variable name="newlist">
         <xsl:for-each select="dfn">
            <xsl:choose>
               <xsl:when test="@scheme">
                  <xsl:copy-of
                     select="xm:getterm-by-id(current()/@term,current()/@scheme)"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:copy-of
                     select="xm:getterm-by-id(current()/@term,$default_scheme)"/>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:for-each>
      </xsl:variable>

      <table class="gloss">
         <xsl:variable name="current_term"
            select="."/>  
         
         <tbody>
            <xsl:for-each select="$newlist/term">
               <xsl:sort select="label"/>
               <tr>
                  <th class="gloss">
                     <xsl:value-of select="label"/>
                     <!--                     alternative terms-->
                     <xsl:if test="altlabel">
                        <xsl:text> [</xsl:text>
                        <xsl:for-each select="altlabel">
                           <xsl:value-of select="."/>
                           <xsl:if test="position()!=last()"
                              >,&#160;</xsl:if>]</xsl:for-each>
                     </xsl:if>&#160; <xsl:apply-templates select="object"/>
                  </th>
               </tr>
               <tr>
                  <td class="gloss">
                     <xsl:apply-templates select="definition"/>
                  </td>
               </tr>
               
            </xsl:for-each>
         </tbody>
      </table>
   </xsl:template>
  
</xsl:stylesheet>
