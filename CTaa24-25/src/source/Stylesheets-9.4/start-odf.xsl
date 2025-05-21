<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0"
                xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0"
                xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0"
                exclude-result-prefixes="t" version="2.0">

  <xsl:output method="xml" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>

  <xsl:include href="global-varsandparams.xsl"/>
  <xsl:include href="odf-tpl-metadata.xsl"/>

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
  <xsl:include href="odf-tpl-linenumberingtab.xsl"/>

  <xsl:include href="tpl-reasonlost.xsl"/>
  <xsl:include href="tpl-certlow.xsl"/>
  <xsl:include href="tpl-text.xsl"/>
  <xsl:include href="functions.xsl"/>

  <xsl:template match="/">
    <office:document-content xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0" xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0" xmlns:table="urn:oasis:names:tc:opendocument:xmlns:table:1.0" xmlns:draw="urn:oasis:names:tc:opendocument:xmlns:drawing:1.0" xmlns:fo="urn:oasis:names:tc:opendocument:xmlns:xsl-fo-compatible:1.0" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:meta="urn:oasis:names:tc:opendocument:xmlns:meta:1.0" xmlns:number="urn:oasis:names:tc:opendocument:xmlns:datastyle:1.0" xmlns:svg="urn:oasis:names:tc:opendocument:xmlns:svg-compatible:1.0" xmlns:chart="urn:oasis:names:tc:opendocument:xmlns:chart:1.0" xmlns:dr3d="urn:oasis:names:tc:opendocument:xmlns:dr3d:1.0" xmlns:math="http://www.w3.org/1998/Math/MathML" xmlns:form="urn:oasis:names:tc:opendocument:xmlns:form:1.0" xmlns:script="urn:oasis:names:tc:opendocument:xmlns:script:1.0" xmlns:ooo="http://openoffice.org/2004/office" xmlns:ooow="http://openoffice.org/2004/writer" xmlns:oooc="http://openoffice.org/2004/calc" xmlns:dom="http://www.w3.org/2001/xml-events" xmlns:xforms="http://www.w3.org/2002/xforms" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:rpt="http://openoffice.org/2005/report" xmlns:of="urn:oasis:names:tc:opendocument:xmlns:of:1.2" xmlns:rdfa="http://docs.oasis-open.org/opendocument/meta/rdfa#" xmlns:field="urn:openoffice:names:experimental:ooo-ms-interop:xmlns:field:1.0" office:version="1.2">
      <office:body>
        <office:text>

          <xsl:choose>
            <xsl:when test="not(contains(/t:TEI/t:teiHeader/t:fileDesc/t:publicationStmt/t:availability/t:p, 'Duke Databank of Documentary Papyri'))">

                <xsl:call-template name="metadata_header" />
                <xsl:call-template name="metadata_footer" />
                <text:p text:style-name="Sammelbuch-Endsatz" />

            </xsl:when>
            <xsl:otherwise>

              <xsl:for-each-group select="/t:TEI/t:text/t:body/t:div[@type = 'edition']/t:ab/node()" group-starting-with="t:lb">
                <xsl:if test="string(current-group()/text()) or count(current-group()/*)">
                  <text:p text:style-name="Sammelbuch-Textzeile">
                    <xsl:apply-templates select="current-group()" />
                  </text:p>
                </xsl:if>
              </xsl:for-each-group>

              <xsl:if test=".//t:choice[child::t:sic and child::t:corr] | .//t:subst | .//t:app |        
                .//t:hi[@rend = 'diaeresis' or @rend = 'grave' or @rend = 'acute' or @rend = 'asper' or @rend = 'lenis' or @rend = 'circumflex'] |
                .//t:del[@rend='slashes' or @rend='cross-strokes'] | .//t:milestone[@rend = 'box']">

                <text:p text:style-name="Sammelbuch-Textapparat">
  
                  <xsl:call-template name="tpl-apparatus" />
  
                </text:p>

              </xsl:if>

            </xsl:otherwise>
          </xsl:choose>

        </office:text>
      </office:body>
    </office:document-content>
  </xsl:template>

</xsl:stylesheet>