<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:str="http://www.example.com/string"
                exclude-result-prefixes="xs str"
                xmlns="http://www.w3.org/1999/xhtml">

<xsl:param name="alphabet" as="xs:string" 
           select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

<xsl:variable name="series" as="document-node()" select="doc('series.xml')" />  
<xsl:variable name="TVGuide" as="document-node()" select="/" />  

<xsl:key name="IDs" match="Series" use="@id" />  
<xsl:key name="seriesByFirstLetter" match="Series" 
         use="substring(@id, 1, 1)" />
<xsl:key name="programsBySeries" match="Program" use="Series" />  
 
<xsl:template match="TVGuide" mode="Series">
  <h2>Series</h2>
  <xsl:variable name="alphabet" as="xs:string+" 
    select="str:characters($alphabet)" />
  <xsl:for-each select="$alphabet">
    <xsl:variable name="series" as="element()*"
      select="key('seriesByFirstLetter', ., $series)" />
    <xsl:choose>
      <xsl:when test="$series">
        <xsl:call-template name="link">
          <xsl:with-param name="href" as="xs:anyURI" 
            select="xs:anyURI(concat('#series', .))" />
          <xsl:with-param name="content" as="xs:string" select="." />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="." />
      </xsl:otherwise>
    </xsl:choose>
    <xsl:if test="position() != last()"> . </xsl:if>
  </xsl:for-each>
  <xsl:for-each select="$alphabet">
    <xsl:variable name="series" as="element()*"
      select="key('seriesByFirstLetter', ., $series)" />
    <xsl:if test="$series">
      <h3>
        <a id="series{.}" name="series{.}">
          <xsl:value-of select="." />
        </a>
      </h3>
      <xsl:apply-templates select="$series">
        <xsl:sort select="@id" />
      </xsl:apply-templates>
    </xsl:if>
  </xsl:for-each>
</xsl:template>
  
<xsl:template match="SeriesList/Series">
  <div>
    <h3><a name="{@id}" id="{@id}"><xsl:value-of select="Title" /></a></h3>
    <p>
      <xsl:apply-templates select="Description" />
    </p>
    <h4>Episodes</h4>
    <ul>
      <xsl:for-each select="key('programsBySeries', @id, $TVGuide)">
        <li>
          <xsl:call-template name="link">
            <xsl:with-param name="href" as="xs:anyURI" select="xs:anyURI(concat('#', generate-id()))" />
            <xsl:with-param name="content">
              <xsl:value-of select="parent::Channel/Name" />
              <xsl:text> at </xsl:text>
              <xsl:value-of select="format-dateTime(Start,
                '[H01]:[m] on [M]/[D]/[Y]')" />
              <xsl:if test="string(Title)">
                <xsl:text>: </xsl:text>
                <xsl:value-of select="Title" />
              </xsl:if>
            </xsl:with-param>
          </xsl:call-template>
        </li>
      </xsl:for-each>
    </ul>
  </div>
</xsl:template>
    
</xsl:stylesheet>