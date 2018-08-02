<?xml version="1.0" encoding="utf-8"?>
<!-- tutorial.xsl -->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html"/>

  <xsl:template match="tutorial">
    <xsl:for-each select="section">
      <h1>
        <xsl:text>Section </xsl:text>
        <xsl:value-of select="position()"/>
        <xsl:text>. </xsl:text>
        <xsl:value-of select="title"/>
      </h1>
      <ul>
        <xsl:for-each select="panel">
          <li>
            <xsl:value-of select="position()"/>
            <xsl:text>. </xsl:text>
            <xsl:value-of select="title"/>
          </li>
        </xsl:for-each>
      </ul>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
