<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:fn="http://www.w3.org/2005/xpath-functions"
  exclude-result-prefixes="#all" version="2.0">
  
  
  <!-- only triggered if there is a <div type="apparatus"> (i.e. "external appartus") in the XML -->
  
  <!--<xsl:import href="teidivapparatus.xsl"/>-->
  
  <!-- Other div matches can be found in htm-teidiv.xsl -->
  <xsl:param name="parm-internal-app-style" />
  <xsl:param name="parm-external-app-style" />
  
  <xsl:variable name="default-language" select="'en'"/>
  
  <xsl:variable name="local-bibliography">
    <xsl:if test="$parm-external-app-style = 'iospe'">
      <xsl:for-each select="//t:div[@type='bibliography']//(t:bibl | t:biblStruct)">
        <xsl:choose>
          <xsl:when test="t:ptr/@target">
            <!-- I know there is only one, we use for-each only to change context -->
            <xsl:for-each select="t:ptr/@target">
              <xsl:call-template name="source">
                <xsl:with-param name="root" select="ancestor-or-self::t:TEI"/>
                <xsl:with-param name="parm-external-app-style" select="'iospe'" tunnel="yes"/>
              </xsl:call-template>
            </xsl:for-each>
          </xsl:when>
          <xsl:otherwise>
            <t:ref>
              <xsl:apply-templates select="." mode="parse-name-year"/>
            </t:ref>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:for-each>
    </xsl:if>
  </xsl:variable>
  
  <xsl:template name="source">
    <xsl:param name="root"/>
    <xsl:param name="parm-external-app-style" tunnel="yes" required="no"/>
    
    <xsl:variable name="source_location">
      <xsl:choose>
        <xsl:when
          test="$root//t:encodingDesc//t:prefixDef[@ident] and $root//t:encodingDesc//t:prefixDef/@ident = substring-before(., ':')">
          <xsl:value-of
            select="replace(substring-after(., ':'),
            $root//t:encodingDesc//t:prefixDef/@matchPattern,
            $root//t:encodingDesc//t:prefixDef/@replacementPattern)"
          />
        </xsl:when>
        <xsl:otherwise>
          <xsl:sequence select="."/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <t:ref>
      <xsl:choose>
        <xsl:when test="$parm-external-app-style = 'iospe'">
          <xsl:text>not collated</xsl:text>
        </xsl:when>
        <xsl:when test="starts-with($source_location, '#')">
          <xsl:apply-templates
            select="$root//t:div[@type='bibliography']//(t:bibl | t:biblStruct)[@xml:id=substring-after($source_location, '#')]"
            mode="parse-name-year"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:if test="fn:doc-available($source_location)">
            <xsl:apply-templates select="document($source_location, $root)" mode="parse-name-year"/>
          </xsl:if>
        </xsl:otherwise>
      </xsl:choose>
    </t:ref>
  </xsl:template>
  
  <xsl:template name="sources">
    <xsl:param name="root"/>
    
    <!-- collect all sources -->
    <xsl:variable name="sources">
      <xsl:for-each select="tokenize(@source, ' ')">
        <xsl:call-template name="source">
          <xsl:with-param name="root" select="$root"/>
        </xsl:call-template>
      </xsl:for-each>
    </xsl:variable>
    
    <!-- preselect sources to be printed -->
    <xsl:variable name="final_printing_sources">
      <xsl:for-each select="$sources/t:ref">
        <xsl:variable name="n_authors_with_same_name_in_local_bib_and_current_sources"
          select="count($local-bibliography/t:ref[t:name/text() = $sources/t:ref[t:name/text() = current()/t:name/text()]/t:name/text()])"/>
        <xsl:variable name="n_authors_with_same_name_in_current_sources"
          select="count($sources/t:ref[t:name/text() = current()/t:name/text()])"/>
        <xsl:variable name="first_occurrence_of_this_author_in_sources"
          select="$sources/t:ref[t:name/text() = current()/t:name/text()][1] = current()"/>
        <xsl:variable name="n_authors_with_same_name_in_local_bib"
          select="count($local-bibliography/t:ref[t:name/text() = current()/t:name/text()])"/>
        
        <xsl:if
          test="not($n_authors_with_same_name_in_local_bib_and_current_sources = $n_authors_with_same_name_in_current_sources)
          or $first_occurrence_of_this_author_in_sources">
          
          <t:ref>
            <xsl:sequence select="./t:name"/>
            <xsl:if
              test="$n_authors_with_same_name_in_local_bib != 1
              and not($n_authors_with_same_name_in_local_bib_and_current_sources = $n_authors_with_same_name_in_current_sources)">
              
              <xsl:sequence select="./t:date"/>
            </xsl:if>
          </t:ref>
        </xsl:if>
      </xsl:for-each>
    </xsl:variable>
    
    <!-- print references -->
    <xsl:for-each select="$final_printing_sources/t:ref">
      <xsl:if test="position()=1">
        <xsl:text> </xsl:text>
      </xsl:if>
      <xsl:value-of select="t:name"/>
      
      <xsl:if test="t:date">
        <xsl:text> </xsl:text>
        <xsl:value-of select="t:date"/>
      </xsl:if>
      <xsl:if test="not(position() = last())">
        <xsl:text>, </xsl:text>
      </xsl:if>
    </xsl:for-each>
    
  </xsl:template>
  
  <xsl:template match="t:bibl | t:biblStruct" mode="parse-name-year">
    <xsl:param name="parm-external-app-style" tunnel="yes" required="no"/>
    <t:name>
      <xsl:for-each select=".//t:author[1]">
        <xsl:choose>
          <xsl:when test=".//t:surname">
            <xsl:value-of select=".//t:surname[@xml:lang=$default-language or not(@xml:lang)]"/>
          </xsl:when>
          <xsl:when test=".//t:forename">
            <xsl:value-of select=".//t:forename[@xml:lang=$default-language or not(@xml:lang)]"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="."/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:for-each>
    </t:name>
    <t:date>
      <xsl:choose>
        <xsl:when test=".//t:imprint[1]">
          <xsl:value-of select=".//t:imprint[1]//t:date"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select=".//t:date[1]"/>
        </xsl:otherwise>
      </xsl:choose>
      
    </t:date>
  </xsl:template>
  
  <xsl:template match="t:div[@type='apparatus']" priority="1">
    <xsl:param name="parm-external-app-style" tunnel="yes" required="no"/>
    <div id="apparatus">
      <h2>Apparatus</h2>
      <p>
        <xsl:apply-templates/>
      </p>
    </div>
  </xsl:template>
  
  <xsl:template match="t:div[@type='apparatus']//t:app">
    <xsl:param name="parm-external-app-style" tunnel="yes" required="no"/>
    <xsl:param name="parm-edn-structure" tunnel="yes" required="no"/>
    <span>
      <xsl:attribute name="class">
        <xsl:value-of select="@loc"/>
      </xsl:attribute>
      <xsl:if
        test="@loc and (not(preceding-sibling::t:app) or @loc != preceding-sibling::t:app[1]/@loc)">
        <xsl:value-of select="translate(@loc, ' ', '.')"/>
        <xsl:text>: </xsl:text>
      </xsl:if>
      <xsl:apply-templates/>
    </span>
    
    <xsl:choose>
      <xsl:when test="@loc != following-sibling::t:app[1]/@loc">
        <br/>
      </xsl:when>
      <xsl:when test="following-sibling::t:app">
        <xsl:choose>
          <xsl:when test="$parm-edn-structure='inslib' or $parm-edn-structure='sample'">
            <xsl:text> || </xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>; </xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="t:div[@type = 'apparatus']//t:rdg">
    <xsl:param name="parm-external-app-style" tunnel="yes" required="no"/>
    <xsl:apply-templates/>
    <xsl:if test="@resp">
      <xsl:apply-templates select="@resp"/>
    </xsl:if>
    <xsl:call-template name="sources">
      <xsl:with-param name="root" select="ancestor-or-self::t:TEI"/>
    </xsl:call-template>
    
    <xsl:if test="following-sibling::t:rdg and not(following-sibling::*[1][self::t:note])">
      <xsl:text>; </xsl:text>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="t:div[@type = 'apparatus']//t:lem">
    <xsl:param name="parm-external-app-style" tunnel="yes" required="no"/>
    <xsl:apply-templates/>
    <xsl:if test="@resp">
      <xsl:apply-templates select="@resp"/>
    </xsl:if>
    <xsl:call-template name="sources">
      <xsl:with-param name="root" select="ancestor-or-self::t:TEI"/>
      </xsl:call-template>
  <xsl:if test="following-sibling::t:* and not(following-sibling::t:*[1][self::t:note]) and not(@source)">
      <xsl:text>: </xsl:text>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="t:div[@type = 'apparatus']//t:rdg/@resp|t:div[@type = 'apparatus']//t:lem/@resp">
    <xsl:param name="parm-external-app-style" tunnel="yes" required="no"/>
    <xsl:param name="parm-edn-structure" tunnel="yes" required="no"/>
    
    <xsl:variable name="biblio" select="tokenize(substring-after(., '#'), ' #')"/>
    
    <xsl:choose>
      <xsl:when test="$parm-edn-structure='inslib' or $parm-edn-structure='sample'">
        <xsl:variable name="bibliography-al" select="concat('file:',system-property('user.dir'),'/webapps/ROOT/content/xml/authority/bibliography.xml')"/>
        <xsl:for-each select="$biblio">
          <xsl:variable name="bib" select="normalize-space(.)"/>
          <!-- if you are running this template outside EFES, change the path to the bibliography authority list accordingly -->
          <xsl:variable name="bibl">
            <xsl:if test="doc-available($bibliography-al)">
              <xsl:sequence select="document($bibliography-al)//t:bibl[@xml:id=$bib][not(@sameAs)]"></xsl:sequence>
            </xsl:if>
          </xsl:variable>
          <xsl:if test="position()=1"><xsl:text> </xsl:text></xsl:if>
          <xsl:choose>
            <xsl:when test="doc-available($bibliography-al) and $bibl">
              <a href="../concordance/bibliography/{$bib}.html" target="_blank">
                <xsl:choose>
                  <xsl:when test="$bibl//t:bibl[@type='abbrev']">
                    <xsl:apply-templates select="$bibl//t:bibl[@type='abbrev'][1]"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:choose>
                      <xsl:when test="$bibl//t:*[@type='abbrev']">
                        <xsl:apply-templates select="$bibl//t:*[@type='abbrev']"/>
                      </xsl:when>
                      <xsl:when test="$bibl[ancestor::t:div[@xml:id='authored_editions']]">
                        <xsl:for-each select="$bibl//t:name[@type='surname'][not(parent::*/preceding-sibling::t:title)]">
                          <xsl:apply-templates select="."/>
                          <xsl:if test="position()!=last()"> – </xsl:if>
                        </xsl:for-each>
                        <xsl:text> </xsl:text>
                        <xsl:apply-templates select="$bibl//t:date"/>
                      </xsl:when>
                      <xsl:when test="$bibl[ancestor::t:div[@xml:id='series_collections']]">
                        <i><xsl:value-of select="$bibl/@xml:id"/></i>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:value-of select="$bib"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:otherwise>
                </xsl:choose>
              </a>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$bib"/>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:if test="position()!=last()"><xsl:text>, </xsl:text></xsl:if>
        </xsl:for-each>
      </xsl:when>
    <xsl:otherwise/>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="t:div[@type = 'apparatus']//t:note">
    <xsl:param name="parm-external-app-style" tunnel="yes" required="no"/>
    <span>
      <xsl:if test="ancestor::t:app">
        <xsl:apply-templates/>
        <xsl:if test="preceding-sibling::t:rdg and following-sibling::t:rdg">
          <xsl:text>; </xsl:text>
        </xsl:if>
      </xsl:if>
    </span>
  </xsl:template>
  
</xsl:stylesheet>
