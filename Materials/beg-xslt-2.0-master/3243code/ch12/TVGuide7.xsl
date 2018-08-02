<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xdt="http://www.w3.org/2005/04/xpath-datatypes"
                xmlns:tv="http://www.example.com/TVGuide"
                exclude-result-prefixes="xs xdt tv"
                xmlns="http://www.w3.org/1999/xhtml">

<xsl:import href="utils2.xsl" />  
<xsl:include href="description.xsl" />  
<xsl:include href="channelList.xsl" />  
<xsl:include href="series2.xsl" />  
  
<xsl:output method="xhtml"
            doctype-public="-//W3C//DTD XHTML 1.1//EN"
            doctype-system="DTD/xhtml11.dtd"
            cdata-section-elements="style"
            encoding="ISO-8859-1" />  

<xsl:variable name="StarTrekLogo" as="element()">
  <img src="StarTrek.gif" alt="[Star Trek]" width="20" height="20" />
</xsl:variable>
  
<xsl:variable name="Channels" as="element(Channel)+">
  <xsl:perform-sort select="/TVGuide/Channel">
    <xsl:sort select="avg(Program/@rating)" order="descending" />
    <xsl:sort select="xs:integer(Program[1]/@rating)" order="descending" />
  </xsl:perform-sort>
</xsl:variable>
  
<xsl:template match="/">
  <html>
    <head>
      <title>TV Guide</title>
      <link rel="stylesheet" href="TVGuide.css" />
      <script type="text/javascript">
        function toggle(element) {
          if (element.style.display == 'none') {
            element.style.display = 'block';
          } else {
            element.style.display = 'none';
          }
        }
      </script>
    </head>

    <body>
      <h1>TV Guide</h1>
      <xsl:apply-templates select="TVGuide" />
    </body>
  </html>
</xsl:template>

<xsl:template match="TVGuide">
  <xsl:sequence select="$ChannelList" />
  <xsl:apply-templates select="$Channels" />
  <xsl:sequence select="$ChannelList" />
  <xsl:apply-templates select="." mode="Series" />
</xsl:template>
  
<xsl:template match="Channel">
  <xsl:apply-templates select="Name" />
  <p class="average">
    <xsl:text>average rating: </xsl:text>
    <xsl:value-of select="format-number(avg(Program/@rating), '0.0')" />
  </p>
  <xsl:apply-templates select="Program" />
</xsl:template>
  
<xsl:template match="Channel/Name">
  <h2 class="channel">
    <a name="{.}" id="{.}"><xsl:apply-templates /></a>
  </h2>
</xsl:template>

<xsl:template match="Program[1]" priority="1">
  <div class="nowShowing">
    <xsl:apply-templates select="." mode="Details" />
  </div>  
</xsl:template>

<xsl:template match="Program">
  <div>
    <xsl:if test="tv:is-interesting-program(.)">
      <xsl:attribute name="class" select="'interesting'" />
    </xsl:if>
    <xsl:apply-templates select="." mode="Details" />
  </div>
</xsl:template>
  
<xsl:template match="Program" mode="Details">
  <xsl:variable name="castList" as="element()?" select="CastList" />
  <xsl:variable name="programID" as="xs:string"
    select="concat(generate-id(), 'Cast')" />
  <p>
    <a name="{generate-id()}" id="{generate-id()}">
      <xsl:apply-templates select="Start" />
    </a>
    <br />
    <xsl:for-each select="1 to @rating">
      <img src="star.gif" alt="*" height="15" width="15" />
    </xsl:for-each>
    <br />
    <xsl:apply-templates
      select="document('flags.xml')/flags/flag[@name = current()/@flag]" />
    <xsl:if test="starts-with(Series, 'StarTrek')">
      <xsl:sequence select="$StarTrekLogo" />
    </xsl:if>
    <span class="title">
      <xsl:choose>
        <xsl:when test="string(Series)">
          <xsl:call-template name="link">
            <xsl:with-param name="href" as="xs:anyURI" 
                            select="xs:anyURI(concat('#', Series))" />
            <xsl:with-param name="content" as="xs:string" 
                            select="$series/key('IDs', current()/Series)/Title" />
          </xsl:call-template>
          <xsl:if test="string(Title)">
            <xsl:text> - </xsl:text>
            <span class="subtitle"><xsl:value-of select="Title" /></span>
          </xsl:if>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="Title" />
        </xsl:otherwise>
      </xsl:choose>
    </span>
    <br />
    <xsl:apply-templates select="Description" />
    <xsl:apply-templates select="$castList" mode="DisplayToggle">
      <xsl:with-param name="divID" select="$programID" />
    </xsl:apply-templates>
  </p>
  <xsl:apply-templates select="$castList">
    <xsl:with-param name="divID" select="$programID" />
  </xsl:apply-templates>
</xsl:template>

<xsl:template match="flag">
  <img src="{@src}" alt="{@alt}" width="20" height="20" />
</xsl:template>  
  
<xsl:template match="Start">
  <xsl:variable name="endDateTime" as="element(Start)?"
    select="parent::Program/following-sibling::Program[1]/Start" />
  <span class="date">
    <xsl:value-of select="format-dateTime(xs:dateTime(.), 
                                          '[M]/[D]/[Y] [H01]:[m]')" />
    <xsl:if test="$endDateTime">
      <xsl:value-of select="format-dateTime(xs:dateTime($endDateTime), 
                                            ' - [H01]:[m]')" />
    </xsl:if>                                        
  </span>
</xsl:template>

<xsl:template match="CastList" mode="DisplayToggle">
  <xsl:param name="divID" as="xs:string" required="yes" />
  <span onclick="toggle({$divID});">[Cast]</span>
</xsl:template>

<xsl:template match="CastList">
  <xsl:param name="divID" as="xs:string" required="yes" />
  <div id="{$divID}" style="display: none;" class="castlist">
    <xsl:apply-templates select="CastMember">
      <xsl:sort select="substring-after(Character/Name, ' ')" />
      <xsl:sort select="substring-before(Character/Name, ' ')" />
    </xsl:apply-templates>
  </div>
</xsl:template>
  
<xsl:template match="CastMember">
  <div class="castmember">
    <span class="number">
      <xsl:number value="position()" format="{{1}}" />
    </span>
    <xsl:apply-templates select="Character" />
    <xsl:text> </xsl:text>
    <xsl:apply-templates select="Actor" />
  </div>
</xsl:template>
  
<xsl:template match="Character">
  <span class="character">
    <xsl:apply-templates select="if (Name) then Name else node()" />
  </span>
</xsl:template>

<xsl:template match="Actor">
  <span class="actor">
    <xsl:apply-templates select="if (Name) then Name else node()" />
  </span>
</xsl:template>

<xsl:attribute-set name="linkEvents">
  <xsl:attribute name="style">
    <xsl:text>color: black; border-bottom: 1pt groove #CCC</xsl:text>
  </xsl:attribute>
  <xsl:attribute name="onmouseover">
    <xsl:text>javascript:this.style.background = '#CCC';</xsl:text>
  </xsl:attribute>
  <xsl:attribute name="onmouseout">
    <xsl:text>javascript:this.style.background = 'transparent';</xsl:text>
  </xsl:attribute>
</xsl:attribute-set>
  
<xsl:template name="link" as="element()">
  <xsl:param name="href" as="xs:anyURI"  required="yes" />
  <xsl:param name="content" as="item()*" required="yes" />
  <a href="{$href}" xsl:use-attribute-sets="linkEvents">
    <xsl:sequence select="$content" />
  </a>
</xsl:template>
  
</xsl:stylesheet>