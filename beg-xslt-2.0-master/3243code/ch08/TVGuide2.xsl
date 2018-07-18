<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xdt="http://www.w3.org/2005/04/xpath-datatypes">

<xsl:variable name="StarTrekLogo" as="element()">
  <xsl:element name="img">
    <xsl:attribute name="src">StarTrek.gif</xsl:attribute>
    <xsl:attribute name="alt">[Star Trek]</xsl:attribute>
    <xsl:attribute name="width">20</xsl:attribute>
    <xsl:attribute name="height">20</xsl:attribute>
  </xsl:element>
</xsl:variable>

<xsl:variable name="ChannelList" as="element()+">
  <xsl:element name="p">
    <xsl:apply-templates select="/TVGuide/Channel" mode="ChannelList" />
  </xsl:element>
</xsl:variable>

<xsl:template match="/">
  <xsl:element name="html">
    <xsl:element name="head">
      <xsl:element name="title">TV Guide</xsl:element>
      <xsl:element name="link">
        <xsl:attribute name="rel">stylesheet</xsl:attribute>
        <xsl:attribute name="href">TVGuide.css</xsl:attribute>
      </xsl:element>
      <xsl:element name="script"> 
        <xsl:attribute name="type">text/javascript</xsl:attribute>
        <![CDATA[
        function toggle(element) {
          if (element.style.display == 'none') {
            element.style.display = 'block';
          } else {
            element.style.display = 'none';
          }
        }
        ]]>
      </xsl:element>
    </xsl:element>

    <xsl:element name="body">
      <xsl:element name="h1">TV Guide</xsl:element>
      <xsl:apply-templates select="TVGuide" />
    </xsl:element>
  </xsl:element>
</xsl:template>

<xsl:template match="TVGuide">
  <xsl:sequence select="$ChannelList" />
  <xsl:apply-templates select="Channel" />
  <xsl:sequence select="$ChannelList" />
</xsl:template>

<xsl:template match="Channel" mode="ChannelList">
  <xsl:element name="a">
    <xsl:attribute name="href">#<xsl:value-of select="Name" /></xsl:attribute>
    <xsl:value-of select="Name" />
  </xsl:element>
  <xsl:if test="position() != last()"> | </xsl:if>
</xsl:template>

<xsl:template match="Channel/Name">
  <xsl:element name="h2">
    <xsl:attribute name="class">channel</xsl:attribute>
    <xsl:element name="a">
      <xsl:attribute name="name"><xsl:value-of select="." /></xsl:attribute>
      <xsl:attribute name="id"><xsl:value-of select="." /></xsl:attribute>
      <xsl:apply-templates />
    </xsl:element>
  </xsl:element>
</xsl:template>

<xsl:template match="Program[1]" priority="1">
  <xsl:element name="div">
    <xsl:attribute name="class">nowShowing</xsl:attribute>
    <xsl:apply-templates select="." mode="Details" />
  </xsl:element>  
</xsl:template>

<xsl:template match="Program[@flag = ('favorite', 'interesting') or 
                             @rating > 6 or
                             (some $n in (Series, Title, Description)
                              satisfies contains(lower-case($n), 'news'))]">
  <xsl:element name="div"> 
    <xsl:attribute name="class">interesting</xsl:attribute>
    <xsl:apply-templates select="." mode="Details" />
  </xsl:element>
</xsl:template>

<xsl:template match="Program">
  <xsl:element name="div">
    <xsl:apply-templates select="." mode="Details" />
  </xsl:element>
</xsl:template>

<xsl:template match="Program" mode="Details">
  <xsl:variable name="castList" as="element()?" select="CastList" />
  <xsl:variable name="programID" as="xs:string" 
                select="concat(Series, 'Cast')" />
  <xsl:element name="p">
    <xsl:apply-templates select="Start" /><xsl:element name="br" />
    <xsl:for-each select="1 to @rating">
      <xsl:element name="img">
        <xsl:attribute name="src">star.gif</xsl:attribute>
        <xsl:attribute name="alt">*</xsl:attribute>
        <xsl:attribute name="height">15</xsl:attribute>
        <xsl:attribute name="width">15</xsl:attribute>
      </xsl:element>
    </xsl:for-each>
    <xsl:element name="br" />
    <xsl:if test="@flag">
      <xsl:element name="img">
        <xsl:attribute name="src"><xsl:value-of select="if (@flag = 'favorite') then 'favorite' else 'interest'" />.gif</xsl:attribute>
        <xsl:attribute name="alt">[<xsl:value-of select="if (@flag = 'favorite') then 'Favorite' else 'Interest'" />]</xsl:attribute>
        <xsl:attribute name="width">20</xsl:attribute>
        <xsl:attribute name="height">20</xsl:attribute>
      </xsl:element>
    </xsl:if>
    <xsl:if test="starts-with(Series, 'StarTrek')">
      <xsl:sequence select="$StarTrekLogo" />
    </xsl:if>
    <xsl:element name="span"> 
      <xsl:attribute name="class">title</xsl:attribute>
      <xsl:choose>
        <xsl:when test="string(Series)">
          <xsl:value-of select="Series" />
          <xsl:if test="string(Title)">
            - 
            <xsl:element name="span">
              <xsl:attribute name="class">subtitle</xsl:attribute>
              <xsl:value-of select="Title" />
            </xsl:element>
          </xsl:if>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="Title" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:element>
    <xsl:element name="br" />
    <xsl:apply-templates select="Description" />
    <xsl:apply-templates select="$castList" mode="DisplayToggle">
      <xsl:with-param name="divID" select="$programID" />
    </xsl:apply-templates>
  </xsl:element>
  <xsl:apply-templates select="$castList">
    <xsl:with-param name="divID" select="$programID" />
  </xsl:apply-templates>
</xsl:template>

<xsl:template match="Start">
  <xsl:variable name="endDateTime" as="element(Start)?"
    select="parent::Program/following-sibling::Program[1]/Start" />
  <xsl:element name="span"> 
    <xsl:attribute name="class">date</xsl:attribute>
    <xsl:value-of select="format-dateTime(xs:dateTime(.), 
                                          '[M]/[D]/[Y] [H01]:[m]')" />
    <xsl:if test="$endDateTime">
      <xsl:value-of select="format-dateTime(xs:dateTime($endDateTime), 
                                            ' - [H01]:[m]')" />
    </xsl:if>                                        
  </xsl:element>
</xsl:template>

<xsl:template match="CastList" mode="DisplayToggle">
  <xsl:param name="divID" as="xs:string" required="yes" />
  <xsl:element name="span">
    <xsl:attribute name="onclick">toggle({$divID});</xsl:attribute>
    [Cast]
  </xsl:element>
</xsl:template>

<xsl:template match="CastList">
  <xsl:param name="divID" as="xs:string" required="yes" />
  <xsl:element name="div"> 
    <xsl:attribute name="id"><xsl:value-of select="$divID" /></xsl:attribute>
    <xsl:attribute name="style">display: none;</xsl:attribute>
    <xsl:element name="ul">
      <xsl:attribute name="class">castlist</xsl:attribute>
      <xsl:apply-templates />
    </xsl:element>
  </xsl:element>
</xsl:template>

<xsl:template match="CastMember">
  <xsl:element name="li">
    <xsl:apply-templates select="Character" />
    <xsl:apply-templates select="Actor" />
  </xsl:element>
</xsl:template>

<xsl:template match="Character">
  <xsl:element name="span">
    <xsl:attribute name="class">character</xsl:attribute>
    <xsl:apply-templates select="if (Name) then Name else node()" />
  </xsl:element>
</xsl:template>

<xsl:template match="Actor">
  <xsl:element name="span">
    <xsl:attribute name="class">actor</xsl:attribute>
    <xsl:apply-templates select="if (Name) then Name else node()" />
  </xsl:element>
</xsl:template>

<xsl:template match="Description//Link">
  <xsl:element name="a">
    <xsl:attribute name="href"><xsl:value-of select="@href" /></xsl:attribute>
    <xsl:apply-templates />
  </xsl:element>
</xsl:template>

<xsl:template match="Description//Program">
  <xsl:element name="span">
    <xsl:attribute name="class">program</xsl:attribute>
    <xsl:apply-templates />
  </xsl:element>
</xsl:template>

<xsl:template match="Description//Series">
  <xsl:element name="span">
    <xsl:attribute name="class">series</xsl:attribute>
    <xsl:apply-templates />
  </xsl:element>
</xsl:template>

<xsl:template match="Description//Channel">
  <xsl:element name="span">
    <xsl:attribute name="class">channel</xsl:attribute>
    <xsl:apply-templates />
  </xsl:element>
</xsl:template>

</xsl:stylesheet>