<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:t="http://www.tei-c.org/ns/1.0" 
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   exclude-result-prefixes="t" version="2.0">
   <xsl:output method="html" encoding="UTF-8"/>

    <xsl:include href="global-varsandparams.xsl"/>

   <!-- html related stylesheets, these may import tei{element} stylesheets if relevant eg. htm-teigap and teigap -->
   <xsl:include href="htm-teiab.xsl"/>
   <xsl:include href="htm-teiaddanddel.xsl"/>
   <xsl:include href="htm-teiapp.xsl"/>
   <xsl:include href="htm-teidiv.xsl"/>
   <xsl:include href="htm-teidivedition.xsl"/>
   <xsl:include href="htm-teidivapparatus.xsl"/>
   <xsl:include href="htm-teifacsimile.xsl"/>
   <xsl:include href="htm-teiforeign.xsl"/>
   <xsl:include href="htm-teifigure.xsl"/>
   <xsl:include href="htm-teig.xsl"/>
   <xsl:include href="htm-teigap.xsl"/>
   <xsl:include href="htm-teihead.xsl"/>
   <xsl:include href="htm-teihi.xsl"/>
   <xsl:include href="htm-teilb.xsl"/>
   <xsl:include href="htm-teilgandl.xsl"/>
   <xsl:include href="htm-teilistanditem.xsl"/>
   <xsl:include href="htm-teilistbiblandbibl.xsl"/>
   <xsl:include href="htm-teimilestone.xsl"/>
   <xsl:include href="htm-teibibl.xsl"/>
   <xsl:include href="htm-teinote.xsl"/>
   <xsl:include href="htm-teinum.xsl"/>
   <xsl:include href="htm-teip.xsl"/>
   <xsl:include href="htm-teiseg.xsl"/>
   <xsl:include href="htm-teispace.xsl"/>
   <xsl:include href="htm-teisupplied.xsl"/>
   <xsl:include href="htm-teiterm.xsl"/>
   <xsl:include href="htm-teiref.xsl"/>

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

   <!-- html related stylesheets for named templates -->
   <xsl:include href="htm-tpl-cssandscripts.xsl"/>
   <xsl:include href="htm-tpl-apparatus.xsl"/>
   <xsl:include href="htm-tpl-lang.xsl"/>
   <xsl:include href="htm-tpl-metadata.xsl"/>
   <xsl:include href="htm-tpl-license.xsl"/>
   <xsl:include href="htm-tpl-sqbrackets.xsl"/>
   
   <!-- named templates for localized layout/structure (aka "metadata") -->
    <xsl:include href="htm-tpl-structure.xsl"/>
    <xsl:include href="htm-tpl-struct-creta.xsl"/>
    <xsl:include href="htm-tpl-struct-dol.xsl"/>
    <xsl:include href="htm-tpl-struct-edak.xsl"/>
    <xsl:include href="htm-tpl-struct-inslib.xsl"/>
    <xsl:include href="htm-tpl-struct-iospe.xsl"/>
    <xsl:include href="htm-tpl-struct-sample.xsl"/>
    <xsl:include href="htm-tpl-struct-sigidoc.xsl"/>
    <xsl:include href="htm-tpl-struct-ecg.xsl"/>

    <!-- global named templates with no html, also used by start-txt  -->
    <xsl:include href="tpl-certlow.xsl"/>
    <xsl:include href="tpl-text.xsl"/>
    <xsl:include href="functions.xsl"/>



   <!-- HTML FILE -->
   <xsl:template match="/">
      <xsl:choose>
         <xsl:when test="$edn-structure = 'london'">
            <!-- this and other structure templates found in htm-tpl-struct-*.xsl -->
             <xsl:call-template name="london-structure">
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
         </xsl:when>
          <xsl:when test="$edn-structure = 'edak'">
              <xsl:call-template name="edak-structure">
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
          </xsl:when>
          <xsl:when test="$edn-structure = 'inslib'">
              <xsl:call-template name="inslib-structure">
                  <xsl:with-param name="parm-internal-app-style" select="$internal-app-style" tunnel="yes"/>
                  <xsl:with-param name="parm-external-app-style" select="$external-app-style" tunnel="yes"/>
                  <xsl:with-param name="parm-edn-structure" select="$edn-structure" tunnel="yes"/>
                  <xsl:with-param name="parm-edition-type" select="$edition-type" tunnel="yes"/>
                  <xsl:with-param name="parm-hgv-gloss" select="$hgv-gloss" tunnel="yes"/>
                  <xsl:with-param name="parm-leiden-style" select="$leiden-style" tunnel="yes"/>
                  <xsl:with-param name="parm-line-inc" select="$line-inc" tunnel="yes" as="xs:double"/>
                  <xsl:with-param name="parm-verse-lines" select="$verse-lines" tunnel="yes"/>
                  <xsl:with-param name="parm-css-loc" select="$css-loc" tunnel="yes"/>
                  <xsl:with-param name="parm-bib" select="$bibliography" tunnel="yes"/>
                  <xsl:with-param name="parm-bibloc" select="$localbibl" tunnel="yes"/>
                  <xsl:with-param name="parm-zoteroUorG" select="$ZoteroUorG" tunnel="yes"/>
                  <xsl:with-param name="parm-zoteroKey" select="$ZoteroKey" tunnel="yes"/>
                  <xsl:with-param name="parm-zoteroNS" select="$ZoteroNS" tunnel="yes"/>
                  <xsl:with-param name="parm-zoteroStyle" select="$ZoteroStyle" tunnel="yes"/>
              </xsl:call-template>
          </xsl:when>
          <xsl:when test="$edn-structure = 'dol'">
              <xsl:call-template name="dol-structure">
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
          </xsl:when>
         <xsl:when test="$edn-structure = 'iospe'">
             <xsl:call-template name="iospe-structure">
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
         </xsl:when>
          <xsl:when test="$edn-structure = 'sample'">
              <xsl:call-template name="sample-structure"> <!-- htm-tpl-struct-sample.xsl -->
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
          </xsl:when>
          <xsl:when test="$edn-structure = 'sigidoc'">
              <xsl:call-template name="sigidoc-structure">
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
          </xsl:when>
         <xsl:when test="$edn-structure = 'ddbdp'">
            <div>
                <xsl:call-template name="default-body-structure">
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
            </div>
         </xsl:when>
         <xsl:when test="$edn-structure = 'ecg'">
             <div>
                 <xsl:call-template name="ecg-structure">
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
             </div>
         </xsl:when>
          <xsl:when test="$edn-structure = 'creta'">
              <div>
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
              </div>
          </xsl:when>
          <xsl:otherwise>
             <xsl:call-template name="default-structure">
                 <xsl:with-param name="parm-internal-app-style" select="$internal-app-style" tunnel="yes"/>
                 <xsl:with-param name="parm-external-app-style" select="$external-app-style" tunnel="yes"/>
                <xsl:with-param name="parm-edn-structure" select="$edn-structure" tunnel="yes"/>
                <xsl:with-param name="parm-edition-type" select="$edition-type" tunnel="yes"/>
                <xsl:with-param name="parm-hgv-gloss" select="$hgv-gloss" tunnel="yes"/>
                <xsl:with-param name="parm-leiden-style" select="$leiden-style" tunnel="yes"/>
                <xsl:with-param name="parm-line-inc" select="$line-inc" tunnel="yes" as="xs:double"/>
                 <xsl:with-param name="parm-verse-lines" select="$verse-lines" tunnel="yes"/>
                 <xsl:with-param name="parm-css-loc" select="$css-loc" tunnel="yes"/>
                 <xsl:with-param name="parm-glyph-variant" select="$glyph-variant" tunnel="yes"/>
            </xsl:call-template>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

</xsl:stylesheet>
