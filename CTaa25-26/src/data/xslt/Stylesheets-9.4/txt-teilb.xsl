<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:t="http://www.tei-c.org/ns/1.0" version="2.0">
   <!-- Actual display and increment calculation found in teilb.xsl -->
   <xsl:import href="teilb.xsl"/>

    <xsl:template match="t:lb">
        <xsl:param name="parm-edition-type" tunnel="yes" required="no"></xsl:param>
        <xsl:param name="parm-leiden-style" tunnel="yes" required="no"></xsl:param>
        <xsl:param name="parm-line-inc" tunnel="yes" required="no"></xsl:param>
        <xsl:param name="parm-verse-lines" tunnel="yes" required="no"></xsl:param>
        <xsl:choose>
           <xsl:when test="ancestor::t:lg and $parm-verse-lines = 'yes'">
            <xsl:apply-imports/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:variable name="div-loc">
               <xsl:for-each select="ancestor::t:div[@type='textpart']">
                  <xsl:value-of select="@n"/>
                  <xsl:text>-</xsl:text>
               </xsl:for-each>
            </xsl:variable>
            <xsl:variable name="line">
               <xsl:if test="@n">
                  <xsl:value-of select="@n"/>
               </xsl:if>
            </xsl:variable>
            <xsl:if
               test="(@break='no' or @type='inWord')">
               
               <!-- following test decides whether there should be a hyphen at the end of previous line or not -->
               <xsl:choose>
                  <!--    *unless* eagle txt  -->
                  <xsl:when test="$parm-edition-type='eagletxt'"/>                  
<!--    *unless* diplomatic edition  -->
                   <xsl:when test="$parm-edition-type='diplomatic'"/>
                  <!--    *or unless* the lb is first in its ancestor div  -->
                  <xsl:when test="generate-id(self::t:lb) = generate-id(ancestor::t:div[1]/t:*[child::t:lb][1]/t:lb[1])"/>
                  <!--   *or unless* one of the EDH leiden-styles, which don't use hyphens -->
                  <xsl:when test="starts-with($parm-leiden-style, 'edh')"/>
                  <!--   *or unless* the second part of an app in ddbdp  -->
                  <xsl:when test="($parm-leiden-style = ('ddbdp','dclp','sammelbuch')) and
                     (ancestor::t:corr or ancestor::t:reg or ancestor::t:rdg or ancestor::t:del[parent::t:subst])"/>
                  <!--  *or unless* previous line ends with space / g / supplied[reason=lost]  -->
                  <!-- in which case the hyphen will be inserted before the space/g or final ']' of supplied
                     (tested by EDF:f-wwrap in functions.xsl, which is called by teisupplied.xsl, teig.xsl and teispace.xsl) -->
                  <xsl:when test="preceding-sibling::node()[1][local-name() = 'space' or
                     local-name() = 'g' or (local-name()='supplied' and @reason='lost') or
                     (normalize-space(.)='' 
                     and preceding-sibling::node()[1][local-name() = 'space' or
                     local-name() = 'g' or (local-name()='supplied' and @reason='lost')])]"/>
                  <xsl:otherwise>
                     <xsl:text>-</xsl:text>
                  </xsl:otherwise>
               </xsl:choose>
               
            </xsl:if>
            <!-- following test decides whether line breaks should be '/' or hard carriage return -->
            <xsl:choose>
                <xsl:when test="starts-with($parm-leiden-style, 'edh')">
                  <xsl:variable name="cur_anc"
                     select="generate-id(ancestor::node()[local-name()='lg' or local-name()='ab'])"/>
                  <xsl:if
                     test="preceding::t:lb[1][generate-id(ancestor::node()[local-name()='lg' or local-name()='ab'])=$cur_anc]">
                     <xsl:choose>
               <xsl:when test="$parm-leiden-style='edh-names'
                  and not(@break='no' or ancestor::t:w | ancestor::t:name | ancestor::t:placeName | ancestor::t:geogName)">
                  <xsl:text> </xsl:text>
               </xsl:when>
                        <xsl:when test="$parm-leiden-style='edh-names'"/>
                        <xsl:when
                           test="@break='no' or ancestor::t:w | ancestor::t:name | ancestor::t:placeName | ancestor::t:geogName">
                           <xsl:text>/</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                           <xsl:text> / </xsl:text>
                        </xsl:otherwise>
                     </xsl:choose>
                  </xsl:if>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:text>&#xd;</xsl:text>
               </xsl:otherwise>
            </xsl:choose>
            
            <!-- following test decides if and how line numbers should be displayed -->
            <xsl:choose>
               <xsl:when test="starts-with($parm-leiden-style, 'edh')"/>
                <xsl:when test="not(number(@n)) and $parm-leiden-style = ('ddbdp','dclp','sammelbuch')">
                  <xsl:call-template name="margin-num"/>
               </xsl:when>
                <xsl:when test="number(@n) and @n mod number($parm-line-inc) = 0 and not(@n = 0)">
                   <xsl:call-template name="margin-num"/>
               </xsl:when>
               <xsl:when test="preceding-sibling::t:*[1][local-name() = 'gap'][@unit = 'line']">
                  <xsl:call-template name="margin-num"/>
               </xsl:when>
               <xsl:otherwise>
                  <!-- template »line-numbering-tab« found in txt-tpl-linenumberingtab.xsl respectively odf-tpl-linenumberingtab.xsl -->
                  <xsl:call-template name="line-numbering-tab" />
               </xsl:otherwise>
            </xsl:choose>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <xsl:template name="margin-num">
      <xsl:value-of select="@n"/>
      <!-- template »line-numbering-tab« found in txt-tpl-linenumberingtab.xsl respectively odf-tpl-linenumberingtab.xsl -->
      <xsl:call-template name="line-numbering-tab" />
   </xsl:template>

</xsl:stylesheet>
