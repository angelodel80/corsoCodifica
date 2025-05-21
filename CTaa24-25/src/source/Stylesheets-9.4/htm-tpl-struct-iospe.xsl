<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:i18n="http://apache.org/cocoon/i18n/2.1"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" version="2.0">
  <!-- Contains named templates for IOSPE file structure (aka "metadata" aka "supporting data") -->

  <!-- Called from htm-tpl-structure.xsl -->

  <xsl:template name="iospe-body-structure">
    <div id="stone">
      <h3 class="iospe"><i18n:text i18n:key="epidoc-xslt-iospe-monument">Monument</i18n:text></h3>
      <dl class="iospe">
        <dt width="150" align="left"><i18n:text i18n:key="epidoc-xslt-iospe-monument-type">Type of monument</i18n:text></dt>
        <dd>
          <xsl:choose>
            <xsl:when test="//t:support//t:objectType//text()">
              <xsl:value-of select="//t:support//t:objectType"/>
            </xsl:when>
            <xsl:otherwise><i18n:text i18n:key="epidoc-xslt-iospe-not-specified">Not specified</i18n:text></xsl:otherwise>
          </xsl:choose>
        </dd>
        <dt width="150" align="left"><i18n:text i18n:key="epidoc-xslt-iospe-material">Material</i18n:text></dt>
        <dd>
          <xsl:choose>
            <xsl:when test="//t:support//t:material//text()">
              <xsl:value-of select="//t:support//t:material"/>
            </xsl:when>
            <xsl:otherwise><i18n:text i18n:key="epidoc-xslt-iospe-not-specified">Not specified</i18n:text></xsl:otherwise>
          </xsl:choose>
        </dd>
        <dt width="150" align="left"><i18n:text i18n:key="epidoc-xslt-iospe-description">Description and condition</i18n:text></dt>
        <dd>
          <xsl:choose>
            <xsl:when test="//t:support//t:p//text()">
              <xsl:value-of select="//t:support//t:p"/>
            </xsl:when>
            <xsl:otherwise><i18n:text i18n:key="epidoc-xslt-iospe-not-specified">Not specified</i18n:text></xsl:otherwise>
          </xsl:choose>
        </dd>
      </dl>

      <dl class="iospe">
        <dt width="150" align="left"><i18n:text i18n:key="epidoc-xslt-iospe-find-place">Find place</i18n:text></dt>
        <dd>
          <xsl:choose>
            <xsl:when test="//t:provenance[@type='found']//t:placeName[@type='ancientFindspot']//text()">
              <xsl:value-of select="//t:provenance[@type='found']//t:placeName[@type='ancientFindspot']"/>
            </xsl:when>
            <xsl:otherwise><i18n:text i18n:key="epidoc-xslt-iospe-unknown">Unknown</i18n:text></xsl:otherwise>
          </xsl:choose>
        </dd>
        <dt width="150" align="left"><i18n:text i18n:key="epidoc-xslt-iospe-find-circumstances">Find circumstances</i18n:text></dt>
        <dd>
          <xsl:choose>
            <xsl:when test="//t:provenance[@type='found']//t:rs[@type='circumstances']//text()">
              <xsl:value-of select="//t:provenance[@type='found']//t:rs[@type='circumstances']"/>
            </xsl:when>
            <xsl:otherwise><i18n:text i18n:key="epidoc-xslt-iospe-unknown">Unknown</i18n:text></xsl:otherwise>
          </xsl:choose>
        </dd>
        <dt width="150" align="left"><i18n:text i18n:key="epidoc-xslt-iospe-find-context">Find context</i18n:text></dt>
        <dd>
          <xsl:choose>
            <xsl:when test="//t:provenance[@type='found']//t:rs[@type='context']//text()">
              <xsl:value-of select="//t:provenance[@type='found']//t:rs[@type='context']"/>
            </xsl:when>
            <xsl:otherwise><i18n:text i18n:key="epidoc-xslt-iospe-unknown">Unknown</i18n:text></xsl:otherwise>
          </xsl:choose>
        </dd>
        <dt width="150" align="left"><i18n:text i18n:key="epidoc-xslt-iospe-modern-location">Modern location</i18n:text></dt>
        <dd>
          <xsl:choose>
            <xsl:when test="//t:provenance[@type='observed']//text()">
              <xsl:value-of select="//t:provenance[@type='observed']"/>
            </xsl:when>
            <xsl:otherwise><i18n:text i18n:key="epidoc-xslt-iospe-unknown">Unknown</i18n:text></xsl:otherwise>
          </xsl:choose>
        </dd>
        <dt width="150" align="left"><i18n:text i18n:key="epidoc-xslt-iospe-dimensions">Dimensions</i18n:text></dt>
        <dd>
          <xsl:choose>
            <xsl:when test="//t:support/t:dimensions//text()[not(normalize-space(.)=' ')]">
              <xsl:if test="//t:support/t:dimensions/t:height/text()[not(normalize-space(.)=' ')]">H. <xsl:value-of select="//t:support/t:dimensions/t:height"/>,</xsl:if>
              <xsl:if test="//t:support/t:dimensions/t:width/text()[not(normalize-space(.)=' ')]">W. <xsl:value-of select="//t:support/t:dimensions/t:width"/>,</xsl:if>
              <xsl:if test="//t:support/t:dimensions/t:depth/text()[not(normalize-space(.)=' ')]">Th. <xsl:value-of select="//t:support/t:dimensions/t:depth"/></xsl:if>
              <xsl:if test="//t:support/t:dimensions/t:dim[@type='diameter']/text()[not(normalize-space(.)=' ')]">, Diam. <xsl:value-of select="//t:support/t:dimensions/t:dim[@type='diameter']"/></xsl:if>
            </xsl:when>
            <xsl:otherwise><i18n:text i18n:key="epidoc-xslt-iospe-unknown">Unknown</i18n:text></xsl:otherwise>
          </xsl:choose>
        </dd>
        <dt width="150" align="left"><i18n:text i18n:key="epidoc-xslt-iospe-institution-inventory">Institution and inventory</i18n:text></dt>
        <dd>
          <xsl:choose>
            <xsl:when test="//t:msIdentifier//t:repository/text() and //t:msIdentifier//t:idno/text()">
              <xsl:value-of select="//t:msIdentifier//t:repository"/>
              <xsl:value-of select="//t:msIdentifier//t:idno"/>
            </xsl:when>
            <xsl:when test="//t:msIdentifier//t:repository/text()">
              <xsl:value-of select="//t:msIdentifier//t:repository"/>
              <xsl:text>no inv. no.</xsl:text>
            </xsl:when>
            <xsl:otherwise><i18n:text i18n:key="epidoc-xslt-iospe-unknown">Unknown</i18n:text></xsl:otherwise>
          </xsl:choose>
        </dd>
      </dl>
    </div>

    <div id="text-field">
      <h3 class="iospe"><i18n:text i18n:key="epidoc-xslt-iospe-inscribed-field">Inscribed field</i18n:text></h3>
      <dl class="iospe">
        <xsl:if test="//t:layout/@ana">
          <dt width="150" align="left"><i18n:text i18n:key="epidoc-xslt-iospe-faces-code">Faces code</i18n:text></dt>
          <dd><xsl:value-of select="//t:layout/@ana"/></dd>
        </xsl:if>
        <dt width="150" align="left"><i18n:text i18n:key="epidoc-xslt-iospe-placement-text">Placement of text</i18n:text></dt>
        <dd>
          <xsl:choose>
            <xsl:when test="//t:layout/text()">
              <xsl:value-of select="//t:layout"/>
            </xsl:when>
            <xsl:otherwise><i18n:text i18n:key="epidoc-xslt-iospe-not-specified">Not specified</i18n:text></xsl:otherwise>
          </xsl:choose>
        </dd>
        <dt width="150" align="left"><i18n:text i18n:key="epidoc-xslt-iospe-style-lettering">Style of lettering</i18n:text></dt>
        <dd>
          <xsl:choose>
            <xsl:when test="//t:handNote//text()[not(ancestor::t:height)]">
              <xsl:value-of select="/t:handNote//text()[not(ancestor::t:height)]"/>
            </xsl:when>
            <xsl:otherwise><i18n:text i18n:key="epidoc-xslt-iospe-not-specified">Not specified</i18n:text></xsl:otherwise>
          </xsl:choose>
        </dd>
        <dt width="150" align="left"><i18n:text i18n:key="epidoc-xslt-iospe-letterheights">Letterheights</i18n:text></dt>
        <dd>
          <xsl:choose>
            <xsl:when test="//t:handNote//t:height/text()">
              <xsl:value-of select="//t:handNote//t:height"/>
            </xsl:when>
            <xsl:otherwise><i18n:text i18n:key="epidoc-xslt-iospe-not-specified">Not specified</i18n:text></xsl:otherwise>
          </xsl:choose>
        </dd>
      </dl>
    </div>

    <div id="text">
      <h3 class="iospe"><i18n:text i18n:key="epidoc-xslt-iospe-text">Text</i18n:text></h3>
      <dl class="iospe">

        <dt><i18n:text i18n:key="epidoc-xslt-iospe-origin">Origin</i18n:text></dt>
        <dd>
          <xsl:choose>
            <xsl:when test="//t:origin/t:origPlace/text()">
              <xsl:value-of select="//t:origin/t:origPlace"/>
            </xsl:when>
            <xsl:otherwise><i18n:text i18n:key="epidoc-xslt-iospe-not-specified">Not specified</i18n:text></xsl:otherwise>
          </xsl:choose>
        </dd>
        <dt><i18n:text i18n:key="epidoc-xslt-iospe-category">Category</i18n:text></dt>
        <dd>
          <xsl:choose>
            <xsl:when test="//t:msContents/t:summary/text()">
              <xsl:value-of select="//t:msContents/t:summary"/>
            </xsl:when>
            <xsl:otherwise><i18n:text i18n:key="epidoc-xslt-iospe-not-specified">Not specified</i18n:text></xsl:otherwise>
          </xsl:choose>
        </dd>
        <dt><i18n:text i18n:key="epidoc-xslt-iospe-date">Date</i18n:text></dt>
        <dd>
          <xsl:choose>
            <xsl:when test="//t:origin/t:origDate/text()">
              <xsl:value-of select="//t:origin/t:origDate"/>
            </xsl:when>
            <xsl:otherwise><i18n:text i18n:key="epidoc-xslt-iospe-not-specified">Not specified</i18n:text></xsl:otherwise>
        </xsl:choose></dd>
        <dt><i18n:text i18n:key="epidoc-xslt-iospe-dating-criteria">Dating criteria</i18n:text></dt>
        <dd>
          <xsl:choose>
            <xsl:when test="//t:origin/t:origDate/@evidence">
              <xsl:for-each select="tokenize(//t:origin/t:origDate/@evidence,' ')">
                <xsl:value-of select="translate(.,'-',' ')"/>
                <xsl:if test="position()!=last()">
                  <xsl:text>, </xsl:text>
                </xsl:if>
              </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>n/a</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </dd>
        <dt><i18n:text i18n:key="epidoc-xslt-iospe-editions">Editions</i18n:text></dt>
        <dd>
          <xsl:choose>
            <xsl:when test="//t:body//t:div[@type='bibliography']//text()">
              <xsl:apply-templates select="//t:body//t:div[@type='bibliography']"/>
            </xsl:when>
            <xsl:otherwise><i18n:text i18n:key="epidoc-xslt-iospe-unpublished">Unpublished</i18n:text></xsl:otherwise>
        </xsl:choose></dd>
      </dl>

      <div id="edition" class="iospe">
        <!-- Edited text output -->
        <xsl:variable name="edtxt">
          <xsl:apply-templates select="//t:div[@type='edition']"/>
        </xsl:variable>
        <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
        <xsl:apply-templates select="$edtxt" mode="sqbrackets"/>
      </div>
      <div id="apparatus" class="iospe">
        <h4 class="iospe"><i18n:text i18n:key="epidoc-xslt-iospe-apparatus">Apparatus</i18n:text></h4>
        <!-- Apparatus text output -->
        <xsl:variable name="apptxt">
          <xsl:apply-templates select="//t:div[@type='apparatus']/t:listApp"/>
        </xsl:variable>
        <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
        <xsl:apply-templates select="$apptxt" mode="sqbrackets"/>
      </div>
      <div id="translation" class="iospe">
        <h4 class="iospe"><i18n:text i18n:key="epidoc-xslt-iospe-translation">Translation</i18n:text></h4>
        <!-- Translation text output -->
        <xsl:variable name="transtxt">
          <xsl:apply-templates select="//t:div[@type='translation']//t:p"/>
        </xsl:variable>
        <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
        <xsl:apply-templates select="$transtxt" mode="sqbrackets"/>
      </div>
      <div id="commentary" class="iospe">
        <h4 class="iospe"><i18n:text i18n:key="epidoc-xslt-iospe-commentary">Commentary</i18n:text></h4>
        <!-- Commentary text output -->
        <xsl:variable name="commtxt">
          <xsl:apply-templates select="//t:div[@type='commentary']//t:p"/>
        </xsl:variable>
        <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
        <xsl:apply-templates select="$commtxt" mode="sqbrackets"/>
      </div>
    </div>
  </xsl:template>

  <xsl:template name="iospe-structure">
    <xsl:variable name="title">
      <xsl:call-template name="iospe-title" />
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
        <xsl:call-template name="iospe-body-structure" />
      </body>
    </html>
  </xsl:template>

  <xsl:template name="iospe-title">
    <xsl:choose>
      <xsl:when test="//t:titleStmt/t:title/text() and matches(//t:idno[@type='filename'], '^\d\.\d{1,4}$')">
        <xsl:number value="substring-before(//t:idno[@type='filename'],'.')" format="I"/>
        <xsl:text>&#xa0;</xsl:text>
        <xsl:number value="substring-after(//t:idno[@type='filename'],'.')" format="1"/>
        <xsl:text>.&#xa0;</xsl:text>
        <xsl:if test="string(normalize-space(//t:origPlace[1]))"><xsl:value-of select="normalize-space(//t:origPlace[1])"/>
        <xsl:text>.&#xa0;</xsl:text></xsl:if>
        <xsl:value-of select="//t:titleStmt/t:title[child::text()][1]"/>
        <xsl:if test="not(//t:titleStmt/t:title[child::text()][1][child::t:origDate])">
          <xsl:text>,&#xa0;</xsl:text>
          <xsl:value-of select="//t:origDate[1]"/>
        </xsl:if>
      </xsl:when>
      <xsl:when test="//t:titleStmt/t:title/text()">
        <xsl:value-of select="//t:titleStmt/t:title"/>
      </xsl:when>
      <xsl:when test="//t:sourceDesc//t:bibl/text()">
        <xsl:value-of select="//t:sourceDesc//t:bibl"/>
      </xsl:when>
      <xsl:when test="//t:idno[@type='filename']/text()">
        <xsl:value-of select="//t:idno[@type='filename']"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>EpiDoc example output, IOSPE style</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
