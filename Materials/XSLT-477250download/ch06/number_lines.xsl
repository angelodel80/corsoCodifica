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
         <xsl:value-of select="format-number(@n,'Act 0: ')"/>
      </h2>
      <xsl:apply-templates select="* except head"/>
   </xsl:template>
   <xsl:template match="div[@type='scene']">
      <h3>
         <xsl:value-of select="format-number(@n,'Scene 0: ')"/>
         <xsl:value-of select="head"/>
      </h3>
      <xsl:apply-templates select="* except head"/>
   </xsl:template>

   <xsl:template match="sp">     
      <table width="80%" class="noborder">
         <td class="noborder speaker" width="80%">
            <xsl:value-of select="speaker"/>
         </td>
         <xsl:apply-templates/>
      </table>
   </xsl:template>
   
   <xsl:template match="l">
      <tr>
         <td class="noborder" width="60%">
            <xsl:apply-templates/>
         </td>
         <td class="noborder" width="20%" >
            <xsl:variable name="ln">
            <xsl:number level="any" from="div[@type='scene']"/>
            </xsl:variable>
            <xsl:if test="$ln mod $interval=0">
               <xsl:value-of select="$ln"/>
            </xsl:if>
         </td>
      </tr>
   </xsl:template>

   <xsl:template match="TEI/child::teiHeader | speaker"/>
   
   <xsl:template match="TEI/text/front"/>
   
   <xsl:template match="div[@type='scene']/stage">
      <table width="100%" class="noborder">
         <tr>
            <td class="noborder" colspan="2" width="50%">[<xsl:value-of
               select="."/>] </td>
         </tr>
      </table>
   </xsl:template>
   
   <xsl:template match="lg/head">[<xsl:value-of select="."/>]<br/></xsl:template>
   
   <xsl:template match="stage">[<xsl:value-of select="."/>] </xsl:template>
</xsl:stylesheet>
