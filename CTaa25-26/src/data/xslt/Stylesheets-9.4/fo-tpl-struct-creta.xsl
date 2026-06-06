<!-- $Id$ --><xsl:stylesheet xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" version="2.0">
  <!-- Contains named templates for creta file structure (aka "metadata" aka "supporting data") -->  
  <!-- Called from htm-tpl-structure.xsl -->
  
  <xsl:template name="creta-structure">
    <fo:block margin-top="12.5pt" margin-bottom="3.1pt" hyphenate="true" page-break-after="avoid">
      Text
    </fo:block>
    
    <xsl:call-template name="creta-body-structure"/>
    
  </xsl:template>
  
  <xsl:template name="creta-body-structure">
    <fo:block-container id="body-{replace(//t:idno[@type='filename'], '\s+', '_')}">
      <fo:block>
        <xsl:variable name="edtxt">
          <xsl:apply-templates select="//t:div[@type='edition']">
            <xsl:with-param name="parm-edition-type" tunnel="yes"><xsl:text>interpretive</xsl:text></xsl:with-param>
            <xsl:with-param name="parm-verse-lines" tunnel="yes"><xsl:text>off</xsl:text></xsl:with-param>
            <xsl:with-param name="parm-line-inc" tunnel="yes"><xsl:text>5</xsl:text></xsl:with-param>
          </xsl:apply-templates>
        </xsl:variable>
        <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
        <xsl:apply-templates select="$edtxt" mode="sqbrackets"/>
      </fo:block>
      
      <fo:block font-weight="800">Apparato</fo:block>
      <fo:block>
        <xsl:apply-templates select="//t:div[@type='apparatus']">
          <xsl:with-param name="parm-edition-type" tunnel="yes"><xsl:text>interpretive</xsl:text></xsl:with-param>
          <xsl:with-param name="parm-verse-lines" tunnel="yes"><xsl:text>off</xsl:text></xsl:with-param>
          <xsl:with-param name="parm-line-inc" tunnel="yes"><xsl:text>5</xsl:text></xsl:with-param>
        </xsl:apply-templates></fo:block>
      
      <fo:block font-weight="800">Traduzione</fo:block>
      <fo:block><xsl:variable name="trtxt">
        <xsl:apply-templates select="//t:div[@type='translation']">
          <xsl:with-param name="parm-edition-type" tunnel="yes"><xsl:text>interpretive</xsl:text></xsl:with-param>
          <xsl:with-param name="parm-verse-lines" tunnel="yes"><xsl:text>off</xsl:text></xsl:with-param>
          <xsl:with-param name="parm-line-inc" tunnel="yes"><xsl:text>5</xsl:text></xsl:with-param>
        </xsl:apply-templates>
      </xsl:variable>
        <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
        <xsl:apply-templates select="$trtxt" mode="sqbrackets"/></fo:block>
      
      <fo:block font-weight="800">Commento</fo:block>
      <fo:block>
        <xsl:apply-templates select="//t:div[@type='commentary']">
          <xsl:with-param name="parm-edition-type" tunnel="yes"><xsl:text>interpretive</xsl:text></xsl:with-param>
          <xsl:with-param name="parm-verse-lines" tunnel="yes"><xsl:text>off</xsl:text></xsl:with-param>
          <xsl:with-param name="parm-line-inc" tunnel="yes"><xsl:text>5</xsl:text></xsl:with-param>
        </xsl:apply-templates>
      </fo:block>
      
    </fo:block-container>
  </xsl:template> 
  
  
  <!-- links to external resources in bibliography  -->
  <xsl:template mode="creta" match="t:div[@type='bibliography']/t:p/t:bibl/t:ptr[@target][@type='phi']">
    ➚<a target="_blank" href="http://epigraphy.packhum.org/text/{@target}">PHI</a>
  </xsl:template>
  <xsl:template mode="creta" match="t:div[@type='bibliography']/t:p/t:bibl/t:ptr[@target][@type='aio']">
    ➚<a target="_blank" href="https://www.atticinscriptions.com/inscription/{@target}">AIO</a>
  </xsl:template>
  <xsl:template mode="creta" match="t:div[@type='bibliography']/t:p/t:bibl/t:ptr[@target][@type='seg']">
    ➚<a target="_blank" href="http://dx.doi.org/10.1163/1874-6772_seg_{@target}">SEG</a>
  </xsl:template>
  <xsl:template mode="creta" match="t:div[@type='bibliography']/t:p/t:bibl/t:ptr[@target][@type='cgrn']">
    ➚<a target="_blank" href="http://cgrn.ulg.ac.be/file/{@target}">CGRN</a>
  </xsl:template>
  <xsl:template mode="creta" match="t:div[@type='bibliography']/t:p/t:bibl/t:ptr[@target][@type='thetima']">
    ➚<a target="_blank" href="http://ancdialects.greek-language.gr/inscriptions/{@target}">ΘΕΤΙΜΑ</a>
  </xsl:template>
  <xsl:template mode="creta" match="t:div[@type='bibliography']/t:p/t:bibl/t:ptr[@target][@type='axon']">
    ➚<a target="_blank" href="https://mizar.unive.it/axon/public/axon/anteprima/anteprima/idSchede/{@target}">Axon</a>
  </xsl:template>
  <xsl:template mode="creta" match="t:div[@type='bibliography']/t:p/t:bibl/t:ptr[@target][@type='poinikastas']">
    ➚<a target="_blank" href="http://poinikastas.csad.ox.ac.uk/search-browse.shtml{@target}">Poinikastas</a>
  </xsl:template>
  <xsl:template mode="creta" match="t:div[@type='bibliography']/t:p/t:bibl/t:ptr[@target][@type='ela']">
    ➚<a target="_blank" href="http://www.epigraphiclandscape.unito.it/index.php/browse/{@target}">ELA</a>
  </xsl:template>
  
  <!-- links to full bibliographic references -->
  <xsl:template mode="creta" match="t:div[@type='bibliography' or @type='commentary']/t:p/t:bibl/t:ref[@target]">
    <a target="_blank" href="../texts/bibliografia.html#{substring-after(@target,'#')}" class="link"><xsl:apply-templates mode="creta"/></a>
  </xsl:template>
  
  <!-- links to inscriptions and literary sources in the commentary -->
  <xsl:template mode="creta" match="t:div[@type='commentary']/t:p/t:ref[@target][@type='ins']">
    <a target="_blank" href="./{substring-after(@target,'#')}.html"><xsl:apply-templates mode="creta"/></a></xsl:template>
  
  <xsl:template mode="creta" match="t:div[@type='commentary']/t:p/t:ref[@target][@type='lit']">
    <a target="_blank" href="../texts/fonti_letterarie.html{substring-after(@target, '#')}"><xsl:apply-templates mode="creta"/></a></xsl:template>
  
  <!-- links to institution sections in the commentary -->
  <xsl:template mode="creta" match="t:div[@type='commentary']/t:p/t:ref[@target][@type='inst']">
    <a target="_blank" href="../texts/istituzioni.html{@target}"><xsl:apply-templates mode="creta"/></a></xsl:template>
  
  
  <!-- bold chosen edition in bibliography  -->
  <xsl:template mode="creta" match="t:bibl[@type='main_edition']"><strong><xsl:apply-templates mode="creta"/></strong></xsl:template>
  
  <!-- p in bibliography, commentary, translation -->
  <xsl:template mode="creta" match="t:div[@type='bibliography' or @type='commentary' or @type='translation']/t:p"><p><xsl:apply-templates mode="creta"/></p></xsl:template>
  
  <!-- emph in bibliography and commentary -->
  <xsl:template mode="creta" match="t:div[@type='bibliography' or @type='commentary']/t:p//t:emph"><strong><xsl:apply-templates/></strong></xsl:template>
  
  <!-- apices in bibliography, commentary, apparatus -->
  <xsl:template mode="creta" match="t:div[@type='bibliography' or @type='commentary' or @type='apparatus']//t:hi[@rend='superscript']"><sup><xsl:apply-templates/></sup></xsl:template>
  
</xsl:stylesheet>