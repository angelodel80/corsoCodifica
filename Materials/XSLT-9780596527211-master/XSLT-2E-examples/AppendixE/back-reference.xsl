<?xml version="1.0" encoding="utf-8"?>
<!-- back-reference.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>Using back-references to find words that begin &#xA;</xsl:text>
    <xsl:text>  and end with the same two letters:&#xA;&#xA;</xsl:text>
    <xsl:text>  replace($x, '([a-z]{2})(.*)\1', '$1--$2--$1')&#xA;</xsl:text>
    <xsl:text>    edited:    </xsl:text>
    <xsl:value-of 
      select="replace('edited', '([a-z]{2})(.*)\1', '$1--$2--$1')"/>
    <xsl:text>&#xA;    editor:    </xsl:text>
    <xsl:value-of 
      select="replace('editor', '([a-z]{2})(.*)\1', '$1--$2--$1')"/>
    <xsl:text>&#xA;    educated:  </xsl:text>
    <xsl:value-of 
      select="replace('educated', '([a-z]{2})(.*)\1', '$1--$2--$1')"/>
    <xsl:text>&#xA;    orator:    </xsl:text>
    <xsl:value-of 
      select="replace('orator', '([a-z]{2})(.*)\1', '$1--$2--$1')"/>
  </xsl:template>

</xsl:stylesheet>
