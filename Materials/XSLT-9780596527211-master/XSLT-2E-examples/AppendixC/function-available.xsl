<?xml version="1.0"?>
<!-- function-available.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:jpeg="class:JPEGWriter"
  extension-element-prefixes="jpeg">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;A test of function-avilable():&#xA;&#xA;</xsl:text>
    <xsl:for-each select="list/listitem">
      <xsl:choose>
        <xsl:when test="function-available('jpeg:buildJPEGFile')"> 
          <xsl:value-of 
            select="jpeg:buildJPEGFile(., 'titlebar.jpg', 
            concat('album', position(), '.jpg'), 
            'Verdana Bold Italic', 20, 12, 20, '000000')"/>
          <xsl:text>See the file </xsl:text>
          <xsl:value-of select="concat('album', position(), '.jpg')"/>
          <xsl:text> to see the title of album #</xsl:text>
          <xsl:value-of select="position()"/>
          <xsl:text>&#xA;</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="position()"/>
          <xsl:text>. </xsl:text>
          <xsl:value-of select="."/>
          <xsl:text>&#xA;</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
