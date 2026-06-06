<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:i18n="http://apache.org/cocoon/i18n/2.1"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:kiln="http://www.kcl.ac.uk/artshums/depts/ddh/kiln/ns/1.0"
  xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t"
  xmlns:fn="http://www.w3.org/2005/xpath-functions"
  version="2.0">
  <!-- Contains named templates for InsLib file structure (aka "metadata" aka "supporting data") -->
  
  <!-- Called from htm-tpl-structure.xsl -->
  
  <xsl:variable name="inslib-corpus">
    <xsl:choose>
      <xsl:when test="starts-with(//t:publicationStmt/t:idno[@type='filename']/text(), 'IRT')">IRT</xsl:when>
      <xsl:when test="starts-with(//t:publicationStmt/t:idno[@type='filename']/text(), 'IGCyr') or starts-with(//t:publicationStmt/t:idno[@type='filename']/text(), 'GVCyr')">IGCyr</xsl:when>
      <xsl:when test="number(substring(//t:publicationStmt/t:idno[@type='filename']/text(),2,5))">IRCyr</xsl:when>
    </xsl:choose>
  </xsl:variable>
  
  <xsl:template name="inslib-body-structure">
    <div id="full-edition">
      <div id="edition-text">
        <xsl:call-template name="inslib-navigation"/>
        <xsl:if test="$inslib-corpus='IGCyr'">
          <p>EpiDoc XML: 
            <a target="_blank" href="{lower-case(string(//t:publicationStmt//t:idno[@type='filename']))}.xml">
              <xsl:value-of select="//t:publicationStmt//t:idno[@type='filename']"/>
            </a>
            <xsl:if test="//t:publicationStmt//t:idno[@type='TM']">
              <br/>Trismegistos ID: 
              <a target="_blank" href="https://www.trismegistos.org/text/{//t:publicationStmt//t:idno[@type='TM']}">
                <xsl:value-of select="//t:publicationStmt//t:idno[@type='TM']"/>
              </a>
            </xsl:if>
          </p>
        </xsl:if>
        
        <xsl:if test="$inslib-corpus='IGCyr'"><h3>Source description</h3></xsl:if>
        <div id="source-description">
          <xsl:if test="//t:support">
            <p><b><xsl:value-of select="if ($inslib-corpus='IGCyr') then 'Support: ' else 'Description: '"/></b>
              <xsl:choose>
                <xsl:when test="//t:support/t:p/node()">
                  <xsl:apply-templates select="//t:support/t:p/node()" mode="inslib-dimensions"/>
                </xsl:when>
                <xsl:when test="//t:support//node()">
                  <xsl:apply-templates select="//t:support" mode="inslib-dimensions"/>
                </xsl:when>
                <xsl:otherwise>Unknown</xsl:otherwise>
              </xsl:choose>
            </p>
          </xsl:if>
          
          <xsl:if test="//t:layoutDesc">
            <p><b><xsl:value-of select="if ($inslib-corpus='IGCyr') then 'Layout: ' else 'Text: '"/></b>
              <xsl:choose>
                <xsl:when test="//t:layoutDesc/t:layout//node()">
                  <xsl:apply-templates select="//t:layoutDesc/t:layout" mode="inslib-dimensions"/>
                </xsl:when>
                <xsl:otherwise>Unknown.</xsl:otherwise>
              </xsl:choose>
            </p>
          </xsl:if>
          
          <xsl:if test="//t:handDesc">
            <p><b>Letters: </b>
              <xsl:if test="//t:handDesc/t:handNote/node()">
                <xsl:apply-templates select="//t:handDesc/t:handNote"/>
              </xsl:if>
            </p>
          </xsl:if>
          
          <xsl:if test="//t:origDate">
            <p><b>Date: </b>
              <xsl:choose>
                <xsl:when test="//t:origin/t:origDate/node()">
                  <xsl:apply-templates select="//t:origin/t:origDate"/>
                  <xsl:if test="//t:origin/t:origDate[@evidence]">
                    <xsl:text> (</xsl:text>
                    <xsl:for-each select="tokenize(//t:origin/t:origDate/@evidence,' ')">
                      <xsl:value-of select="translate(translate(.,'-',' '),',','')"/>
                      <xsl:if test="position()!=last()"><xsl:text>, </xsl:text></xsl:if>
                    </xsl:for-each>
                    <xsl:text>)</xsl:text>
                  </xsl:if>
                </xsl:when>
                <xsl:otherwise>Unknown.</xsl:otherwise>
              </xsl:choose>
            </p>
          </xsl:if>
          
          <xsl:if test="//t:provenance">
            <p><b>Findspot: </b>
              <xsl:choose>
                <xsl:when test="//t:provenance[@type='found'][string(translate(normalize-space(.),' ',''))]">
                  <xsl:apply-templates select="//t:provenance[@type='found']//t:p/node()" mode="inslib-placename"/>
                </xsl:when>
                <xsl:otherwise>Unknown</xsl:otherwise>
              </xsl:choose>
            </p>
          </xsl:if>
          
          <xsl:if test="//t:origPlace">
            <p><b><xsl:value-of select="if ($inslib-corpus='IGCyr') then 'Place of origin: ' else 'Original location: '"/></b>
              <xsl:choose>
                <xsl:when test="//t:origin/t:origPlace/node()">
                  <xsl:apply-templates select="//t:origin/t:origPlace" mode="inslib-placename"/>
                </xsl:when>
                <xsl:otherwise>Unknown</xsl:otherwise>
              </xsl:choose>
            </p>
          </xsl:if>
          
          <xsl:if test="//t:provenance[@type!='found']//text()|//t:repository//text()">
            <p><b>Last recorded location: </b>
              <xsl:if test="//t:repository and $inslib-corpus='IGCyr'">
                <xsl:apply-templates select="//t:repository" mode="inslib-placename"/>
                <!-- Named template found below. -->
                <xsl:call-template name="inslib-invno"/>
                <xsl:text>. </xsl:text>
              </xsl:if>
              <xsl:for-each select="//t:provenance[@type!='found']">
                <xsl:apply-templates mode="inslib-placename"/>
                <xsl:if test="position()!=last()"><xsl:text> </xsl:text></xsl:if>
              </xsl:for-each>
              <xsl:if test="$inslib-corpus!='IGCyr'">
                <xsl:if test="//t:repository[@ref] and not(//t:provenance[@type='observed'])">
                  <xsl:apply-templates select="//t:repository[@ref][1]" mode="inslib-placename"/>
                </xsl:if>
                <!-- Named template found below. -->
                <xsl:call-template name="inslib-invno"/>
              </xsl:if>
            </p>
          </xsl:if>
          
          <xsl:if test="//t:creation and $inslib-corpus='IGCyr'">
            <p><b>Text constituted from: </b>
            <xsl:apply-templates select="//t:creation"/></p>
          </xsl:if>
        </div>
        
        <xsl:if test="//t:div[@type='bibliography'] and $inslib-corpus='IGCyr'">
          <h3>Bibliography</h3>
          <p><xsl:apply-templates select="//t:div[@type='bibliography']/t:p/node()"/></p>
        </xsl:if>
        
        <xsl:if test="//t:div[@type='edition']">
          <xsl:if test="$inslib-corpus='IGCyr'"><h3>Text</h3></xsl:if>
          <div class="section-container tabs" data-section="tabs">
            <section>
              <p class="title" data-section-title="data-section-title"><a href="#">Interpretive</a></p>
              <div class="content" id="edition" data-section-content="data-section-content">
                <!-- Edited text output -->
                <xsl:variable name="edtxt">
                  <xsl:apply-templates select="//t:div[@type='edition']">
                    <xsl:with-param name="parm-edition-type" select="'interpretive'" tunnel="yes"/>
                  </xsl:apply-templates>
                </xsl:variable>
                <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
                <xsl:apply-templates select="$edtxt" mode="sqbrackets"/>
              </div>
            </section>
            <xsl:if test="$inslib-corpus='IGCyr' and //t:l">
              <section>
                <p class="title" data-section-title="data-section-title"><a href="#">Metrical</a></p>
                <div class="content" id="edition" data-section-content="data-section-content">
                  <!-- Edited text output -->
                  <xsl:variable name="edtxt">
                    <xsl:apply-templates select="//t:div[@type='edition']">
                      <xsl:with-param name="parm-edition-type" select="'interpretive'" tunnel="yes"/>
                      <xsl:with-param name="parm-verse-lines" select="'on'" tunnel="yes"/>
                    </xsl:apply-templates>
                  </xsl:variable>
                  <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
                  <xsl:apply-templates select="$edtxt" mode="sqbrackets"/>
                </div>
              </section>
            </xsl:if>
            <section>
              <p class="title" data-section-title="data-section-title"><a href="#">Diplomatic</a></p>
              <div class="content" id="diplomatic" data-section-content="data-section-content">
                <!-- Edited text output -->
                <xsl:variable name="edtxt">
                  <xsl:apply-templates select="//t:div[@type='edition']">
                    <xsl:with-param name="parm-edition-type" select="'diplomatic'" tunnel="yes"/>
                  </xsl:apply-templates>
                </xsl:variable>
                <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
                <xsl:apply-templates select="$edtxt" mode="sqbrackets"/>
              </div>
            </section>
          </div>
        </xsl:if>
        
        <xsl:if test="//t:div[@type='apparatus']//node()">
          <div id="apparatus">
            <xsl:if test="$inslib-corpus='IGCyr'"><h3>Apparatus</h3></xsl:if>
            <!-- Apparatus text output -->
            <xsl:variable name="apptxt">
              <xsl:apply-templates select="//t:div[@type='apparatus']"/>
            </xsl:variable>
            <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
            <xsl:apply-templates select="$apptxt" mode="sqbrackets"/>
          </div>
        </xsl:if>
        
        <xsl:if test="//t:div[@type='translation']//t:p//node()">
          <div id="translation">
            <xsl:variable name="editor" select="//t:teiHeader/t:fileDesc/t:titleStmt/t:editor"/>
            <xsl:for-each select="//t:div[@type='translation'][not(descendant::t:div[@type='translation'])]">
              <h3>
                <xsl:variable name="transl_lang">
                  <xsl:choose>
                    <xsl:when test="@xml:lang='en'">English</xsl:when>
                    <xsl:when test="@xml:lang='fr'">French</xsl:when>
                    <xsl:when test="@xml:lang='it'">Italian</xsl:when>
                    <xsl:when test="@xml:lang='de'">German</xsl:when>
                    <xsl:when test="@xml:lang='la'">Latin</xsl:when>
                    <xsl:when test="@xml:lang='ar'">Arabic</xsl:when>
                    <!-- add here any needed language -->
                  </xsl:choose>
                </xsl:variable>
                <xsl:choose>
                  <xsl:when test="$transl_lang!=''">
                    <xsl:value-of select="$transl_lang"/>
                    <xsl:text> translation</xsl:text>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:text>Translation</xsl:text>
                    <xsl:if test="@xml:lang">
                      <xsl:text> (</xsl:text>
                      <xsl:value-of select="@xml:lang"/>
                      <xsl:text>)</xsl:text>
                    </xsl:if>
                  </xsl:otherwise>
                </xsl:choose>
              </h3>
              <xsl:if test="@source">
                <xsl:variable name="source-id" select="substring-after(@source, '#')"/>
                <p><xsl:text>Translation source: </xsl:text> 
                  <!-- if you are running this template outside EFES, change the path to the bibliography authority list accordingly -->
                  <xsl:variable name="bibliography-al" select="concat('file:',system-property('user.dir'),'/webapps/ROOT/content/xml/authority/bibliography.xml')"/>
                  <xsl:choose>
                    <xsl:when test="doc-available($bibliography-al) = fn:true() and document($bibliography-al)//t:bibl[@xml:id=$source-id][not(@sameAs)]">
                      <xsl:variable name="source" select="document($bibliography-al)//t:bibl[@xml:id=$source-id][not(@sameAs)]"/>
                      <a href="{concat('../concordance/bibliography/',$source-id,'.html')}" target="_blank">
                        <xsl:choose>
                          <xsl:when test="$source//t:bibl[@type='abbrev']">
                            <xsl:apply-templates select="$source//t:bibl[@type='abbrev'][1]"/>
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:choose>
                              <xsl:when test="$source[ancestor::t:div[@xml:id='authored_editions']] and $inslib-corpus='IGCyr'">
                                <xsl:for-each select="$source//t:name[@type='surname'][not(parent::*/preceding-sibling::t:title)]">
                                  <xsl:apply-templates select="."/>
                                  <xsl:if test="position()!=last()"> – </xsl:if>
                                </xsl:for-each>
                                <xsl:text> </xsl:text>
                                <xsl:apply-templates select="$source//t:date"/>
                              </xsl:when>
                              <xsl:when test="$source[ancestor::t:div[@xml:id='series_collections']] and $inslib-corpus='IGCyr'">
                                <i><xsl:value-of select="$source/@xml:id"/></i>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:apply-templates select="$source-id"/>
                              </xsl:otherwise>
                            </xsl:choose>
                          </xsl:otherwise>
                        </xsl:choose>
                      </a>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="$source-id"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </p>
              </xsl:if>
              <xsl:if test="@resp">
                <xsl:variable name="resp-id" select="substring-after(@resp, '#')"/>
                <xsl:variable name="resp" select="$editor[@xml:id=$resp-id]"/>
                <p><xsl:text>Translation by: </xsl:text> 
                  <xsl:choose>
                    <xsl:when test="$resp">
                      <xsl:value-of select="$resp"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="$resp-id"/> 
                    </xsl:otherwise>
                  </xsl:choose>
                </p>
              </xsl:if>
              <!-- Translation text output -->
              <xsl:variable name="transtxt">
                <xsl:for-each select=".//t:p">
                  <xsl:choose>
                    <xsl:when test="ancestor::t:div[@xml:lang='ar']">
                      <p class="rtl"><xsl:apply-templates select="node()"/></p>
                    </xsl:when>
                    <xsl:otherwise>
                      <p><xsl:apply-templates select="node()"/></p>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:for-each>
              </xsl:variable>
              <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
              <xsl:apply-templates select="$transtxt" mode="sqbrackets"/>
            </xsl:for-each>
          </div>
        </xsl:if>
        
        <xsl:if test="//t:div[@type='commentary']//t:p//node() and not(contains(//t:div[@type='commentary'][1]/t:p[1], 'No comment'))">
          <div id="commentary">
            <h3>Commentary</h3>
            <!-- Commentary text output -->
            <xsl:variable name="commtxt">
              <xsl:apply-templates select="//t:div[@type='commentary']//t:p"/>
            </xsl:variable>
            <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
            <xsl:apply-templates select="$commtxt" mode="sqbrackets"/>
          </div>
        </xsl:if>
        
        <xsl:if test="//t:div[@type='bibliography'] and $inslib-corpus!='IGCyr'">
          <p><b>Bibliography: </b>
            <xsl:apply-templates select="//t:div[@type='bibliography']/t:p/node()"/>
            
            <xsl:if test="//t:creation and $inslib-corpus='IRCyr'">
              <br/>
              <b>Text constituted from: </b>
              <xsl:apply-templates select="//t:creation"/>
            </xsl:if>
          </p>
        </xsl:if>
        
        <xsl:if test="$inslib-corpus='IGCyr'">
          <div id="license"><xsl:apply-templates select="//t:availability"/></div>
        </xsl:if>
      </div>
      
      <div id="edition-images-maps">
        <xsl:if test="//t:facsimile">
          <div id="images">
            <h3>Images</h3>
            <xsl:choose>
              <xsl:when test="//t:facsimile//t:graphic">
                <xsl:for-each select="//t:facsimile//t:graphic">
                  <div class="embedded_image">
                  <xsl:choose>
                    <xsl:when test="contains(@url,'http')">
                        <a href="{@url}" target="_blank">
                          <img src="{@url}" style="max-height:200px"/>
                        </a>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates select="." />
                    </xsl:otherwise>
                  </xsl:choose>
                    <p style="margin-top:5px">
                      <strong><xsl:text>Fig. </xsl:text><xsl:number value="position()" format="1" /></strong>
                      <xsl:if test="t:desc"><xsl:text>. </xsl:text><xsl:apply-templates select="t:desc" /></xsl:if>
                    </p>
                  </div>
                </xsl:for-each>
              </xsl:when>
              <xsl:otherwise>
                <xsl:for-each select="//t:facsimile[not(//t:graphic)]">
                  <p>None available.</p>
                </xsl:for-each>
              </xsl:otherwise>
            </xsl:choose>
          </div>
        </xsl:if>
          
        <xsl:if test="$inslib-corpus='IGCyr'">
          <!-- if you are running this template outside EFES, change the path to the places authority list accordingly -->
          <xsl:if test="doc-available(concat('file:',system-property('user.dir'),'/webapps/ROOT/content/xml/authority/places.xml')) = fn:true()">
            <div id="maps">
              <h3>Maps</h3>
              <div class="row map_box">
                <div id="specific_map" class="map inscription_map"></div>
                <xsl:variable name="place-name" select="//t:provenance[@type='found'][1]//t:p[1]//t:placeName[@type='ancientFindspot'][1]"/>
                <xsl:variable name="place-id" select="//t:provenance[@type='found'][1]//t:p[1]//t:placeName[@type='ancientFindspot'][1]/@key"/>
                <xsl:variable name="places-al" select="document(concat('file:',system-property('user.dir'),'/webapps/ROOT/content/xml/authority/places.xml'))//t:place[descendant::t:placeName=$place-name][1]"/>
                <xsl:variable name="counter" select="$places-al//t:note[@type='total_inscriptions']"/>
                <xsl:variable name="points" select="concat(string-join($place-name, ''), '#', string-join($counter, '') ,'@', substring-after(string-join($place-id, ''), 'slsgazetteer.org/'))"/>
                <script type="text/javascript">
                  var points = {"<xsl:value-of select="$points"/>": "<xsl:value-of select="$places-al//t:geo"/>"};
                </script>
                <script type="text/javascript" src="../../assets/scripts/maps.js"></script>
                <script type="text/javascript">
                  var mymap = L.map('specific_map', { center: [32, 22], zoom: 6, fullscreenControl: true, layers: layers });
                  L.control.layers(baseMaps, overlayMaps).addTo(mymap);
                  L.control.scale().addTo(mymap);
                  L.Control.geocoder().addTo(mymap);
                  toggle_places.addTo(mymap); 
                </script>
              </div>
              
              <div id="specific_archaeo_map" class="map">
                <xsl:variable name="findspot" select="string-join(//t:provenance[@type='found']//t:placeName, '')"/>
                <xsl:variable name="findspot-rs" select="lower-case(string-join(//t:provenance[@type='found']//t:rs, ' '))"/>
                <xsl:if test="contains($findspot, 'Apollonia')">
                  <xsl:call-template name="inslib-map"><xsl:with-param name="map_name" select="'map_Apollonia'"/></xsl:call-template>
                </xsl:if>
                <xsl:if test="contains($findspot, 'Berenike')">
                  <xsl:call-template name="inslib-map"><xsl:with-param name="map_name" select="'map_Berenike'"/></xsl:call-template>
                </xsl:if>
                <xsl:if test="$findspot='Cyrene'">
                  <xsl:call-template name="inslib-map"><xsl:with-param name="map_name" select="'map_Cyrene_general_plan'"/></xsl:call-template>
                  <xsl:if test="contains($findspot-rs, 'agora')">
                    <xsl:call-template name="inslib-map"><xsl:with-param name="map_name" select="'map_Cyrene_agora'"/></xsl:call-template>
                  </xsl:if>
                  <xsl:if test="contains($findspot-rs, 'central quarter')">
                    <xsl:call-template name="inslib-map"><xsl:with-param name="map_name" select="'map_Cyrene_central_quarter'"/></xsl:call-template>
                  </xsl:if>
                  <xsl:if test="contains($findspot-rs, 'north necropolis')">
                    <xsl:call-template name="inslib-map"><xsl:with-param name="map_name" select="'map_Cyrene_north_necropolis'"/></xsl:call-template>
                  </xsl:if>
                  <xsl:if test="contains($findspot-rs, 'of apollo')">
                    <xsl:call-template name="inslib-map"><xsl:with-param name="map_name" select="'map_Cyrene_sanctuary_of_Apollo'"/></xsl:call-template>
                  </xsl:if>
                </xsl:if>
                <xsl:if test="contains($findspot, 'Euesperides')">
                  <xsl:call-template name="inslib-map"><xsl:with-param name="map_name" select="'map_Euesperides'"/></xsl:call-template>
                </xsl:if>
                <xsl:if test="contains($findspot, 'Ptolemais')">
                  <xsl:call-template name="inslib-map"><xsl:with-param name="map_name" select="'map_Ptolemais_inner'"/></xsl:call-template>
                  <xsl:call-template name="inslib-map"><xsl:with-param name="map_name" select="'map_Ptolemais_outer'"/></xsl:call-template>
                </xsl:if>
                <xsl:if test="contains($findspot, 'Taucheira')">
                  <xsl:call-template name="inslib-map"><xsl:with-param name="map_name" select="'map_Tocra'"/></xsl:call-template>
                </xsl:if>
              </div>
            </div>
          </xsl:if>
        </xsl:if>
      </div>
    </div>
  </xsl:template>
  
  <xsl:template name="inslib-structure">
    <xsl:variable name="title">
      <xsl:call-template name="inslib-title" />
    </xsl:variable>
    
    <html>
      <head>
        <title>
          <xsl:value-of select="$title"/>
        </title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
        <!-- Found in htm-tpl-cssandscripts.xsl -->
        <xsl:call-template name="css-script"/>
      </head>
      <body>
        <h1>
          <xsl:value-of select="$title"/>
        </h1>
        <xsl:call-template name="inslib-body-structure" />
      </body>
    </html>
  </xsl:template>
  
  <xsl:template name="inslib-invno">
    <xsl:if test="//t:idno[ancestor::t:msIdentifier][translate(normalize-space(string(.)),' ','')!='']">
      <xsl:value-of select="if ($inslib-corpus='IGCyr') then ', ' else ' (Inv. no. '"/>
      <xsl:for-each select="//t:idno[ancestor::t:msIdentifier][translate(normalize-space(string(.)),' ','')!='']">
        <xsl:value-of select="."/>
        <xsl:if test="position()!=last()">
          <xsl:text>, </xsl:text>
        </xsl:if>
      </xsl:for-each>
    <xsl:if test="$inslib-corpus!='IGCyr'"><xsl:text>)</xsl:text></xsl:if>
    </xsl:if>
  </xsl:template>
  
  <xsl:template name="inslib-map">
    <xsl:param name="map_name"/>
    <!-- if you are running this template outside EFES, change the path to the images folder accordingly -->
    <xsl:variable name="images" select="concat('file:',system-property('user.dir'),'/webapps/ROOT/content/images/')"/>
    <div id="{$map_name}" class="archaeo_map">
      <h4><xsl:value-of select="translate(replace($map_name, 'map_', ''), '_', ' ')"/></h4>
      <p><a href="../texts/{$map_name}.html"><img alt="image" class="image" src="/images/{$map_name}.png"/></a></p>
    </div>
  </xsl:template>
  
  <xsl:template name="inslib-title">
    <xsl:choose>
      <xsl:when test="//t:titleStmt/t:title and $inslib-corpus='IRT'">
        <xsl:value-of select="substring-after(//t:publicationStmt/t:idno[@type='filename']/text(),'IRT')"/>
        <xsl:text>. </xsl:text>
        <xsl:apply-templates select="//t:titleStmt/t:title"/>
      </xsl:when>
      <xsl:when test="//t:titleStmt/t:title and $inslib-corpus='IGCyr'">
        <xsl:apply-templates select="//t:titleStmt/t:title"/>
      </xsl:when>
      <xsl:when test="//t:titleStmt/t:title and $inslib-corpus='IRCyr'">
        <xsl:value-of select="//t:publicationStmt/t:idno[@type='filename']/text()"/>
        <xsl:text>. </xsl:text>
        <xsl:apply-templates select="//t:titleStmt/t:title"/>
      </xsl:when>
      <xsl:when test="//t:titleStmt/t:title/node()">
        <xsl:apply-templates select="//t:titleStmt/t:title"/>
      </xsl:when>
      <xsl:when test="//t:sourceDesc//t:bibl/node()">
        <xsl:value-of select="//t:sourceDesc//t:bibl"/>
      </xsl:when>
      <xsl:when test="//t:idno[@type='filename']/text()">
        <xsl:value-of select="//t:idno[@type='filename']"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>EpiDoc example output, InsLib style</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="t:dimensions" mode="inslib-dimensions">
    <xsl:if test="//text()">
      <xsl:if test="t:width/text()"><xsl:text>w: </xsl:text>
        <xsl:value-of select="t:width"/>
        <xsl:if test="t:height/text() | t:depth/text() | t:dim[@type='diameter']/text()">
          <xsl:text> × </xsl:text>
        </xsl:if>
      </xsl:if>
      <xsl:if test="t:height/text()"><xsl:text>h: </xsl:text>
        <xsl:value-of select="t:height"/>
        <xsl:if test="t:depth/text() | t:dim[@type='diameter']/text()">
          <xsl:text> × </xsl:text>
        </xsl:if>
      </xsl:if>
      <xsl:if test="t:depth/text()"><xsl:text>d: </xsl:text>
        <xsl:value-of select="t:depth"/>
        <xsl:if test="t:dim[@type='diameter']/text()">
          <xsl:text> × </xsl:text>
        </xsl:if>
      </xsl:if>
      <xsl:if test="t:dim[@type='diameter']/text()"><xsl:text>diam: </xsl:text>
        <xsl:value-of select="t:dim[@type='diameter']"/>
      </xsl:if>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="t:placeName|t:rs|t:repository" mode="inslib-placename">
    <xsl:variable name="ref-id" select="substring-after(@ref, '#')"/>
    <!-- if you are running this template outside EFES, change the path to the institutions authority list accordingly -->
    <xsl:variable name="institutions-list" select="concat('file:',system-property('user.dir'),'/webapps/ROOT/content/xml/authority/institution.xml')"/>
    <xsl:choose>
      <xsl:when test="contains(@ref,'institution.xml') and doc-available($institutions-list) = fn:true() and document($institutions-list)//t:place[@xml:id=$ref-id]//t:idno[1]">
        <a target="_blank" href="{document($institutions-list)//t:place[@xml:id=$ref-id]//t:idno[1]}"><xsl:apply-templates/></a>
      </xsl:when>
      <xsl:when test="starts-with(@ref, 'http') and starts-with(@key, 'http')">
        <a href="{@ref}" target="_blank"><xsl:apply-templates/></a>
        <a target="_blank" href="{@key}"> ➚</a>
      </xsl:when>
      <xsl:when test="starts-with(@ref, 'http') and not(starts-with(@key, 'http'))">
        <a href="{@ref}" target="_blank"><xsl:apply-templates/></a>
      </xsl:when>
      <xsl:when test="starts-with(@key, 'http') and not(starts-with(@ref, 'http'))">
        <a href="{@key}" target="_blank"><xsl:apply-templates/></a>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template name="inslib-navigation">
    <!-- if you are running this template outside EFES, change the path to the inscriptions list accordingly -->
    <xsl:if test="doc-available(concat('file:',system-property('user.dir'),'/webapps/ROOT/content/lists/all_inscriptions.xml')) = fn:true()">
      <xsl:variable name="list" select="document(concat('file:',system-property('user.dir'),'/webapps/ROOT/content/lists/all_inscriptions.xml'))//t:list"/>
      <xsl:variable name="filename"><xsl:value-of select="lower-case(string(//t:idno[@type='filename'][1]))"/></xsl:variable>
      <xsl:variable name="prev" select="$list/t:item[substring-before(lower-case(@n),'.xml')=$filename]/preceding-sibling::t:item[1]/substring-before(@n,'.xml')"/>
      <xsl:variable name="next" select="$list/t:item[substring-before(lower-case(@n),'.xml')=$filename]/following-sibling::t:item[1]/substring-before(@n,'.xml')"/>
      
      <div class="row">
        <div class="large-12 columns">
          <ul class="pagination">
            <xsl:if test="$prev"><li class="arrow"><a href="./{$prev}.html">&#171; Previous</a></li></xsl:if>
            <xsl:if test="$next"><li class="arrow"><a href="./{$next}.html">Next &#187;</a></li></xsl:if>
          </ul>
        </div>
      </div>
    </xsl:if>
  </xsl:template>
  
</xsl:stylesheet>