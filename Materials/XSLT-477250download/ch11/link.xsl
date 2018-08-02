<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xm="http://xm.net/2007/xsl/function" exclude-result-prefixes="xm"
   version="2.0" xm:scheme="xm" xml:id="xm_link_xsl">

   <xsl:param name="extension">
      <xsl:text>html</xsl:text>
   </xsl:param>

   <xsl:param name="context">test</xsl:param>
   <xsl:template name="separate">
      <!--default is comma+space-->
      <xsl:param name="separator">, </xsl:param>
      <xsl:if test="position() ne last()">
         <xsl:value-of select="$separator"/>
      </xsl:if>
   </xsl:template>

   <xsl:template name="makelink">
      <xsl:param name="class">
         <xsl:text>block</xsl:text>
      </xsl:param>
      <xsl:param name="url"/>
      <xsl:param name="linktitle"/>
      <xsl:param name="popup"/>
      <a class="{$class}" href="{$url}">

         <xsl:choose>
            <xsl:when test="$class='external'">
               <xsl:attribute name="target">
                  <xsl:text>_blank</xsl:text>
               </xsl:attribute>
               <xsl:attribute name="title">
                  <xsl:value-of select="$labels//label[@name='external']"/>
               </xsl:attribute>
            </xsl:when>
            <xsl:when test="$class='nav'">
               <xsl:attribute name="target">
                  <xsl:text>_self</xsl:text>
               </xsl:attribute>

               <!-- popup may differ from title-->
               <xsl:attribute name="title">
                  <xsl:value-of select="$popup"/>
               </xsl:attribute>

            </xsl:when>
            <xsl:otherwise>
               <xsl:attribute name="target">
                  <xsl:text>_self</xsl:text>
               </xsl:attribute>
               <xsl:attribute name="title">
                  <xsl:value-of select="$linktitle"/>
               </xsl:attribute>
            </xsl:otherwise>
         </xsl:choose>
         <xsl:value-of select="$linktitle"/>
      </a>
   </xsl:template>


   <xsl:template name="getlinks">
      <xsl:param name="source_id" required="yes" tunnel="yes"/>
      <xsl:param name="default_scheme" required="yes" tunnel="yes"/>
      <xsl:param name="label" required="yes"/>
      <xsl:param name="display" required="yes"/>

      <h2>
         <xsl:value-of select="$labels//label[@name=$label]"/>
         <xsl:if test="count(current()//link)&gt;1">s</xsl:if>
      </h2>

      <xsl:variable name="newlist">
         <xsl:for-each select="link">
            <xsl:choose>
               <xsl:when test="@scheme">
                  <xsl:copy-of select="xm:getentry-by-id(@href,@scheme)"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:copy-of select="xm:getentry-by-id(@href,$default_scheme)"
                  />
               </xsl:otherwise>
            </xsl:choose>
         </xsl:for-each>
      </xsl:variable>

      <p>
         <xsl:for-each select="$newlist/entry">
            <!--<xsl:sort select="title"/>-->
            <xsl:choose>
               <!-- list but don't link recursive schema references -->
               <xsl:when test="$source_id=@xml:id">
                  <xsl:value-of select="title"/>
               </xsl:when>

               <xsl:otherwise>
                  <xsl:call-template name="makelink">
                     <xsl:with-param name="class" select="$display"/>
                     <xsl:with-param name="url"
                        select="concat(content/@src,@xml:id,'.',$extension)"/>
                     <xsl:with-param name="linktitle">
                        <xsl:value-of select="title"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:otherwise>
            </xsl:choose>

            <xsl:choose>
               <xsl:when test="$display='inline'">
                  <xsl:call-template name="separate">
                     <xsl:with-param name="separator"
                        >&#x00a0;|&#x00a0;</xsl:with-param>
                  </xsl:call-template>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:if test="position() ne last()">
                     <br/>
                  </xsl:if>
               </xsl:otherwise>
            </xsl:choose>

         </xsl:for-each>
      </p>
   </xsl:template>




   <!--   reference table     -->
   <xsl:template name="maketable">
      <xsl:param name="default_scheme" tunnel="yes"/>

      <xsl:variable name="newlist">
         <xsl:for-each select="link">
            <xsl:choose>
               <xsl:when test="@scheme">
                  <xsl:copy-of
                     select="xm:getentry-by-id(current()/@href,current()/@scheme)"
                  />
               </xsl:when>
               <xsl:otherwise>
                  <xsl:copy-of
                     select="xm:getentry-by-id(current()/@href,$default_scheme)"
                  />
               </xsl:otherwise>
            </xsl:choose>
         </xsl:for-each>
      </xsl:variable>

      <table cellspacing="0">
         <thead>
            <tr>
               <th xsl:use-attribute-sets="th_first">Name</th>
               <th xsl:use-attribute-sets="col">Purpose</th>
            </tr>
         </thead>
         <tbody>
            <xsl:for-each select="$newlist/entry">
               <xsl:sort select="title"/>
               <xsl:variable name="data"
                  select="document(concat(content/@src,@xml:id,'.xml'))"/>
               <tr>
                  <th xsl:use-attribute-sets="td_first">
                     <xsl:call-template name="makelink">
                        <xsl:with-param name="class">inline</xsl:with-param>
                        <xsl:with-param name="url"
                           select="concat(content/@src,@xml:id,'.',$extension)"/>
                        <xsl:with-param name="linktitle" select="title"/>
                     </xsl:call-template>
                  </th>
                  <td xsl:use-attribute-sets="row">
                     <xsl:apply-templates select="summary"/>
                     <xsl:if test="comment">
                        <xsl:if test="comment">
                           <xsl:text>. </xsl:text>
                           <xsl:apply-templates select="comment"/>
                        </xsl:if>
                     </xsl:if>
                  </td>
               </tr>
            </xsl:for-each>
         </tbody>
      </table>
   </xsl:template>

</xsl:stylesheet>
