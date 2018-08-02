<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

   <xsl:output method="html"/>

   <xsl:param name="style">reference.css</xsl:param>
   <xsl:param name="interval" select="5"/>

   <xsl:template match="/">
      <html>
         <xsl:call-template name="head">
            <xsl:with-param name="title" select="TEI/text/front/docTitle"/>
            <xsl:with-param name="style" select="$style"/>
         </xsl:call-template>
         <body>
            <h1>
               <xsl:value-of select="TEI/text/front/docTitle"/>
            </h1>
            <h2>
               <xsl:value-of select="TEI/text//castList/head"/>
            </h2>
            <ul class="unmarked">
               <xsl:for-each select="//castList/castItem">
                  <li>
                     <xsl:value-of select="."/>
                  </li>
               </xsl:for-each>
            </ul>

            <xsl:apply-templates/>
         </body>
      </html>
   </xsl:template>
   <xsl:template name="head">
      <xsl:param name="title"/>
      <xsl:param name="style"/>
      <head>
         <meta http-equiv="Content-Type" content="text/xml;charset=UTF-8"/>
         <title>
            <xsl:value-of select="$title"/>
         </title>
         <link rel="stylesheet" type="text/css">
            <xsl:attribute name="href">
               <xsl:value-of select="$style"/>
            </xsl:attribute>
         </link>
      </head>
   </xsl:template>
   <xsl:template match="div[@type='act']">
      <h2>
         <xsl:value-of select="format-number(@n,'Act 0')"/>
      </h2>
      <xsl:for-each select="div[@type='scene']">
         <xsl:variable name="file"
            select="concat('a',parent::div/@n,'s',@n,'.html')"/>
         <a href="{$file}">
            <xsl:value-of select="format-number(@n,'Scene 0: ')"/>
            <xsl:value-of select="head"/>
         </a>
         <xsl:if test="position() ne last()">
            <br/>
         </xsl:if>
      </xsl:for-each>
      <xsl:apply-templates select="* except head"/>
   </xsl:template>

   <xsl:template match="div[@type='scene']">

      <xsl:variable name="file"
         select="concat('a',parent::div/@n,'s',@n,'.html')"/>

      <xsl:result-document href="{$file}">
         <xsl:variable name="title">
            <xsl:value-of select="format-number(parent::div/@n,'Act 0 ')"/>
            <xsl:value-of select="format-number(@n,'Scene 0: ')"/>
         </xsl:variable>

         <html>
            <head>
               <meta http-equiv="Content-Type" content="text/xml;charset=UTF-8"/>
               <title>
                  <xsl:value-of select="$title"/>
               </title>
               <link rel="stylesheet" type="text/css">
                  <xsl:attribute name="href">
                     <xsl:value-of select="$style"/>
                  </xsl:attribute>
               </link>
            </head>
            <body>
               <h1>
                  <xsl:value-of select="$title"/>
                  <xsl:value-of select="head"/>
               </h1>
               <xsl:apply-templates select="* except head"/>
            </body>
         </html>

      </xsl:result-document>
   </xsl:template>

   <xsl:template match="sp">
      <table width="100%" class="noborder">
         <tr>
            <xsl:for-each-group select="*"
               group-adjacent="if (self::speaker) then 0 else 1">
               <td class="noborder" width="50%">
                  <xsl:for-each select="current-group()">
                     <xsl:apply-templates select="."/>
                     <xsl:if test="current-group()='0'">
                        <span class="speaker">
                           <xsl:value-of select="."/>
                        </span>
                     </xsl:if>
                     <xsl:if test="position() ne last()">
                        <br/>
                     </xsl:if>
                  </xsl:for-each>
               </td>

            </xsl:for-each-group>
         </tr>
      </table>
   </xsl:template>

   <xsl:template match="speaker">
      <span class="speaker">
         <xsl:value-of select="."/>
      </span>
   </xsl:template>

   <xsl:template match="TEI/teiHeader"/>

   <xsl:template match="TEI/text/front"/>

   <xsl:template match="div[@type='scene']/stage">
      <table width="100%" class="noborder">
         <tr>
            <td class="noborder" colspan="2" width="50%">[<xsl:value-of
                  select="."/>] </td>
         </tr>
      </table>
   </xsl:template>
   <xsl:template match="lg">
      <xsl:apply-templates select="l"/>
   </xsl:template>
   <xsl:template match="lg/head">[<xsl:value-of select="."
      />]<br/></xsl:template>

   <xsl:template match="stage">[<xsl:value-of select="."/>] </xsl:template>
</xsl:stylesheet>
