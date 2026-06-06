<!-- $Id$ --><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="t" version="2.0">

   <!-- Other div matches can be found in htm-teidiv*.xsl -->

   <!-- Text edition div -->
    <xsl:template match="t:div[@type = 'edition']" priority="1">
        <xsl:param name="parm-internal-app-style" tunnel="yes" required="no"/>
        <xsl:param name="parm-external-app-style" tunnel="yes" required="no"/>
       
        <fo:block>
<!-- Found in htm-tpl-lang.xsl -->
<!--         <xsl:call-template name="attr-lang"/>-->
         <xsl:apply-templates/>

         
           <xsl:choose>
               <!-- Apparatus creation: look in tpl-apparatus.xsl for documentation and templates -->
               <xsl:when test="$parm-internal-app-style = 'ddbdp'">
                   <!-- Framework found in htm-tpl-apparatus.xsl -->
                   <xsl:call-template name="tpl-apparatus"/>
               </xsl:when>
               <xsl:when test="$parm-internal-app-style = 'iospe'">
                    <!-- Template found in htm-tpl-apparatus.xsl -->
                    <xsl:call-template name="tpl-iospe-apparatus"/>
               </xsl:when>
               <xsl:when test="$parm-internal-app-style ='fullex'">
                   <!-- Template to be added in htm-tpl-apparatus.xsl -->
                   <xsl:call-template name="tpl-fullex-apparatus"/>
               </xsl:when>
               
<xsl:when test="$parm-internal-app-style ='minex'">
                   <!-- Template to be added in htm-tpl-apparatus.xsl -->
                   <xsl:call-template name="tpl-minex-apparatus"/>
               </xsl:when>


               <!--     the default if nothing is selected is to print no internal apparatus      -->
           </xsl:choose>
        </fo:block>
   </xsl:template>


   <!-- Textpart div -->
    <xsl:template match="t:div[@type='edition']//t:div[@type='textpart']" priority="1">
        <xsl:param name="parm-leiden-style" tunnel="yes" required="no"/>
        <xsl:param name="parm-internal-app-style" tunnel="yes" required="no"/>
       <xsl:variable name="div-type">
           <xsl:for-each select="ancestor::t:div[@type!='edition']">
               <xsl:value-of select="@type"/>
               <xsl:text>-</xsl:text>
           </xsl:for-each>
       </xsl:variable>
       <xsl:variable name="div-loc">
         <xsl:for-each select="ancestor::t:div[@type='textpart'][@n]">
            <xsl:value-of select="@n"/>
            <xsl:text>-</xsl:text>
         </xsl:for-each>
      </xsl:variable>
      <xsl:if test="@n"><!-- prints div number -->
          <fo:inline padding-right="0.2em" position="absolute" id="{$div-type}ab{$div-loc}{@n}">
           <!-- add ancestor textparts -->
             <xsl:if test="($parm-leiden-style = 'ddbdp' or $parm-leiden-style = 'sammelbuch') and @subtype">
              <xsl:value-of select="@subtype"/>
              <xsl:text> </xsl:text>
           </xsl:if>
              <xsl:value-of select="@n"/>
         </fo:inline>
          <xsl:if test="child::*[1][self::t:div[@type='textpart'][@n]]"><br/></xsl:if>
      </xsl:if>
      <xsl:apply-templates/>
        <xsl:if test="$parm-internal-app-style = 'iospe' and @n">
           <!-- Template found in htm-tpl-apparatus.xsl -->
           <xsl:call-template name="tpl-iospe-apparatus"/>
       </xsl:if>
   </xsl:template>
</xsl:stylesheet>