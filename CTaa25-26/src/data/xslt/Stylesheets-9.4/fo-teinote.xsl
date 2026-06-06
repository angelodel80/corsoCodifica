<!-- $Id$ --><xsl:stylesheet xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" version="2.0">
  <!-- Template in teinote.xsl -->
  <xsl:import href="teinote.xsl"/>

   <xsl:template match="t:note">
      <xsl:param name="parm-leiden-style" tunnel="yes" required="no"/>
     <xsl:choose>
        <xsl:when test="$parm-leiden-style='iospe' and (ancestor::t:p or ancestor::t:l or ancestor::t:ab)">
           <xsl:apply-imports/>
        </xsl:when>
        <xsl:when test="ancestor::t:p or ancestor::t:l or ancestor::t:ab">
           <fo:inline font-style="italic"><xsl:apply-imports/></fo:inline>
        </xsl:when>
         <xsl:otherwise>
            <fo:block>
               <xsl:apply-imports/>
            </fo:block>
         </xsl:otherwise>
      </xsl:choose>
  </xsl:template>

</xsl:stylesheet>