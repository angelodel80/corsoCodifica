<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:i18n="http://apache.org/cocoon/i18n/2.1"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" 
  version="2.0">
  <!-- Contains named templates for sample file structure -->  
  <!-- Called from htm-tpl-structure.xsl -->
  
  <xsl:template name="sample-title">
    <xsl:choose>
      <xsl:when test="//t:titleStmt/t:title//text() and //t:publicationStmt/t:idno[@type='filename']/text()">
        <xsl:value-of select="//t:publicationStmt/t:idno[@type='filename']"/> 
        <xsl:text>. </xsl:text>
        <xsl:apply-templates select="//t:titleStmt/t:title"/>
      </xsl:when>
      <xsl:when test="//t:titleStmt/t:title//text()">
        <xsl:apply-templates select="//t:titleStmt/t:title"/>
      </xsl:when>
      <xsl:when test="//t:sourceDesc//t:bibl//text()">
        <xsl:apply-templates select="//t:sourceDesc//t:bibl"/>
      </xsl:when>
      <xsl:when test="//t:idno[@type='filename']/text()">
        <xsl:value-of select="//t:idno[@type='filename']"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>EpiDoc example output, sample style</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template name="sample-structure">
    <xsl:variable name="title">
      <xsl:call-template name="sample-title" />
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
        <h1><xsl:value-of select="$title"/></h1>
        <xsl:call-template name="sample-body-structure" />
      </body>
    </html>
  </xsl:template>
  
  <xsl:template name="sample-body-structure">
    <div id="metadata">
        <xsl:if test="//t:support//t:p//text() or //t:support/t:rs[not(@type='decoration')]//text()">
          <p><b>Description: </b>
            <xsl:apply-templates select="//t:support/t:p" mode="sample-dimensions"/>
            <xsl:text> </xsl:text>
            <xsl:for-each select="//t:support/t:rs[not(@type='decoration')]">
              <xsl:apply-templates select="." mode="sample-dimensions"/>
              <xsl:if test="position()!=last()">
                <xsl:text>; </xsl:text>
              </xsl:if>
            </xsl:for-each>
          </p>
        </xsl:if>
      
        <xsl:if test="//t:support/t:material//text()">
          <p><b>Material: </b><xsl:apply-templates select="//t:support/t:material"/></p>
        </xsl:if>
      
      <xsl:if test="//t:support/t:objectType//text()">
          <p><b>Object type: </b><xsl:apply-templates select="//t:support/t:objectType"/></p>
        </xsl:if>
      
      <xsl:if test="//t:support/t:dimensions//text()">
          <p><b>Dimensions: </b><xsl:apply-templates select="//t:support/t:dimensions" mode="sample-dimensions"/></p>
        </xsl:if>
      
      <xsl:if test="//t:decoDesc//text() or //t:support/t:rs[@type='decoration']">
        <p><b>Decoration: </b>
          <xsl:apply-templates select="//t:decoDesc"/>
          <xsl:text> </xsl:text>
          <xsl:apply-templates select="//t:support/t:rs[@type='decoration']"/>
        </p>
      </xsl:if>
      
      <xsl:if test="//t:supportDesc//t:condition//text()">
        <p><b>Condition: </b>
          <xsl:value-of select="//t:supportDesc//t:condition"/>
        </p>
      </xsl:if>
      
      <xsl:if test="//t:layoutDesc/t:layout//text()">
        <p><b>Text: </b>
          <xsl:apply-templates select="//t:layoutDesc/t:layout" mode="sample-dimensions"/>
      </p>
      </xsl:if>
      
      <xsl:if test="//t:handDesc//text()">
        <p><b>Letters: </b>
          <xsl:apply-templates select="//t:handDesc"/>
        </p>
      </xsl:if>
      
      <p><b>Date: </b>
        <xsl:choose>
          <xsl:when test="//t:origin/t:origDate//text()">
            <xsl:apply-templates select="//t:origin/t:origDate"/>
            <xsl:if test="//t:origin/t:origDate[@evidence]">
              <xsl:text> (</xsl:text>
              <xsl:for-each select="tokenize(//t:origin/t:origDate/@evidence,' ')">
                <xsl:value-of select="translate(translate(.,'-',' '),',','')"/>
                <xsl:if test="position()!=last()">
                  <xsl:text>, </xsl:text>
                </xsl:if>
              </xsl:for-each>
              <xsl:text>)</xsl:text>
            </xsl:if>
          </xsl:when>
          <xsl:when test="//t:origin/t:date//text()">
            <xsl:apply-templates select="//t:origin/t:date"/>
            <xsl:if test="//t:origin/t:date[@evidence]">
              <xsl:text> (</xsl:text>
              <xsl:for-each select="tokenize(//t:origin/t:date/@evidence,' ')">
                <xsl:value-of select="translate(translate(.,'-',' '),',','')"/>
                <xsl:if test="position()!=last()">
                  <xsl:text>, </xsl:text>
                </xsl:if>
              </xsl:for-each>
              <xsl:text>)</xsl:text>
            </xsl:if>
          </xsl:when>
          <xsl:otherwise>Unknown.</xsl:otherwise>
        </xsl:choose>
      </p>
      
      <p><b>Findspot: </b>
        <xsl:choose>
          <xsl:when test="//t:provenance[@type='found']//text()">
            <xsl:apply-templates select="//t:provenance[@type='found']"/>
          </xsl:when>
          <xsl:otherwise>Unknown</xsl:otherwise>
        </xsl:choose>
      </p>
      
      <p><b>Original location: </b>
        <xsl:choose>
          <xsl:when test="//t:origin/t:origPlace//text()">
            <xsl:apply-templates select="//t:origin/t:origPlace"/>
          </xsl:when>
          <xsl:when test="//t:origin/t:placeName//text()">
            <xsl:apply-templates select="//t:origin/t:placeName"/>
          </xsl:when>
          <xsl:otherwise>Unknown</xsl:otherwise>
        </xsl:choose>
      </p>
      
      <p><b>Current repository: </b>
        <xsl:choose>
          <xsl:when test="//t:msIdentifier//t:repository//text()">
            <xsl:for-each select="//t:msIdentifier//t:repository">
              <xsl:if test="preceding-sibling::t:*[not(self::t:idno)][not(self::t:altIdentifier)]">
                <xsl:for-each select="preceding-sibling::t:*[not(self::t:idno)][not(self::t:altIdentifier)]">
                  <xsl:apply-templates select="."/><xsl:text> </xsl:text>
                </xsl:for-each>
              </xsl:if>
              <xsl:if test="following-sibling::t:*[not(self::t:idno)][not(self::t:altIdentifier)]">
                <xsl:for-each select="following-sibling::t:*[not(self::t:idno)][not(self::t:altIdentifier)]">
                  <xsl:apply-templates select="."/><xsl:text> </xsl:text>
                </xsl:for-each>
              </xsl:if>
              <xsl:apply-templates select="."/>
              <xsl:if test="following-sibling::t:idno">
                <xsl:text> (inv. no. </xsl:text>
                <xsl:for-each select="following-sibling::t:idno">
                  <xsl:apply-templates select="."/>
                  <xsl:if test="position()!=last()">
                    <xsl:text>, </xsl:text>
                  </xsl:if>
                </xsl:for-each>
                <xsl:text>)</xsl:text>
              </xsl:if>
              <xsl:if test="position()!=last()">
                <xsl:text>, </xsl:text>
              </xsl:if>
            </xsl:for-each>
          </xsl:when>
          <xsl:when test="//t:msIdentifier//t:msName//text()">
            <xsl:for-each select="//t:msIdentifier//t:msName">
              <xsl:apply-templates select="."/>
              <xsl:if test="position()!=last()">
                <xsl:text>, </xsl:text>
              </xsl:if>
            </xsl:for-each>
          </xsl:when>
          <xsl:otherwise>Unknown</xsl:otherwise>
        </xsl:choose>
      </p>
      
      <xsl:if test="//t:provenance[@type='observed' or @type='not-observed' or @type='transferred']//text()">
        <p><b>Last recorded location(s): </b>
          <xsl:for-each select="//t:provenance[@type='observed' or @type='not-observed' or @type='transferred']">
            <xsl:apply-templates select="."/>
            <xsl:if test="position()!=last()">
              <xsl:text> </xsl:text>
            </xsl:if>
          </xsl:for-each>
        </p>
      </xsl:if>
      
      <p><b>Text type: </b>
        <xsl:choose>
          <xsl:when test="//t:textClass//t:keywords//t:term[@type='textType']">
            <xsl:apply-templates select="//t:textClass//t:keywords//t:term[@type='textType']"/><xsl:text> </xsl:text>
          </xsl:when>

          
          <xsl:when test="//t:teiHeader//t:rs[@type='textType']">
            <xsl:apply-templates select="//t:teiHeader//t:rs[@type='textType']"/><xsl:text> </xsl:text>
          </xsl:when>
          
          <!-- 

            <xsl:when test="//t:teiHeader//t:rs[@type='textType']">
    
            <xsl:for-each select="//t:teiHeader//t:rs[@type='textType']">
              <xsl:apply-templates select="current()"/><xsl:text> </xsl:text>
            </xsl:for-each>
    
            </xsl:when>
          
          -->
           
          <xsl:when test="//t:msContents//t:summary[@corresp]">
            <xsl:apply-templates select="//t:msContents//t:summary[@corresp]"/><xsl:text> </xsl:text>
          </xsl:when>
          <xsl:when test="//t:textClass//t:keywords//t:term[not(@type='textType')]">
            <xsl:apply-templates select="//t:textClass//t:keywords//t:term[not(@type='textType')]"/><xsl:text> </xsl:text>
          </xsl:when>
          <xsl:when test="//t:msDesc//t:msItem[@class]">
            <xsl:value-of select="//t:msDesc//t:msItem/@class"/>
          </xsl:when>
          <xsl:otherwise>Unknown</xsl:otherwise>
        </xsl:choose>
        

       



      </p>
      
      <xsl:if test="//t:msDesc/t:msContents/t:msItem/t:p//text() or //t:msContents//t:summary//text()">
        <p><b>Summary: </b>
          <xsl:choose>
            <xsl:when test="//t:msDesc/t:msContents/t:msItem/t:p">
              <xsl:value-of select="//t:msDesc/t:msContents/t:msItem/t:p"/>
            </xsl:when>
            <xsl:when test="//t:msContents//t:summary">
              <xsl:apply-templates select="//t:msContents//t:summary"/>
            </xsl:when>
          </xsl:choose>
        </p>
      </xsl:if>
      
      <!--<xsl:if test="//t:textClass//t:keywords//text()">
        <p><b>Keywords: </b>
          <xsl:apply-templates select="//t:textClass//t:keywords"/>
        </p>
      </xsl:if>-->
    </div>
    
    <div id="file_metadata">
      <xsl:if test="//t:titleStmt//t:editor//text()">
        <p><b>Editor(s): </b>
          <xsl:for-each select="//t:editor">
            <xsl:apply-templates select="."/>
            <xsl:if test="@role">
              <xsl:text> (</xsl:text><xsl:value-of select="@role"/><xsl:text>)</xsl:text>
            </xsl:if>
            <xsl:if test="position()!=last()">
              <xsl:text>, </xsl:text>
            </xsl:if>
          </xsl:for-each>
        </p>
      </xsl:if>
      
      <xsl:if test="//t:revisionDesc//t:change">
        <p><b>Changes history: </b>
          <xsl:for-each select="//t:change">
            <xsl:value-of select="@when"/><xsl:text> </xsl:text>
            <xsl:value-of select="@who"/><xsl:text> </xsl:text>
            <xsl:value-of select="."/>
            <xsl:if test="position()!=last()">
              <xsl:text>; </xsl:text>
            </xsl:if>
          </xsl:for-each>
        </p>
      </xsl:if>
      
      <xsl:if test="//t:publicationStmt[descendant::t:*[not(self::t:idno)]//text()]">
        <p><b>Publication details: </b>
          <xsl:for-each select="//t:publicationStmt/t:*[not(self::t:idno)] ">
            <xsl:apply-templates select="."/>
            <xsl:if test="position()!=last()">
              <xsl:text>; </xsl:text>
            </xsl:if>
          </xsl:for-each>
        </p>
      </xsl:if>
    </div>
    
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
      <section>
        <p class="title" data-section-title="data-section-title"><a href="#">Diplomatic</a></p>
        <div class="content" id="diplomatic" data-section-content="data-section-content">
          <!-- Edited text output -->
          <xsl:variable name="edtxt">
            <xsl:apply-templates select="//t:div[@type='edition']">
              <xsl:with-param name="parm-edition-type" select="'diplomatic'" tunnel="yes"/>
              <xsl:with-param name="parm-verse-lines" select="'off'" tunnel="yes"/>
            </xsl:apply-templates>
          </xsl:variable>
          <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
          <xsl:apply-templates select="$edtxt" mode="sqbrackets"/>
        </div>
      </section>
    </div>
    
    <xsl:if test="//t:div[@type='apparatus']//text()">
      <div id="apparatus">
      <!-- Apparatus text output -->
      <xsl:variable name="apptxt">
        <xsl:apply-templates select="//t:div[@type='apparatus']"/>
      </xsl:variable>
      <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
      <xsl:apply-templates select="$apptxt" mode="sqbrackets"/>
    </div>
    </xsl:if>
    
    <xsl:if test="//t:div[@type='translation']//text()">
      <div id="translation">
        <!-- Translation text output -->
        <xsl:variable name="transtxt">
          <xsl:for-each select="//t:div[@type='translation']">
            <h3>Translation
              <xsl:if test="@xml:lang"><xsl:text> (</xsl:text>
                <xsl:choose>
                  <xsl:when test="@xml:lang='en'"><xsl:text>English</xsl:text></xsl:when>
                  <xsl:when test="@xml:lang='fr'"><xsl:text>French</xsl:text></xsl:when>
                  <xsl:when test="@xml:lang='it'"><xsl:text>Italian</xsl:text></xsl:when>
                  <xsl:when test="@xml:lang='de'"><xsl:text>German</xsl:text></xsl:when>
                  <xsl:when test="@xml:lang='ru'"><xsl:text>Russian</xsl:text></xsl:when>
                  <xsl:when test="@xml:lang='ar'"><xsl:text>Arabic</xsl:text></xsl:when>
                  <xsl:when test="@xml:lang='es'"><xsl:text>Spanish</xsl:text></xsl:when>
                  <xsl:otherwise><xsl:value-of select="@xml:lang"/></xsl:otherwise>
                </xsl:choose>
                <xsl:text>)</xsl:text></xsl:if></h3>
            <xsl:if test="@resp"><p><xsl:text>Translation by </xsl:text><xsl:value-of select="translate(@resp, '#', '')"/></p></xsl:if>
            <xsl:if test="@source"><p><xsl:text>Translation from </xsl:text><xsl:value-of select="translate(@source, '#', '')"/></p></xsl:if>
            <xsl:apply-templates select="descendant::t:p|descendant::t:ab"/>
          </xsl:for-each>
        </xsl:variable>
        <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
        <xsl:apply-templates select="$transtxt" mode="sqbrackets"/>
      </div>
    </xsl:if>
    
    <xsl:if test="//t:div[@type='commentary']//text()">
      <div id="commentary">
        <!-- Commentary text output -->
        <xsl:variable name="commtxt">
          <xsl:for-each select="//t:div[@type='commentary']">
            <h3>Commentary
              <xsl:if test="@subtype"><xsl:text> (</xsl:text><xsl:value-of select="@subtype"/><xsl:text>)</xsl:text></xsl:if></h3>
            <xsl:apply-templates select="descendant::t:p"/>
          </xsl:for-each>
        </xsl:variable>
        <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
        <xsl:apply-templates select="$commtxt" mode="sqbrackets"/>
      </div>
    </xsl:if>
    
    <xsl:if test="//t:div[@type='bibliography']//text() or //t:teiHeader//t:listBibl//text()">
      <div id="bibliography">
      <xsl:for-each select="//t:div[@type='bibliography']">
        <h3>Bibliography
          <xsl:if test="@subtype"><xsl:text> (</xsl:text><xsl:value-of select="@subtype"/><xsl:text>)</xsl:text></xsl:if></h3>
        <xsl:apply-templates select="descendant::t:p"/>
        <xsl:apply-templates select="descendant::t:listBibl"/>
      </xsl:for-each>

        <xsl:for-each select="//t:teiHeader//t:listBibl">
          <h3>Bibliography
            <xsl:if test="@type"><xsl:text> (</xsl:text><xsl:value-of select="@type"/><xsl:text>)</xsl:text></xsl:if></h3>
          <p><xsl:apply-templates select="descendant::t:bibl"/></p>
        </xsl:for-each>
      
      <xsl:if test="//t:creation//text()">
        <p><b>Text constituted from: </b>
          <xsl:apply-templates select="//t:creation"/>
        </p>
      </xsl:if>
    </div>
    </xsl:if>
    
    <xsl:if test="//t:facsimile">
      <div id="images">
        <h3>Images</h3>
        <xsl:choose>
          <xsl:when test="//t:facsimile//t:graphic">
            <xsl:for-each select="//t:facsimile//t:graphic">
              <span>&#160;</span>
              <xsl:choose>
                <xsl:when test="contains(@url,'http')">
                  <a target="_blank" href="{@url}">[Open image]</a>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:apply-templates select="." />
                </xsl:otherwise>
              </xsl:choose>
              <xsl:text> </xsl:text><span>&#160;</span>
              <strong><xsl:text>Fig. </xsl:text><xsl:number value="position()" format="1" /></strong><xsl:text>. </xsl:text>
              <xsl:if test="ancestor::t:surface[@n]">
                <xsl:text>Surface </xsl:text><xsl:value-of select="ancestor::t:surface/@n"/><xsl:text>. </xsl:text>
              </xsl:if>
              <xsl:if test="ancestor::t:surface[child::t:desc]">
                <xsl:apply-templates select="ancestor::t:surface/t:desc"/><xsl:text>. </xsl:text>
              </xsl:if>
              <xsl:if test="t:desc">
                <xsl:apply-templates select="t:desc" />
              </xsl:if>
              <br/><br/>
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
  </xsl:template>
  
  <!-- dimensions -->
  <xsl:template match="t:dimensions" mode="sample-dimensions">
    <xsl:if test="@type"><xsl:value-of select="@type"/><xsl:text>: </xsl:text></xsl:if>
    <xsl:if test="//text()">
      <xsl:if test="t:width/text()"><xsl:text>w </xsl:text>
        <xsl:value-of select="t:width"/>
        <xsl:if test="t:width[@unit]"><xsl:text> </xsl:text><xsl:value-of select="t:width/@unit"/></xsl:if>
        <xsl:if test="t:height/text()">
          <xsl:text> x </xsl:text>
        </xsl:if>
      </xsl:if>
      <xsl:if test="t:height/text()"><xsl:text>h </xsl:text>
        <xsl:value-of select="t:height"/>
        <xsl:if test="t:height[@unit]"><xsl:text> </xsl:text><xsl:value-of select="t:height/@unit"/></xsl:if>
      </xsl:if>
      <xsl:if test="t:depth/text()"><xsl:text> x d </xsl:text>
        <xsl:value-of select="t:depth"/>
        <xsl:if test="t:depth[@unit]"><xsl:text> </xsl:text><xsl:value-of select="t:depth/@unit"/></xsl:if>
      </xsl:if>
      <xsl:if test="t:dim[@type='diameter']/text()"><xsl:text> x diam. </xsl:text>
        <xsl:value-of select="t:dim[@type='diameter']"/>
        <xsl:if test="t:dim[@type='diameter'][@unit]"><xsl:text> </xsl:text><xsl:value-of select="t:dim[@type='diameter']/@unit"/></xsl:if>
      </xsl:if>
      <xsl:if test="@unit"><xsl:text> </xsl:text><xsl:value-of select="@unit"/></xsl:if>
      <xsl:text> </xsl:text>
    </xsl:if>
  </xsl:template>
  
  <!-- uncomment the following template to activate external links in @ref -->
    <!--<xsl:template priority="10" match="t:*[starts-with(@ref, 'http')]">
      <a href="{@ref}" target="_blank"><xsl:apply-templates/></a>
    </xsl:template>-->
  
</xsl:stylesheet>
