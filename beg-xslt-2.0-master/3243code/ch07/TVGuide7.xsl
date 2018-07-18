<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xdt="http://www.w3.org/2005/04/xpath-datatypes"
                xmlns:tv="http://www.example.com/TVGuide">

<xsl:variable name="StarTrekLogo" as="element()">
  <img src="StarTrek.gif" alt="[Star Trek]" width="20" height="20" />
</xsl:variable>

<xsl:variable name="ChannelList" as="element()+">
  <p><xsl:apply-templates select="/tv:TVGuide/tv:Channel" mode="ChannelList" /></p>
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
      <xsl:apply-templates select="tv:TVGuide" />
    </body>
  </html>
</xsl:template>

<xsl:template match="tv:TVGuide">
  <xsl:sequence select="$ChannelList" />
  <xsl:apply-templates select="tv:Channel" />
  <xsl:sequence select="$ChannelList" />
</xsl:template>

<xsl:template match="tv:Channel" mode="ChannelList">
  <a href="#{tv:Name}"><xsl:value-of select="tv:Name" /></a>
  <xsl:if test="position() != last()"> | </xsl:if>
</xsl:template>

<xsl:template match="tv:Channel/tv:Name">
  <h2 class="channel">
    <a name="{.}" id="{.}"><xsl:apply-templates /></a>
  </h2>
</xsl:template>

<xsl:template match="tv:Program[1]" priority="1">
  <div class="nowShowing">
    <xsl:apply-templates select="." mode="Details" />
  </div>  
</xsl:template>

<xsl:template match="tv:Program[@flag = 'favorite' or @flag = 'interesting' or 
                                @rating > 6 or
                                contains(lower-case(tv:Series), 'news') or
                                contains(lower-case(tv:Title), 'news') or 
                                contains(lower-case(tv:Description), 'news')]">
  <div class="interesting">
    <xsl:apply-templates select="." mode="Details" />
  </div>
</xsl:template>

<xsl:template match="tv:Program">
  <div>
    <xsl:apply-templates select="." mode="Details" />
  </div>
</xsl:template>

<xsl:template match="tv:Program" mode="Details">
  <xsl:variable name="castList" as="element()?" select="tv:CastList" />
  <xsl:variable name="programID" as="xs:string" 
                select="concat(tv:Series, 'Cast')" />
  <p>
    <xsl:if test="@flag">
      <img src="{if (@flag = 'favorite') then 'favorite' else 'interest'}.gif" 
           alt="[{if (@flag = 'favorite') then 'Favorite' else 'Interest'}]" 
           width="20" height="20" />
    </xsl:if>
    <xsl:if test="starts-with(tv:Series, 'StarTrek')">
      <xsl:sequence select="$StarTrekLogo" />
    </xsl:if>
    <xsl:apply-templates select="tv:Start" /><br />
    <span class="title">
      <xsl:choose>
        <xsl:when test="string(tv:Series)">
          <xsl:value-of select="tv:Series" />
          <xsl:if test="string(tv:Title)">
            - <span class="subtitle"><xsl:value-of select="tv:Title" /></span>
          </xsl:if>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="tv:Title" />
        </xsl:otherwise>
      </xsl:choose>
    </span>
    <br />
    <xsl:apply-templates select="tv:Description" />
    <xsl:apply-templates select="$castList" mode="DisplayToggle">
      <xsl:with-param name="divID" select="$programID" />
    </xsl:apply-templates>
  </p>
  <xsl:apply-templates select="$castList">
    <xsl:with-param name="divID" select="$programID" />
  </xsl:apply-templates>
</xsl:template>

<xsl:template match="tv:Start">
  <span class="date">
    <xsl:value-of select="format-dateTime(xs:dateTime(.), 
                                          '[M]/[D]/[Y] [H01]:[m]')" />
  </span>
</xsl:template>

<xsl:template match="tv:CastList" mode="DisplayToggle">
  <xsl:param name="divID" as="xs:string" required="yes" />
  <span onclick="toggle({$divID});">[Cast]</span>
</xsl:template>

<xsl:template match="tv:CastList">
  <xsl:param name="divID" as="xs:string" required="yes" />
  <div id="{$divID}" style="display: none;">
    <ul class="castlist"><xsl:apply-templates /></ul>
  </div>
</xsl:template>

<xsl:template match="tv:CastMember">
  <li>
    <xsl:apply-templates select="tv:Character" />
    <xsl:apply-templates select="tv:Actor" />
  </li>
</xsl:template>

<xsl:template match="tv:Character">
  <span class="character">
    <xsl:apply-templates select="if (tv:Name) then tv:Name else node()" />
  </span>
</xsl:template>

<xsl:template match="tv:Actor">
  <span class="actor">
    <xsl:apply-templates select="if (tv:Name) then tv:Name else node()" />
  </span>
</xsl:template>

<xsl:template match="tv:Description//tv:Link">
  <a href="{@href}"><xsl:apply-templates /></a>
</xsl:template>

<xsl:template match="tv:Description//tv:Program">
  <span class="program"><xsl:apply-templates /></span>
</xsl:template>

<xsl:template match="tv:Description//tv:Series">
  <span class="series"><xsl:apply-templates /></span>
</xsl:template>

<xsl:template match="tv:Description//tv:Channel">
  <span class="channel"><xsl:apply-templates /></span>
</xsl:template>

</xsl:stylesheet>