<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xdt="http://www.w3.org/2005/04/xpath-datatypes"
                exclude-result-prefixes="xs xdt"
                xmlns="http://www.w3.org/1999/xhtml">

<xsl:param name="sortOrder" as="xs:string" select="'descending'" />  
  
<xsl:output method="xhtml"
            doctype-public="-//W3C//DTD XHTML 1.1//EN"
            doctype-system="DTD/xhtml11.dtd"
            cdata-section-elements="script style"
            encoding="ISO-8859-1" />  
  
<xsl:variable name="StarTrekLogo" as="element()">
  <img src="StarTrek.gif" alt="[Star Trek]" width="20" height="20" />
</xsl:variable>
  
<xsl:variable name="Channels" as="element(Channel)+">
  <xsl:perform-sort select="/TVGuide/Channel">
    <xsl:sort select="avg(Program/@rating)" order="{$sortOrder}" />
    <xsl:sort select="xs:integer(Program[1]/@rating)" order="{$sortOrder}" />
  </xsl:perform-sort>
</xsl:variable>
  
<xsl:variable name="ChannelList" as="element()+">
  <p><xsl:apply-templates select="$Channels" mode="ChannelList" /></p>
</xsl:variable>

<xsl:template match="/">
  <html>
    <head>
      <title>TV Guide</title>
      <link rel="stylesheet" href="TVGuide2.css" />
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
</xsl:template>

<xsl:template match="Channel" mode="ChannelList">
  <a href="#{Name}"><xsl:value-of select="Name" /></a>
  <xsl:if test="position() != last()"> | </xsl:if>
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
    <xsl:if test="@flag = ('favorite', 'interesting') or
                  @rating > 6 or 
                  (some $n in (Series, Title, Description)
                   satisfies contains(lower-case($n), 'news'))">
      <xsl:attribute name="class" select="'interesting'" />
    </xsl:if>
    <xsl:apply-templates select="." mode="Details" />
  </div>
</xsl:template>
  
<xsl:template match="Program" mode="Details">
  <xsl:variable name="castList" as="element()?" select="CastList" />
  <xsl:variable name="programID" as="xs:string" 
                select="concat(Series, 'Cast')" />
  <p>
    <xsl:apply-templates select="Start" /><br />
    <xsl:for-each select="1 to @rating">
      <img src="star.gif" alt="*" height="15" width="15" />
    </xsl:for-each>
    <br />
    <xsl:if test="@flag">
      <img src="{if (@flag = 'favorite') then 'favorite' else 'interest'}.gif" 
           alt="[{if (@flag = 'favorite') then 'Favorite' else 'Interest'}]" 
           width="20" height="20" />
    </xsl:if>
    <xsl:if test="starts-with(Series, 'StarTrek')">
      <xsl:sequence select="$StarTrekLogo" />
    </xsl:if>
    <span class="title">
      <xsl:choose>
        <xsl:when test="string(Series)">
          <xsl:value-of select="Series" />
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
  <div id="{$divID}" style="display: none;">
    <ul class="castlist"><xsl:apply-templates /></ul>
  </div>
</xsl:template>

<xsl:template match="CastMember">
  <li>
    <xsl:apply-templates select="Character" />
    <xsl:text> </xsl:text>
    <xsl:apply-templates select="Actor" />
  </li>
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

<xsl:template match="Description//Link">
  <a href="{@href}"><xsl:apply-templates /></a>
</xsl:template>

<xsl:template match="Description//Program">
  <span class="program"><xsl:apply-templates /></span>
</xsl:template>

<xsl:template match="Description//Series">
  <span class="series"><xsl:apply-templates /></span>
</xsl:template>

<xsl:template match="Description//Channel">
  <span class="channel"><xsl:apply-templates /></span>
</xsl:template>

</xsl:stylesheet>