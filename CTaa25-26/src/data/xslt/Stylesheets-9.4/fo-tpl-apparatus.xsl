<!-- $Id$ --><xsl:stylesheet xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" version="2.0">
  <!-- Apparatus creation: look in tpl-apparatus.xsl for documentation -->
  <xsl:include href="tpl-apparatus.xsl"/>

  <!-- DDBDP Apparatus framework -->
  <xsl:template name="tpl-apparatus">
    <!-- An apparatus is only created if one of the following is true -->
    <xsl:if test=".//t:choice | .//t:subst | .//t:app |        .//t:hi[@rend = 'diaeresis' or @rend = 'grave' or @rend = 'acute' or @rend = 'asper' or @rend = 'lenis' or @rend = 'circumflex'] |        .//t:del[@rend='slashes' or @rend='cross-strokes'] | .//t:milestone[@rend = 'box']">

      <fo:block font-weight="700">Apparatus</fo:block>
      <fo:block id="apparatus-{replace(//t:idno[@type='filename'], '\s+', '_')}">
        <!-- An entry is created for-each of the following instances
                  * choice, subst or app not nested in another;
                  * hi not nested in the app part of an app;
                  * del or milestone.
        -->
        <xsl:for-each select="(.//t:choice | .//t:subst | .//t:app)[not(ancestor::t:*[local-name()=('choice','subst','app')])] |                .//t:hi[@rend=('diaeresis','grave','acute','asper','lenis','circumflex')][not(ancestor::t:*[local-name()=('orig','reg','sic','corr','lem','rdg')                 or self::t:del[@rend='corrected']                 or self::t:add[@place='inline']][1][local-name()=('reg','corr','rdg')                 or self::t:del[@rend='corrected']])] |            .//t:del[@rend='slashes' or @rend='cross-strokes'] | .//t:milestone[@rend = 'box']">

          <!-- Found in tpl-apparatus.xsl -->
          <xsl:call-template name="ddbdp-app">
            <xsl:with-param name="apptype">
              <xsl:choose>
                <xsl:when test="self::t:choice[child::t:orig and child::t:reg]">
                  <xsl:text>origreg</xsl:text>
                </xsl:when>
                <xsl:when test="self::t:choice[child::t:sic and child::t:corr]">
                  <xsl:text>siccorr</xsl:text>
                </xsl:when>
                <xsl:when test="self::t:subst">
                  <xsl:text>subst</xsl:text>
                </xsl:when>
                <xsl:when test="self::t:app[@type='alternative']">
                  <xsl:text>appalt</xsl:text>
                </xsl:when>
                <xsl:when test="self::t:app[@type='editorial'][starts-with(t:lem/@resp,'BL ')]">
                  <xsl:text>appbl</xsl:text>
                </xsl:when>
                <xsl:when test="self::t:app[@type='editorial'][starts-with(t:lem/@resp,'PN ')]">
                  <xsl:text>apppn</xsl:text>
                </xsl:when>
                <xsl:when test="self::t:app[@type='editorial']">
                  <xsl:text>apped</xsl:text>
                </xsl:when>
              </xsl:choose>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:for-each>
      </fo:block>
    </xsl:if>
  </xsl:template>

  <!-- called from tpl-apparatus.xsl -->
  <xsl:template name="lbrk-app">
    <fo:block/>
  </xsl:template>

  <!-- Used in htm-{element} and above to add linking to and from apparatus -->
  <xsl:template name="app-link">
    <!-- location defines the direction of linking -->
    <xsl:param name="location"/>
    <!-- Does not produce links for translations -->
    <xsl:if test="not(ancestor::t:div[@type = 'translation'])">
      <!-- Only produces a link if it is not nested in an element that would be in apparatus -->
      <xsl:if test="not((local-name() = 'choice' or local-name() = 'subst' or local-name() = 'app')          and (ancestor::t:choice or ancestor::t:subst or ancestor::t:app))">
        <xsl:variable name="app-num">
          <xsl:value-of select="name()"/>
          <xsl:number level="any" format="01"/>
        </xsl:variable>
        <xsl:call-template name="generate-app-link">
          <xsl:with-param name="location" select="$location"/>
          <xsl:with-param name="app-num" select="$app-num"/>
        </xsl:call-template>
      </xsl:if>
    </xsl:if>
  </xsl:template>

  <!-- Called by app-link to generate the actual HTML, so other projects can override this template for their own style -->
  <xsl:template name="generate-app-link">
    <xsl:param name="location"/>
    <xsl:param name="app-num"/>
    <xsl:choose>
      <xsl:when test="$location = 'text'">
        <fo:basic-link>
          <xsl:attribute name="internal-destination">
            <xsl:text>to-app-</xsl:text>
            <xsl:value-of select="$app-num"/>
          </xsl:attribute>
          <xsl:attribute name="id">
            <xsl:text>from-app-</xsl:text>
            <xsl:value-of select="$app-num"/>
          </xsl:attribute>
          <xsl:text>(*)</xsl:text>
        </fo:basic-link>
      </xsl:when>
      <xsl:when test="$location = 'apparatus'">
        <fo:basic-link>
          <xsl:attribute name="id">
            <xsl:text>to-app-</xsl:text>
            <xsl:value-of select="$app-num"/>
          </xsl:attribute>
          <xsl:attribute name="internal-destination">
            <xsl:text>from-app-</xsl:text>
            <xsl:value-of select="$app-num"/>
          </xsl:attribute>
          <xsl:text>^</xsl:text>
        </fo:basic-link>
        <xsl:text> </xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <!-- IOSPE "mini apparatus" framework  -->

  <!-- called from htm-teidivedition.xsl -->
  <xsl:template name="tpl-iospe-apparatus">
    <xsl:if test="not(descendant::t:div[@type='textpart'][@n]) and       (.//t:choice[child::t:corr] or .//t:supplied[@reason='omitted'] or .//t:subst or .//t:hi[@rend=('subscript','superscript')])">
      <xsl:variable name="listapp">
        <!-- generate a list of app entries, with line numbers for each (and render them later) -->
        <xsl:for-each select=".//(t:choice[child::t:corr]|t:supplied[@reason='omitted']|t:subst|t:hi[@rend=('subscript','superscript')])[not(ancestor::t:rdg)]">
          <xsl:element name="app">
            <!-- pseudo-id to avoid duplication of content words in miniapp -->
            <xsl:attribute name="psid" select="generate-id((ancestor::t:w|ancestor::t:name|ancestor::t:placeName|ancestor::t:num)[1])"/>
            <!-- number to group together miniapps from a single line -->
            <xsl:attribute name="n">
              <xsl:value-of select="preceding::t:lb[1]/@n"/>
              <!-- NOTE: need to handle line ranges -->
            </xsl:attribute>
            <xsl:choose>
              <xsl:when test="self::t:choice">
                <xsl:text>orig. </xsl:text>
                <xsl:call-template name="iospe-appcontext">
                  <!-- template below: strips diacritics, omits reg/corr/add/ex, and uppercases -->
                  <xsl:with-param name="context" select="(ancestor::t:w|ancestor::t:name|ancestor::t:placeName|ancestor::t:num)[1]"/>
                </xsl:call-template>
              </xsl:when>
              <xsl:when test="self::t:supplied">
                <xsl:text>orig. </xsl:text>
                <xsl:call-template name="iospe-appcontext">
                  <!-- template below: strips diacritics, omits reg/corr/add/ex, and uppercases -->
                  <xsl:with-param name="context" select="(ancestor::t:w|ancestor::t:name|ancestor::t:placeName|ancestor::t:num)[1]/text()"/>
                </xsl:call-template>
              </xsl:when>
              <xsl:when test="self::t:subst and child::t:add and child::t:del">
                <xsl:text>corr. ex </xsl:text>
                <xsl:call-template name="iospe-appcontext">
                  <!-- template below: strips diacritics, omits reg/corr/add/ex, and uppercases -->
                  <xsl:with-param name="context" select="(ancestor::t:w|ancestor::t:name|ancestor::t:placeName|ancestor::t:num)[1]"/>
                </xsl:call-template>
              </xsl:when>
              <xsl:when test="self::t:hi[@rend=('subscript','superscript')]">
                <xsl:apply-templates/>
                <xsl:choose>
                  <xsl:when test="@rend='subscript'">
                    <xsl:text> i.l.</xsl:text>
                  </xsl:when>
                  <xsl:when test="@rend='superscript'">
                    <xsl:text> s.l.</xsl:text>
                  </xsl:when>
                </xsl:choose>
              </xsl:when>
            </xsl:choose>
          </xsl:element>
        </xsl:for-each>
      </xsl:variable>
      <fo:block>
        <xsl:if test="ancestor-or-self::t:div[@type='textpart'][@n]">
          <xsl:attribute name="id">
            <xsl:text>miniapp</xsl:text>
            <xsl:for-each select="ancestor-or-self::t:div[@type='textpart'][@n]">
              <xsl:value-of select="@n"/>
              <xsl:text>-</xsl:text>
            </xsl:for-each>
          </xsl:attribute>
        </xsl:if>
        <xsl:for-each select="$listapp/app">
          <xsl:if test="not(preceding-sibling::app[@psid=current()/@psid])">
            <xsl:if test="not(preceding-sibling::app[@n=current()/@n])">
              <xsl:value-of select="@n"/>
              <xsl:text>: </xsl:text>
            </xsl:if>
            <xsl:value-of select="."/>
            <xsl:if test="not(position()=last()) and not(following-sibling::app[@psid=current()/@psid])">
              <xsl:text>; </xsl:text>
            </xsl:if>
          </xsl:if>
        </xsl:for-each>
      </fo:block>
    </xsl:if>
  </xsl:template>

  <xsl:template name="iospe-appcontext">
    <xsl:param name="context"/>
      <xsl:apply-templates mode="iospe-context" select="$context"/>
  </xsl:template>
  
  <xsl:template mode="iospe-context" match="t:reg|t:corr|t:add|t:ex|t:rdg"/>
  
  <xsl:template mode="iospe-context" match="text()">
    <xsl:value-of select="upper-case(translate(normalize-unicode(.,'NFD'),'́̓̔͂',''))"/>
  </xsl:template>
  
  <xsl:template mode="iospe-context" match="t:gap|t:supplied[@reason='lost']">
    <xsl:choose>
      <xsl:when test="@quantity ">
      <xsl:for-each select="1 to @quantity"><xsl:text>.</xsl:text></xsl:for-each>
    </xsl:when>
      <xsl:when test="@atMost">
        <xsl:for-each select="1 to @quantity"><xsl:text>.</xsl:text></xsl:for-each>
      </xsl:when>
      <xsl:when test="not(string(normalize-space(self::node())) = '')">
        <xsl:for-each select="1 to string-length(self::node())"><xsl:text>.</xsl:text></xsl:for-each>
      </xsl:when>
      <xsl:otherwise><xsl:text>...</xsl:text></xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <!-- called from htm-teidivedition.xsl -->

<!--this is the intended default which will deal with the widest range of simple apparatus note marked up inside the text
-->
  <xsl:template name="tpl-fullex-apparatus">

<xsl:variable name="listapp"><!-- generate a list of app entries, with line numbers for each (and render them later) -->

  <xsl:for-each select=".//t:corr[not(ancestor::t:choice)]">
    <xsl:element name="app">
      <xsl:attribute name="n">
        <xsl:value-of select="preceding::t:lb[1]/@n"/>
        <!-- NOTE: need to handle line ranges -->
      </xsl:attribute>
      <xsl:call-template name="intappcorr"/>
    </xsl:element>
  </xsl:for-each>

        <xsl:for-each select=".//t:choice[child::t:reg and not(ancestor::t:rdg)]">
          <xsl:element name="app">
            <xsl:attribute name="n">
              <xsl:value-of select="preceding::t:lb[1]/@n"/>
              <!-- NOTE: need to handle line ranges -->
            </xsl:attribute>
<xsl:call-template name="intappchoice"/>
          </xsl:element>
        </xsl:for-each>
       
  <xsl:for-each select=".//t:choice[child::t:corr and not(ancestor::t:rdg)]">
    <xsl:element name="app">
      <xsl:attribute name="n">
        <xsl:value-of select="preceding::t:lb[1]/@n"/>
        <!-- NOTE: need to handle line ranges -->
      </xsl:attribute>
      <xsl:call-template name="intappsiccorr"/>
    </xsl:element>
  </xsl:for-each>

  <xsl:for-each select=".//t:choice[child::t:unclear and not(ancestor::t:rdg)]">
    <xsl:element name="app">
      <xsl:attribute name="n">
        <xsl:value-of select="preceding::t:lb[1]/@n"/>
        <!-- NOTE: need to handle line ranges -->
      </xsl:attribute>
      <xsl:call-template name="intappunclear"/>
    </xsl:element>
  </xsl:for-each>

          <xsl:for-each select=".//t:subst[not(ancestor::t:rdg)]">
            <xsl:element name="app">
              <xsl:attribute name="n">
                <xsl:value-of select="preceding::t:lb[1]/@n"/>
                <!-- NOTE: need to handle line ranges -->
              </xsl:attribute>
              <xsl:call-template name="intappsubst"/>
            </xsl:element>
          </xsl:for-each>

  <xsl:for-each select=".//t:add[@place='overstrike' and not(ancestor::t:rdg or ancestor::t:subst)]">
    <xsl:element name="app">
      <xsl:attribute name="n">
        <xsl:value-of select="preceding::t:lb[1]/@n"/>
        <!-- NOTE: need to handle line ranges -->
      </xsl:attribute>
      <xsl:call-template name="intappoverstrike"/>
    </xsl:element>
  </xsl:for-each>

  <xsl:for-each select=".//t:add[@place=('above','below') and not(ancestor::t:rdg or ancestor::t:subst)]">
    <xsl:element name="app">
      <xsl:attribute name="n">
        <xsl:value-of select="preceding::t:lb[1]/@n"/>
        <!-- NOTE: need to handle line ranges -->
      </xsl:attribute>
      <xsl:call-template name="intappaddabovebelow"/>
    </xsl:element>
  </xsl:for-each>

            <xsl:for-each select=".//t:hi[@rend=('subscript','superscript') and not(ancestor::t:rdg)]">
              <xsl:element name="app">
                <xsl:attribute name="n">
                  <xsl:value-of select="preceding::t:lb[1]/@n"/>
                  <!-- NOTE: need to handle line ranges -->
                </xsl:attribute>
                <xsl:call-template name="intapphi"/>
              </xsl:element>
            </xsl:for-each>

  <xsl:for-each select=".//t:app[@type='editorial']">
    <xsl:element name="app">
      <xsl:attribute name="n">
        <xsl:value-of select="preceding::t:lb[1]/@n"/>
        <!-- NOTE: need to handle line ranges -->
      </xsl:attribute>
      <xsl:call-template name="intappedit"/>
    </xsl:element>
  </xsl:for-each>

  <xsl:for-each select=".//t:app[@type='alternative']">
    <xsl:element name="app">
      <xsl:attribute name="n">
        <xsl:value-of select="preceding::t:lb[1]/@n"/>
        <!-- NOTE: need to handle line ranges -->
      </xsl:attribute>
      <xsl:call-template name="intappapp"/>
    </xsl:element>
  </xsl:for-each>

       </xsl:variable>

<!--generate the actual apparatus printing the separators between each info and the reference to line number-->
      <fo:block>
        <xsl:if test="ancestor-or-self::t:div[@type='textpart'][@n]">
          <xsl:attribute name="id">
            <xsl:text>miniapp</xsl:text>
            <xsl:for-each select="ancestor-or-self::t:div[@type='textpart'][@n]">
              <xsl:value-of select="@n"/>
              <xsl:text>-</xsl:text>
            </xsl:for-each>
          </xsl:attribute>
        </xsl:if>
        <xsl:for-each select="$listapp/app">
<xsl:sort select="@n" data-type="number"/>
          <xsl:if test="not(preceding-sibling::app[@n=current()/@n])">
            <xsl:text>l.</xsl:text>
<xsl:value-of select="@n"/>
            <xsl:text> </xsl:text>
          </xsl:if>
          <xsl:value-of select="."/>
          <xsl:if test="not(position()=last())">
            <xsl:text> | </xsl:text>
          </xsl:if>
        </xsl:for-each>
      </fo:block>
  </xsl:template>
  

<!--this only renders choice and app-->
  <xsl:template name="tpl-minex-apparatus">
    
    <xsl:variable name="listapp"><!-- generate a list of app entries, with line numbers for each (and render them later) -->
      
      <xsl:for-each select=".//t:choice[child::t:reg and not(ancestor::t:rdg)]">
        <xsl:element name="app">
          <xsl:attribute name="n">
            <xsl:value-of select="preceding::t:lb[1]/@n"/>
            <!-- NOTE: need to handle line ranges -->
          </xsl:attribute>
          <xsl:call-template name="intappchoice"/>
        </xsl:element>
      </xsl:for-each>
      
      <xsl:for-each select=".//t:choice[child::t:corr and not(ancestor::t:rdg)]">
        <xsl:element name="app">
          <xsl:attribute name="n">
            <xsl:value-of select="preceding::t:lb[1]/@n"/>
            <!-- NOTE: need to handle line ranges -->
          </xsl:attribute>
          <xsl:call-template name="intappsiccorr"/>
        </xsl:element>
      </xsl:for-each>
      
      <xsl:for-each select=".//t:app[@type='editorial']">
        <xsl:element name="app">
          <xsl:attribute name="n">
            <xsl:value-of select="preceding::t:lb[1]/@n"/>
            <!-- NOTE: need to handle line ranges -->
          </xsl:attribute>
          <xsl:call-template name="intappedit"/>
        </xsl:element>
      </xsl:for-each>
      
      <xsl:for-each select=".//t:app[@type='alternative']">
        <xsl:element name="app">
          <xsl:attribute name="n">
            <xsl:value-of select="preceding::t:lb[1]/@n"/>
            <!-- NOTE: need to handle line ranges -->
          </xsl:attribute>
          <xsl:call-template name="intappapp"/>
        </xsl:element>
      </xsl:for-each>
      
    </xsl:variable>
    
    <!--generate the actual apparatus printing the separators between each info and the reference to line number-->
    <fo:block>
      <xsl:if test="ancestor-or-self::t:div[@type='textpart'][@n]">
        <xsl:attribute name="id">
          <xsl:text>miniapp</xsl:text>
          <xsl:for-each select="ancestor-or-self::t:div[@type='textpart'][@n]">
            <xsl:value-of select="@n"/>
            <xsl:text>-</xsl:text>
          </xsl:for-each>
        </xsl:attribute>
      </xsl:if>
      <xsl:for-each select="$listapp/app">
        <xsl:sort select="@n" data-type="number"/>
        <xsl:if test="not(preceding-sibling::app[@n=current()/@n])">
          <xsl:text>l.</xsl:text>
          <xsl:value-of select="@n"/>
          <xsl:text> </xsl:text>
        </xsl:if>
        <xsl:value-of select="."/>
        <xsl:if test="not(position()=last())">
          <xsl:text> | </xsl:text>
        </xsl:if>
      </xsl:for-each>
    </fo:block>
  </xsl:template>

<!--templates for each internal apparatus feature -->

<xsl:template name="intappapp">
<xsl:apply-templates select="t:rdg"/>
</xsl:template>

  <xsl:template name="intappedit">
    <xsl:if test="t:lem/@source"><xsl:value-of select="t:lem/@source"/><xsl:text>; </xsl:text></xsl:if>
      <xsl:apply-templates select="t:rdg"/>
      <xsl:if test="t:rdg/@source"><xsl:text> </xsl:text><xsl:value-of select="t:rdg/@source"/><xsl:text>; </xsl:text></xsl:if>
  </xsl:template>
  
<!--Correction Without Specification-->

  <xsl:template name="intappcorr">
    
        <xsl:value-of select="."/><xsl:text> corr.</xsl:text>
       
  </xsl:template>

  <!--   Erroneous Substitution

choice with sic and corr

-->
  <xsl:template name="intappsiccorr">
    
        <xsl:text>sic, orig. </xsl:text>
        <xsl:value-of select="t:sic"/>
  </xsl:template>

  <!-- Regularization

choice with reg and orig -->
  <xsl:template name="intappchoice">
    <xsl:if test="self::t:choice">
    <xsl:text>reg., orig. </xsl:text>
    <xsl:call-template name="iospe-appcontext">
      <!-- template below: strips diacritics, omits reg/corr/add/ex, and uppercases -->
      <xsl:with-param name="context" select="(ancestor::t:w|ancestor::t:name|ancestor::t:placeName|ancestor::t:num)[1]"/>
    </xsl:call-template>
  </xsl:if>
  <xsl:value-of select="t:orig"/>
</xsl:template>
  

  <!-- Ambiguous Characters With Alternatives Offered 
choice and multiple unclear (but this currently is not 
handled in the default to render in the text only one unclear or preferred letter)

-->
  <xsl:template name="intappunclear">
   
<xsl:if test="self::t:choice">
      </xsl:if>
    <xsl:for-each select="t:unclear">
      <xsl:if test="not(position()=1)">
        <xsl:text> aut </xsl:text></xsl:if>
<xsl:value-of select="."/></xsl:for-each>
  </xsl:template>


  <!-- Ancient Corrections (Where Both Old And New Text Can Be Read)
subst with del and add 

in the text the text  after correction is printed, in apparatus instead the text originally written
-->
  <xsl:template name="intappsubst">
     
  <xsl:if test="self::t:subst and child::t:add and child::t:del">
    <xsl:text>del </xsl:text>
    <xsl:call-template name="iospe-appcontext">
      <!-- template below: strips diacritics, omits reg/corr/add/ex, and uppercases -->
      <xsl:with-param name="context" select="(ancestor::t:w|ancestor::t:name|ancestor::t:placeName|ancestor::t:num)[1]"/>
    </xsl:call-template>
  </xsl:if>
  <xsl:value-of select="t:del"/>

  </xsl:template>
  


  <!-- Ancient Corrections (Old Text Lost) -->
  <xsl:template name="intappoverstrike">
         <xsl:value-of select="."/><xsl:text> del</xsl:text>
  </xsl:template>


  <!-- Text Addition By Ancient Hand 

<add place="above">αβ</add>
-->

  <xsl:template name="intappaddabovebelow">
    <xsl:param name="parm-leiden-style" tunnel="yes" required="no"/>
   
        <xsl:value-of select="."/><xsl:text> add </xsl:text><xsl:value-of select="@place"/>
  </xsl:template>


  <!--Raised/Lowered Characters -->
  <xsl:template name="intapphi">
    <xsl:param name="parm-leiden-style" tunnel="yes" required="no"/>
 
  <xsl:value-of select="@rend"/>
  </xsl:template>


</xsl:stylesheet>