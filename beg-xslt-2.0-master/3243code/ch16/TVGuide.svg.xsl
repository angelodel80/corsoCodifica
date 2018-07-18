<?xml version="1.0"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/2000/svg"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xdt="http://www.w3.org/2005/02/xpath-datatypes"
                exclude-result-prefixes="xs xdt">

<xsl:strip-space elements="*" />

<xsl:output method="xml" media-type="image/svg+xml"
            indent="yes" encoding="ISO-8859-1" />

<xsl:variable name="startTime" as="xs:time" select="xs:time('19:00:00')" />
<xsl:variable name="endTime" as="xs:time" select="xs:time('22:00:00')" />

<xsl:variable name="intervals" as="xs:integer"
              select="xs:integer(($endTime - $startTime) div xdt:dayTimeDuration('PT15M'))" />
<xsl:variable name="nChannels" as="xs:integer" 
              select="count(/TVGuide/Channel)" />

<xsl:variable name="width" as="xs:integer" 
              select="($intervals * 100) + 200" />
<xsl:variable name="height" as="xs:integer" 
              select="($nChannels * 100) + 100" />

<xsl:variable name="seriesDocument" as="document-node()" 
              select="document('series.xml')" />

<xsl:key name="series" match="Series" use="@id" />

<xsl:template match="TVGuide">
  <svg viewBox="0 0 {$width} {$height}">
    <title>TV Guide</title>
    <xsl:call-template name="timelineMarkers" />
    <xsl:call-template name="verticalGridlines" />
    <xsl:apply-templates select="Channel" />
    <xsl:call-template name="horizontalGridlines" />
  </svg>
</xsl:template>

<xsl:template name="timelineMarkers">
  <g text-anchor="middle" font-size="20" fill="black">
    <desc>Timeline markers</desc>
    <xsl:for-each select="0 to $intervals">
      <text x="{(. * 100) + 200}" y="70">
        <xsl:variable name="time" as="xs:time" 
                      select="$startTime + (. * xdt:dayTimeDuration('PT15M'))" />
        <xsl:value-of select="format-time($time, '[h,1]:[m]')" />
      </text>
    </xsl:for-each>
  </g>
</xsl:template>

<xsl:template name="verticalGridlines">
  <g stroke="black" stroke-width="2">
    <desc>Vertical grid lines</desc>
    <xsl:for-each select="0 to $intervals">
      <line x1="{(. * 100) + 200}" y1="80" 
            x2="{(. * 100) + 200}" y2="{$height}" />
    </xsl:for-each>
  </g>
</xsl:template>

<xsl:template name="horizontalGridlines">
  <g stroke="black" stroke-width="2">
    <desc>Horizontal grid lines</desc>
    <xsl:for-each select="0 to $nChannels">
      <line x1="0"        y1="{(. * 100) + 100}"
            x2="{$width}" y2="{(. * 100) + 100}" />
    </xsl:for-each>
  </g>
</xsl:template>

<xsl:template match="Channel">
  <g transform="translate(0, {position() * 100})">
    <desc><xsl:value-of select="Name" /></desc>
    <g>
      <desc>Channel Label</desc>
      <rect x="0" y="0" height="100" width="200" fill="#C00" />
      <text x="195" y="70" text-anchor="end" font-size="40" fill="yellow">
        <xsl:value-of select="Name" />
      </text>
    </g>
    <g>
      <desc>Programs</desc>
      <xsl:apply-templates select="Program" />
    </g>
  </g>
</xsl:template>

<xsl:template match="Program">
  <xsl:variable name="time" as="xs:time" 
                select="xs:time(xs:dateTime(Start))" />
  <xsl:if test="$time >= $startTime and $time &lt; $endTime">
    <xsl:variable name="start" as="xs:double" 
      select="($time - $startTime) div xdt:dayTimeDuration('PT15M')" />
    <xsl:variable name="indent" as="xs:string" 
      select="format-number(($start * 100) + 200, '0.##')" />
    <xsl:variable name="duration" as="xs:double" 
      select="xdt:dayTimeDuration(Duration) div xdt:dayTimeDuration('PT15M')" />
    <xsl:variable name="width" as="xs:string" 
      select="format-number($duration * 100, '0.##')" />
    <g transform="translate({$indent})">
      <rect x="0" y="0" height="100" width="{$width}"
            fill="#CCC" stroke="black" stroke-width="2" />
      <text y="0" font-size="20" fill="black">
        <xsl:apply-templates select="Series[string(.)]" />
        <xsl:apply-templates select="Title[string(.)]" />
      </text>
    </g>
  </xsl:if>
</xsl:template>

<xsl:template match="Program/Series">
  <tspan x="0.5em" dy="25" font-weight="bold">
    <xsl:value-of select="key('series', ., $seriesDocument)/Title" />
  </tspan>
</xsl:template>

<xsl:template match="Program/Title">
  <tspan x="0.5em" dy="25" font-style="italic">
    <xsl:value-of select="." />
  </tspan>
</xsl:template>

</xsl:stylesheet>