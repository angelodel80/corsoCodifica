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
       <fo:root
           
           language="en"
           hyphenate="true"
           xmlns:fo="http://www.w3.org/1999/XSL/Format">
           <fo:layout-master-set>
               <fo:page-sequence-master
                   master-name="EpiDoc-master">
                   <fo:repeatable-page-master-alternatives>
                       <fo:conditional-page-master-reference master-reference="blank"
                           blank-or-not-blank="blank"/>
                       <fo:conditional-page-master-reference
                           page-position="first"
                           odd-or-even="odd"
                           master-reference="EpiDoc-chapter-first-odd"/>
                       <fo:conditional-page-master-reference
                           page-position="first"
                           odd-or-even="even"
                           master-reference="EpiDoc-chapter-first-even"/>
                       <fo:conditional-page-master-reference
                           page-position="rest"
                           odd-or-even="odd"
                           master-reference="EpiDoc-chapter-rest-odd"/>
                       <fo:conditional-page-master-reference
                           page-position="rest"
                           odd-or-even="even"
                           master-reference="EpiDoc-chapter-rest-even"/>
                   </fo:repeatable-page-master-alternatives>
               </fo:page-sequence-master>
               <fo:page-sequence-master master-name="EpiDoc-Indexes">
                   <fo:repeatable-page-master-alternatives>
                       <fo:conditional-page-master-reference master-reference="indexes-blank"
                           blank-or-not-blank="blank"/>
                       <fo:conditional-page-master-reference
                           page-position="first"
                           odd-or-even="odd"
                           master-reference="EpiDoc-Indexes-first-odd"/>
                       <fo:conditional-page-master-reference
                           page-position="first"
                           odd-or-even="even"
                           master-reference="EpiDoc-Indexes-first-even"/>
                       <fo:conditional-page-master-reference
                           page-position="rest"
                           odd-or-even="odd"
                           master-reference="EpiDoc-Indexes-rest-odd"/>
                       <fo:conditional-page-master-reference
                           page-position="rest"
                           odd-or-even="even"
                           master-reference="EpiDoc-Indexes-rest-even"/>
                   </fo:repeatable-page-master-alternatives>
               </fo:page-sequence-master>
               <fo:simple-page-master
                   
                   page-height="297mm"
                   page-width="210mm"
                   master-name="blank"
                   margin-top="45mm"
                   margin-bottom="53mm"
                   margin-left="45mm"
                   margin-right="45mm">
                   <fo:region-body
                       margin-top="37.5pt"
                       margin-bottom="37.5pt" />
                   
               </fo:simple-page-master>
               <fo:simple-page-master
                   
                   page-height="297mm"
                   page-width="210mm"
                   master-name="indexes-blank"
                   margin-top="45mm"
                   margin-bottom="53mm"
                   margin-left="45mm"
                   margin-right="45mm">
                   <fo:region-body
                       margin-top="37.5pt"
                       margin-bottom="37.5pt" />
                   
               </fo:simple-page-master>
               <fo:simple-page-master
                   
                   page-height="297mm"
                   page-width="210mm"
                   master-name="EpiDoc-Indexes-rest-odd"
                   margin-top="45mm"
                   margin-bottom="53mm"
                   margin-left="45mm"
                   margin-right="45mm">
                   <fo:region-body
                       margin-top="37.5pt"
                       margin-bottom="37.5pt"
                       column-count="2" column-gap="10mm" />
                   <fo:region-before
                       region-name="rest-region-before-odd"
                       extent="25pt"/>
                   <fo:region-after
                       region-name="rest-region-after-odd"
                       extent="12.5pt"/>
               </fo:simple-page-master>
               <fo:simple-page-master
                   
                   page-height="297mm"
                   page-width="210mm"
                   master-name="EpiDoc-Indexes-rest-even"
                   margin-top="45mm"
                   margin-bottom="53mm"
                   margin-left="45mm"
                   margin-right="45mm">
                   <fo:region-body
                       margin-top="37.5pt"
                       margin-bottom="37.5pt"
                       column-count="2" column-gap="10mm" />
                   <fo:region-before
                       region-name="rest-region-before-even"
                       extent="25pt"/>
                   <fo:region-after
                       region-name="rest-region-after-even"
                       extent="12.5pt"/>
               </fo:simple-page-master>
               <fo:simple-page-master
                   
                   page-height="297mm"
                   page-width="210mm"
                   master-name="EpiDoc-Indexes-first-even"
                   margin-top="45mm"
                   margin-bottom="53mm"
                   margin-left="45mm"
                   margin-right="45mm">
                   <fo:region-body
                       margin-top="37.5pt"
                       margin-bottom="37.5pt"
                       column-count="2" column-gap="10mm" />
                   
                   <fo:region-after
                       extent="25pt"/>
               </fo:simple-page-master>
               <fo:simple-page-master
                   
                   page-height="297mm"
                   page-width="210mm"
                   master-name="EpiDoc-Indexes-first-odd"
                   margin-top="45mm"
                   margin-bottom="53mm"
                   margin-left="45mm"
                   margin-right="45mm">
                   <fo:region-body
                       margin-top="37.5pt"
                       margin-bottom="37.5pt"
                       column-count="2" column-gap="10mm" />
                   <fo:region-before
                       region-name="rest-region-before-first"
                       extent="25pt"/>
                   <fo:region-after
                       region-name="rest-region-after-first"
                       extent="12.5pt"/>
               </fo:simple-page-master>
               <fo:simple-page-master
                   page-height="297mm"
                   page-width="210mm"
                   master-name="EpiDoc-chapter-first-odd"
                   margin-top="45mm"
                   margin-bottom="53mm"
                   margin-left="45mm"
                   margin-right="45mm">
                   <fo:region-body
                       
                       margin-top="37.5pt"
                       margin-bottom="37.5pt"/>
                   <fo:region-before
                       region-name="rest-region-before-first"
                       extent="25pt"/>
                   <fo:region-after
                       region-name="rest-region-after-first"
                       extent="12.5pt"/>
               </fo:simple-page-master>
               <fo:simple-page-master
                   page-height="297mm"
                   page-width="210mm"
                   master-name="EpiDoc-chapter-first-even"
                   margin-top="45mm"
                   margin-bottom="53mm"
                   margin-left="45mm"
                   margin-right="45mm">
                   <fo:region-body
                       margin-top="37.5pt"
                       margin-bottom="37.5pt"/>
                   <fo:region-after
                       extent="25pt"/>
               </fo:simple-page-master>
               <fo:simple-page-master
                   page-height="297mm"
                   page-width="210mm"
                   master-name="EpiDoc-chapter-rest-odd"
                   margin-top="45mm"
                   margin-bottom="53mm"
                   margin-left="45mm"
                   margin-right="45mm">
                   <fo:region-body
                       margin-top="37.5pt"
                       margin-bottom="37.5pt"/>
                   <fo:region-before
                       region-name="rest-region-before-odd"
                       extent="25pt"/>
                   <fo:region-after
                       region-name="rest-region-after-odd"
                       extent="12.5pt"/>
               </fo:simple-page-master>
               <fo:simple-page-master
                   page-height="297mm"
                   page-width="210mm"
                   master-name="EpiDoc-chapter-rest-even"
                   margin-top="45mm"
                   margin-bottom="53mm"
                   margin-left="45mm"
                   margin-right="45mm">
                   <fo:region-body
                       margin-top="37.5pt"
                       margin-bottom="37.5pt"/>
                   <fo:region-before
                       region-name="rest-region-before-even"
                       extent="25pt"/>
                   <fo:region-after
                       region-name="rest-region-after-even"
                       extent="12.5pt"/>
               </fo:simple-page-master>
           </fo:layout-master-set>
           <fo:page-sequence
               master-reference="EpiDoc-master">
               <fo:static-content
                   flow-name="rest-region-before-odd">
                   <fo:block-container
                       height="100%"
                       display-align="center">
                       <fo:block
                           font-family="Cardo"
                           font-size="9px"
                           text-align="center"
                           >Iscrizioni</fo:block>
                   </fo:block-container>
               </fo:static-content>
               <fo:static-content
                   flow-name="rest-region-before-even">
                   <fo:block-container
                       height="100%"
                       display-align="center">
                       <fo:block
                           font-family="Cardo"
                           font-size="9px"
                           text-align="center"
                           >Iscrizioni</fo:block>
                   </fo:block-container>
               </fo:static-content>
               <fo:static-content
                   flow-name="rest-region-after-first">
                   <fo:table>
                       <fo:table-column
                           column-width="30%"/>
                       <fo:table-column
                           column-width="40%"/>
                       <fo:table-column
                           column-width="30%"/>
                       
                       <fo:table-body>
                           <fo:table-row>
                               <fo:table-cell><fo:block
                                   font-size="9pt"
                                   font-family="Cardo"
                                   text-align="left"></fo:block>
                               </fo:table-cell>
                               <fo:table-cell>
                                   <fo:block
                                       text-align="center"
                                       font-size="9pt"
                                       font-family="Cardo"></fo:block>
                               </fo:table-cell>
                               <fo:table-cell>
                                   <fo:block
                                       text-align="right"
                                       font-size="9pt"
                                       font-family="Cardo">
                                       <!--titoletto in cima alla pagina-->
                                   </fo:block>
                               </fo:table-cell>
                           </fo:table-row>
                       </fo:table-body>
                   </fo:table>
               </fo:static-content>
               <fo:static-content
                   flow-name="rest-region-after-odd">
                   <fo:table>
                       <fo:table-column
                           column-width="30%"/>
                       <fo:table-column
                           column-width="40%"/>
                       <fo:table-column
                           column-width="30%"/>
                       
                       <fo:table-body>
                           <fo:table-row>
                               <fo:table-cell>
                                   <fo:block
                                       text-align="right"></fo:block>
                               </fo:table-cell>
                               <fo:table-cell>
                                   <fo:block
                                       text-align="center"
                                       font-size="9pt"
                                       font-family="Cardo"><fo:page-number/></fo:block>
                               </fo:table-cell>
                               <fo:table-cell><fo:block
                                   font-size="9pt"
                                   font-family="Cardo"
                                   text-align="right">
                                   <!--titoletto in cima alla pagina-->
                               </fo:block>
                               </fo:table-cell>
                           </fo:table-row>
                       </fo:table-body>
                   </fo:table>
               </fo:static-content>
               <fo:static-content
                   flow-name="rest-region-after-even">
                   <fo:table>
                       <fo:table-column
                           column-width="30%"/>
                       <fo:table-column
                           column-width="40%"/>
                       <fo:table-column
                           column-width="30%"/>
                       
                       <fo:table-body>
                           <fo:table-row>
                               <fo:table-cell>
                                   <fo:block
                                       font-size="9pt"
                                       font-family="Cardo"
                                       text-align="left">
                                       <!--titoletto in cima alla pagina-->
                                   </fo:block>
                               </fo:table-cell>
                               <fo:table-cell>
                                   <fo:block
                                       font-size="9pt"
                                       font-family="Cardo"
                                       text-align="center"><fo:page-number/></fo:block>
                               </fo:table-cell>  
                               <fo:table-cell>
                                   <fo:block
                                       text-align="left">
                                       
                                   </fo:block>
                               </fo:table-cell>
                               
                           </fo:table-row>
                       </fo:table-body>
                   </fo:table>
               </fo:static-content>
               <fo:static-content
                   flow-name="xsl-footnote-separator">
                   <fo:block space-before="5mm" space-after="5mm">
                       <fo:leader leader-length="30%" rule-thickness="0pt"/>
                   </fo:block>
               </fo:static-content>
               <fo:flow
                   flow-name="xsl-region-body"
                   font-size="10.5pt"
                   line-height="12.5pt"
                   font-family="Ludolfus"
                   text-align="justify"
                   hyphenate="true">
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
                      <xsl:with-param name="parm-glyph-variant" select="$glyph-variant" tunnel="yes"/>
                  </xsl:call-template>
              </fo:block-container>
               </fo:flow>
           </fo:page-sequence>
       </fo:root>
   </xsl:template>

</xsl:stylesheet>