<!-- $Id$ --><xsl:stylesheet xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="t" version="2.0">
   <xsl:output method="xml" encoding="UTF-8"/>

   <xsl:include href="global-varsandparams.xsl"/>

   <!-- html related stylesheets, these may import tei{element} stylesheets if relevant eg. htm-teigap and teigap -->
   <xsl:include href="fo-teiab.xsl"/>
   <xsl:include href="fo-teiaddanddel.xsl"/>
   <xsl:include href="fo-teiapp.xsl"/>
   <xsl:include href="fo-teidiv.xsl"/>
   <xsl:include href="fo-teidivedition.xsl"/>
   <xsl:include href="fo-teidivapparatus.xsl"/>
   <xsl:include href="fo-teiforeign.xsl"/>
   <xsl:include href="fo-teifigure.xsl"/>
   <xsl:include href="fo-teig.xsl"/>
   <xsl:include href="fo-teigap.xsl"/>
   <xsl:include href="fo-teihead.xsl"/>
   <xsl:include href="fo-teihi.xsl"/>
   <xsl:include href="fo-teilb.xsl"/>
   <xsl:include href="fo-teilgandl.xsl"/>
   <xsl:include href="fo-teilistanditem.xsl"/>
   <xsl:include href="fo-teilistbiblandbibl.xsl"/>
    <xsl:include href="fo-teimilestone.xsl"/>
    <xsl:include href="fo-teibibl.xsl"/>
   <xsl:include href="fo-teinote.xsl"/>
   <xsl:include href="fo-teinum.xsl"/>
   <xsl:include href="fo-teip.xsl"/>
   <xsl:include href="fo-teiseg.xsl"/>
   <xsl:include href="fo-teispace.xsl"/>
   <xsl:include href="fo-teisupplied.xsl"/>
   <xsl:include href="fo-teiterm.xsl"/>
   <xsl:include href="fo-teiref.xsl"/>

   <!-- html related stylesheets for named templates -->
   <xsl:include href="fo-tpl-sqbrackets.xsl"/>
    <xsl:include href="fo-tpl-apparatus.xsl"/>
    <xsl:include href="fo-tpl-lang.xsl"/>
    
    <!-- html related stylesheets for named templates -->
    <xsl:include href="fo-tpl-struct-creta.xsl"/>
    
   <!-- tei stylesheets that are also used by start-txt -->
   <xsl:include href="teiabbrandexpan.xsl"/>
   <xsl:include href="teicertainty.xsl"/>
   <xsl:include href="teichoice.xsl"/>
   <xsl:include href="teihandshift.xsl"/>
   <xsl:include href="teiheader.xsl"/>
   <xsl:include href="teimilestone.xsl"/>
   <xsl:include href="teiorig.xsl"/>
   <xsl:include href="teiorigandreg.xsl"/>
   <xsl:include href="teiq.xsl"/>
   <xsl:include href="teisicandcorr.xsl"/>
   <xsl:include href="teispace.xsl"/>
   <xsl:include href="teisupplied.xsl"/>
   <xsl:include href="teisurplus.xsl"/>
   <xsl:include href="teiunclear.xsl"/>

    
    <!-- global named templates with no html, also used by start-txt  -->
    <xsl:include href="tpl-certlow.xsl"/>
    <xsl:include href="functions.xsl"/>
<!--   <xsl:include href="tpl-text.xsl"/>-->
<!--    <xsl:include href="tpl-reasonlost.xsl"/>-->


   <!-- HTML FILE -->
   <xsl:template match="/">
      
              <fo:block-container>
                  <xsl:call-template name="creta-structure">
                      <xsl:with-param name="parm-internal-app-style" select="$internal-app-style" tunnel="yes"/>
                      <xsl:with-param name="parm-external-app-style" select="$external-app-style" tunnel="yes"/>
                      <xsl:with-param name="parm-edn-structure" select="$edn-structure" tunnel="yes"/>
                      <xsl:with-param name="parm-edition-type" select="$edition-type" tunnel="yes"/>
                      <xsl:with-param name="parm-hgv-gloss" select="$hgv-gloss" tunnel="yes"/>
                      <xsl:with-param name="parm-leiden-style" select="$leiden-style" tunnel="yes"/>
                      <xsl:with-param name="parm-line-inc" select="$line-inc" tunnel="yes" as="xs:double"/>
                      <xsl:with-param name="parm-verse-lines" select="$verse-lines" tunnel="yes"/>
                      <xsl:with-param name="parm-css-loc" select="$css-loc" tunnel="yes"/>
                  </xsl:call-template>
              </fo:block-container>
   </xsl:template>

</xsl:stylesheet>