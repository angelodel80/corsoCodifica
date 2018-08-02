<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

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
      <p>
        <xsl:apply-templates select="TVGuide/Channel"
                             mode="ChannelList" />
      </p>
      <xsl:apply-templates select="TVGuide/Channel" />
      <p>
        <xsl:apply-templates select="TVGuide/Channel"
                             mode="ChannelList" />
      </p>
    </body>
  </html>
</xsl:template>

<xsl:template match="Channel" mode="ChannelList">
  <xsl:if test="Program/@flag">
    [<a href="#{Name}"><xsl:value-of select="Name" /></a>]
  </xsl:if>
</xsl:template>

<xsl:template match="Channel">
  <xsl:if test="Program/@flag">
    <xsl:apply-templates />
  </xsl:if>
</xsl:template>

<xsl:template match="Channel/Name">
  <h2 class="channel">
    <a name="{.}" id="{.}"><xsl:apply-templates /></a>
  </h2>
</xsl:template>

<xsl:template match="Program">
  <xsl:choose>
    <xsl:when test="@flag = 'favorite' or @flag = 'interesting' or
                    @rating > 6 or contains(Series, 'News') or
                    contains(Title, 'News') or
                    contains(Description, 'news')">
      <div class="interesting">
        <xsl:apply-templates select="." mode="Details" />
      </div>
    </xsl:when>
    <xsl:otherwise>
      <div>
        <xsl:apply-templates select="." mode="Details" />
      </div>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="Program" mode="Details">
  <p>
    <xsl:if test="@flag">
      <img src="{if (@flag = 'favorite') then 'favorite' else 'interest'}.gif" 
           alt="[{if (@flag = 'favorite') then 'Favorite' else 'Interest'}]" 
           width="20" height="20" />
    </xsl:if>
    <xsl:if test="starts-with(Series, 'StarTrek')">
      <img src="StarTrek.gif" alt="[Star Trek]" width="20" height="20" />
    </xsl:if>
    <xsl:apply-templates select="Start" /><br />
    <span class="title">
      <xsl:choose>
        <xsl:when test="string(Series)">
          <xsl:value-of select="Series" />
          <xsl:if test="string(Title)">
            - <span class="subtitle"><xsl:value-of select="Title" /></span>
          </xsl:if>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="Title" />
        </xsl:otherwise>
      </xsl:choose>
    </span>
    <br />
    <xsl:apply-templates select="Description" />
    <xsl:if test="CastList">
      <span onclick="toggle({Series}Cast);">[Cast]</span>
    </xsl:if>
  </p>
  <xsl:if test="CastList">
    <div id="{Series}Cast" style="display: none;">
      <xsl:apply-templates select="CastList" />
    </div>
  </xsl:if>
</xsl:template>

<xsl:template match="Start">
  <span class="date"><xsl:apply-templates /></span>
</xsl:template>

<xsl:template match="CastList">
  <ul class="castlist"><xsl:apply-templates /></ul>
</xsl:template>

<xsl:template match="CastMember">
  <li>
    <xsl:apply-templates select="Character" />
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