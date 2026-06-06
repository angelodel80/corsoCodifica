<!-- $Id$ --><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="t" version="2.0">
  
  
  <xsl:template match="t:div/t:head">
      <fo:block font-size="larger">
         <xsl:apply-templates/>
      </fo:block>
  </xsl:template>
   
   <xsl:template match="t:body/t:head">
       <xsl:param name="parm-leiden-style" tunnel="yes" required="no"/>
       <xsl:choose>
           <xsl:when test="$parm-leiden-style='ddbdp'">
            <xsl:element name="fo:block">
               <xsl:apply-templates/>
            </xsl:element>
         </xsl:when>
         <xsl:otherwise>
            <fo:block font-size="larger" font-weight="700">
               <xsl:apply-templates/>
            </fo:block>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
  
</xsl:stylesheet>