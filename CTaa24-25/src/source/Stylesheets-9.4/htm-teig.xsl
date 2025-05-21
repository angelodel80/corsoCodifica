<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" 
                version="2.0">
  
  <!-- Import templates can be found in teig.xsl -->
  <xsl:import href="teig.xsl"/>

  <xsl:template match="t:g">
      <xsl:param name="parm-edition-type" tunnel="yes" required="no"></xsl:param>
      <xsl:param name="parm-leiden-style" tunnel="yes" required="no"></xsl:param>
      <xsl:param name="parm-edn-structure" tunnel="yes" required="no"></xsl:param>
      <xsl:param name="location" tunnel="yes" required="no"></xsl:param>
      <xsl:call-template name="lb-dash"/>
      <xsl:call-template name="w-space"/>
    
     <xsl:choose>
         <xsl:when test="starts-with($parm-leiden-style, 'edh')"/>
       <xsl:when test="($parm-leiden-style = ('ddbdp','dclp','sammelbuch'))">
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
         <xsl:when test="$parm-edition-type = 'diplomatic'">
            <xsl:text> </xsl:text>
            <em>
               <span class="smaller">
                  <xsl:apply-imports/>
               </span>
            </em>
            <xsl:text> </xsl:text>
         </xsl:when>
         <xsl:when test="$parm-leiden-style = 'dohnicht'">
           <xsl:text>⊂</xsl:text>
           <xsl:apply-imports/>
           <xsl:text>⊃</xsl:text>
        </xsl:when>
        <xsl:when test="$parm-edn-structure='inslib' and (starts-with(ancestor::t:TEI//t:publicationStmt/t:idno[@type='filename']/text(), 'IGCyr') or starts-with(ancestor::t:TEI//t:publicationStmt/t:idno[@type='filename']/text(), 'GVCyr'))">
         <xsl:apply-imports/>
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