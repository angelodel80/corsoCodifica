<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0"
                version="2.0">

    <xsl:template match="t:ab">
        <xsl:param name="parm-edition-type" tunnel="yes" required="no"></xsl:param>
        <xsl:param name="parm-leiden-style" tunnel="yes" required="no"></xsl:param>
      <xsl:text>
</xsl:text>
      <xsl:apply-templates/>
      <!-- if next div or ab begins with lb[break=no], then add hyphen -->
      <xsl:if test="following::t:lb[1][@break='no' or @type='inWord'] and not($parm-edition-type='diplomatic')
          and not(starts-with($parm-leiden-style, 'edh') or $parm-leiden-style='eagletxt')">
          <xsl:text>-</xsl:text>
      </xsl:if>
  </xsl:template>
  
</xsl:stylesheet>
