<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:t="http://www.tei-c.org/ns/1.0"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  exclude-result-prefixes="t" version="2.0">

  <xsl:output method="text" encoding="UTF-8" indent="no" omit-xml-declaration="yes"/>

  <xsl:include href="global-varsandparams.xsl"/>
  
  <xsl:include href="txt-teiab.xsl"/>
  <xsl:include href="txt-teiapp.xsl"/>
  <xsl:include href="txt-teidiv.xsl"/>
  <xsl:include href="txt-teidivedition.xsl"/>
  <xsl:include href="txt-teig.xsl"/>
  <xsl:include href="txt-teigap.xsl"/>
  <xsl:include href="txt-teihead.xsl"/>
  <xsl:include href="txt-teilb.xsl"/>
  <xsl:include href="txt-teilgandl.xsl"/>
  <xsl:include href="txt-teilistanditem.xsl"/>
  <xsl:include href="txt-teilistbiblandbibl.xsl"/>
  <xsl:include href="txt-teimilestone.xsl"/>
  <xsl:include href="txt-teinote.xsl"/>
  <xsl:include href="txt-teip.xsl"/>
  <xsl:include href="txt-teispace.xsl"/>
  <xsl:include href="txt-teisupplied.xsl"/>
  <xsl:include href="txt-teiref.xsl"/>
  
  <xsl:include href="teiabbrandexpan.xsl"/>
  <xsl:include href="teiaddanddel.xsl"/>
  <xsl:include href="teicertainty.xsl"/>
  <xsl:include href="teichoice.xsl"/>
  <xsl:include href="teihandshift.xsl"/>
  <xsl:include href="teiheader.xsl"/>
  <xsl:include href="teihi.xsl"/>
  <xsl:include href="teimilestone.xsl"/>
  <xsl:include href="teinum.xsl"/>
  <xsl:include href="teiorig.xsl"/>
  <xsl:include href="teiorigandreg.xsl"/>
  <xsl:include href="teiq.xsl"/>
  <xsl:include href="teiseg.xsl"/>
  <xsl:include href="teisicandcorr.xsl"/>
  <xsl:include href="teispace.xsl"/>
  <xsl:include href="teisupplied.xsl"/>
  <xsl:include href="teisurplus.xsl"/>
  <xsl:include href="teiunclear.xsl"/>
  
  <xsl:include href="txt-tpl-apparatus.xsl"/>
  <xsl:include href="txt-tpl-linenumberingtab.xsl"/>
  
  <xsl:include href="tpl-certlow.xsl"/>
  <xsl:include href="tpl-text.xsl"/>
  <xsl:include href="functions.xsl"/>
  <xsl:include href="txt-tpl-sqbrackets.xsl"/>


  <xsl:template match="/">
    <!-- No templates for metadata just yet -->
    
   <!-- <xsl:apply-templates/>-->
    
    <xsl:variable name="main-text">
      <xsl:apply-templates>
        <xsl:with-param name="parm-internal-app-style" select="$internal-app-style" tunnel="yes"/>
        <xsl:with-param name="parm-external-app-style" select="$external-app-style" tunnel="yes"/>
        <xsl:with-param name="parm-edn-structure" select="$edn-structure" tunnel="yes"/>
        <xsl:with-param name="parm-edition-type" select="$edition-type" tunnel="yes"/>
        <xsl:with-param name="parm-hgv-gloss" select="$hgv-gloss" tunnel="yes"/>
        <xsl:with-param name="parm-leiden-style" select="$leiden-style" tunnel="yes"/>
        <xsl:with-param name="parm-line-inc" select="$line-inc" tunnel="yes" as="xs:double"/>
        <xsl:with-param name="parm-verse-lines" select="$verse-lines" tunnel="yes"/>
        <xsl:with-param name="parm-glyph-variant" select="$glyph-variant" tunnel="yes"/>
      </xsl:apply-templates>
    </xsl:variable>
        
    <!-- Templates found in txt-tpl-sqbrackets.xsl -->
    <xsl:for-each select="$main-text">
      <xsl:call-template name="sqbrackets">
        <xsl:with-param name="parm-internal-app-style" select="$internal-app-style" tunnel="yes"/>
        <xsl:with-param name="parm-external-app-style" select="$external-app-style" tunnel="yes"/>
        <xsl:with-param name="parm-edn-structure" select="$edn-structure" tunnel="yes"/>
        <xsl:with-param name="parm-edition-type" select="$edition-type" tunnel="yes"/>
        <xsl:with-param name="parm-hgv-gloss" select="$hgv-gloss" tunnel="yes"/>
        <xsl:with-param name="parm-leiden-style" select="$leiden-style" tunnel="yes"/>
        <xsl:with-param name="parm-line-inc" select="$line-inc" tunnel="yes" as="xs:double"/>
        <xsl:with-param name="parm-verse-lines" select="$verse-lines" tunnel="yes"/>
        <xsl:with-param name="parm-glyph-variant" select="$glyph-variant" tunnel="yes"/>
        
      </xsl:call-template>
    </xsl:for-each>
    
  </xsl:template>
  
</xsl:stylesheet>