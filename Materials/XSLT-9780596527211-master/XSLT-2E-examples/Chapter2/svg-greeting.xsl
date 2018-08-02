<?xml version="1.0"?>
<!-- svg-greeting.xsl -->
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:svg="http://www.w3.org/2000/svg">

  <xsl:template match="/">
    <svg:svg width="10cm" height="4cm">
      <svg:g>
        <svg:defs>
          <svg:radialGradient id="MyGradient"
            cx="4cm" cy="2cm" r="3cm" fx="4cm" fy="2cm">
            <svg:stop offset="0%" style="stop-color:red"/>
            <svg:stop offset="50%" style="stop-color:blue"/>
            <svg:stop offset="100%" style="stop-color:red"/>
          </svg:radialGradient>
        </svg:defs>
        <svg:rect style="fill:url(#MyGradient); stroke:black"
          x="1cm" y="1cm" width="8cm" height="2cm"/>
        <svg:text x="5.05cm" y="2.25cm" text-anchor="middle" 
          style="font-family:Verdana; font-size:24; 
          font-weight:bold; fill:black">
          <xsl:apply-templates select="greeting"/>
        </svg:text>
        <svg:text x="5cm" y="2.2cm" text-anchor="middle" 
          style="font-family:Verdana; font-size:24; 
          font-weight:bold; fill:white">
          <xsl:apply-templates select="greeting"/>
        </svg:text>
      </svg:g>
    </svg:svg>
  </xsl:template>

  <xsl:template match="greeting">
    <xsl:value-of select="."/>
  </xsl:template>

</xsl:stylesheet>
