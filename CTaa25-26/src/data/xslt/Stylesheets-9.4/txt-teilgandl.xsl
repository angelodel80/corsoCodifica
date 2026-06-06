<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0"
                version="2.0">
  <!-- template line-context can be found in teilgandl.xsl -->
  <xsl:include href="teilgandl.xsl"/>

  <xsl:template match="t:lg">
      <xsl:apply-templates/>
  </xsl:template>


  <xsl:template match="t:l">
      <xsl:param name="parm-line-inc" tunnel="yes" required="no"></xsl:param>
      <xsl:param name="parm-verse-lines" tunnel="yes" required="no"></xsl:param>
      <xsl:choose>
          <xsl:when test="$parm-verse-lines = 'yes'">
            <xsl:text>
&#xD;</xsl:text>
            <xsl:choose>
                <xsl:when test="number(@n) and @n mod number($parm-line-inc) = 0 and not(@n = 0)">
                  <xsl:text>	</xsl:text>
                  <xsl:value-of select="@n"/>
                  <xsl:text>	</xsl:text>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:text>		</xsl:text>
               </xsl:otherwise>
            </xsl:choose>
            <!-- found in teilgandl.xsl -->
        <xsl:call-template name="line-context"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:apply-templates/>
         </xsl:otherwise>
      </xsl:choose>

  </xsl:template>

</xsl:stylesheet>
