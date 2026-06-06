<!-- $Id$ --><xsl:stylesheet xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" version="2.0">
  
  <!-- Import templates can be found in teig.xsl -->
  <xsl:import href="teig.xsl"/>

  <xsl:template match="t:g">
      <xsl:param name="parm-edition-type" tunnel="yes" required="no"/>
      <xsl:param name="parm-leiden-style" tunnel="yes" required="no"/>
      <xsl:param name="parm-edn-structure" tunnel="yes" required="no"/> <!-- added for creta -->
      <xsl:call-template name="lb-dash"/>
      <xsl:call-template name="w-space"/>
    
     <xsl:choose>
         <xsl:when test="starts-with($parm-leiden-style, 'edh') or $parm-leiden-style='eagletxt'"/>
         <xsl:when test="($parm-leiden-style = 'ddbdp' or $parm-leiden-style = 'sammelbuch')">
        <!-- Found in teig.xsl -->
        <xsl:call-template name="g-ddbdp"/>
         </xsl:when>
         <xsl:when test="$parm-leiden-style = 'london'">
           <xsl:call-template name="g-london"/>
         </xsl:when>
         <xsl:when test="$parm-leiden-style = 'iospe'">
           <xsl:apply-imports/>
           <!--   removed customization of IOSPE from stylesheets   -->
           <!--<xsl:call-template name="g-iospe"/>-->
        </xsl:when>
         <xsl:when test="$parm-leiden-style = 'rib'">
             <xsl:call-template name="g-rib"/>
         </xsl:when>
         <xsl:when test="$parm-edn-structure = 'creta'">     <!-- added for creta -->
         <xsl:call-template name="g-creta"/>
       </xsl:when>
         <xsl:when test="$parm-edition-type = 'diplomatic'">
            <xsl:text> </xsl:text>
            <fo:inline-container>
               <fo:inline font-size="smaller">
                  <xsl:apply-imports/>
               </fo:inline>
            </fo:inline-container>
            <xsl:text> </xsl:text>
         </xsl:when>
         <xsl:when test="$parm-leiden-style = 'dohnicht'">
           <xsl:text>⊂</xsl:text>
           <xsl:apply-imports/>
           <xsl:text>⊃</xsl:text>
        </xsl:when>
        <xsl:otherwise>
           <xsl:text>((</xsl:text>
           <xsl:apply-imports/>
           <xsl:text>))</xsl:text>
         </xsl:otherwise>
      </xsl:choose>
    
      <xsl:call-template name="w-space"/>
  </xsl:template>

</xsl:stylesheet>