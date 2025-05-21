<!-- $Id$ --><xsl:stylesheet xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" version="2.0">
  <!-- Imported templates can be found in teigap.xsl -->
  <xsl:import href="teigap.xsl"/>
  
  <xsl:template match="t:gap[@reason = 'lost']">
      <xsl:param name="parm-leiden-style" tunnel="yes" required="no"/>
      <xsl:if test="@extent='unknown' and @reason='lost' and @unit='line' and ($parm-leiden-style = 'ddbdp' or $parm-leiden-style = 'sammelbuch')           and not(preceding-sibling::t:*[1][local-name() = 'lb'])">
         <!--     adds a newline character before gap-extent-line in DDbDP unless <lb/> present    -->
         <fo:block/>
      </xsl:if>
      <fo:inline><xsl:apply-imports/></fo:inline>
  </xsl:template>
  
  <xsl:template match="t:gap">
    <fo:inline><xsl:apply-imports/></fo:inline>
  </xsl:template>
  
</xsl:stylesheet>