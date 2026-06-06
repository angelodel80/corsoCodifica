<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0"
                version="2.0">

  <!-- General div match found in txt-teidiv.xsl -->

  <xsl:template match="t:div[@type = 'edition']" priority="1">
      <xsl:param name="parm-internal-app-style" tunnel="yes" required="no"></xsl:param>
      <xsl:param name="parm-leiden-style" tunnel="yes" required="no"></xsl:param>
      <!-- Two line breaks to give space -->
    <xsl:choose>
        <xsl:when test="starts-with($parm-leiden-style, 'edh')"/>
         <xsl:otherwise>
            <xsl:text>
&#xD;
&#xD;</xsl:text>
         </xsl:otherwise>
      </xsl:choose>
    
      <xsl:apply-templates/>
    
      <!-- Apparatus creation: look in tpl-apparatus.xsl for documentation -->
      <xsl:if test="$parm-internal-app-style = 'ddbdp'">
      <!-- Framework found in txt-tpl-apparatus.xsl -->
      <xsl:call-template name="tpl-apparatus"/>
      </xsl:if>
  </xsl:template>


  <xsl:template match="t:div[@type = 'textpart']" priority="1">
      <xsl:param name="parm-leiden-style" tunnel="yes" required="no"></xsl:param>
      <xsl:choose>
          <xsl:when test="starts-with($parm-leiden-style, 'edh')">
            <xsl:variable name="cur_parent" select="generate-id(parent::node())"/>
            <xsl:if test="preceding::t:div[@type='textpart'][1][generate-id(parent::node())=$cur_parent]">
               <xsl:text>// </xsl:text>
            </xsl:if>
            <xsl:text>(</xsl:text>
            <xsl:value-of select="@n"/>
            <xsl:text>) </xsl:text>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text>
&#xD;</xsl:text>
            <xsl:value-of select="@n"/>
         </xsl:otherwise>
      </xsl:choose>
    
      <xsl:apply-templates/>
  </xsl:template>

</xsl:stylesheet>
