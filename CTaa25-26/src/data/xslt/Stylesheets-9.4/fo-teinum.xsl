<!-- $Id$ --><xsl:stylesheet xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" version="2.0">
   <!-- Template in teinum.xsl -->
   <xsl:import href="teinum.xsl"/>

   <xsl:template match="t:num">
       <xsl:param name="parm-leiden-style" tunnel="yes" required="no"/>
       <xsl:choose>
         <xsl:when test="$parm-leiden-style=('ddbdp','sammelbuch')              and string(.)">
            <fo:inline>
               <xsl:attribute name="title">
                  <xsl:choose>
                     <xsl:when test="contains(@value,'/') or @type='fraction'">
                        <xsl:text>fraction</xsl:text>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:text>number</xsl:text>
                     </xsl:otherwise>
                  </xsl:choose>
                  <xsl:choose>
                     <xsl:when test="string(@value)">
                        <xsl:text>: </xsl:text>
                        <xsl:value-of select="@value"/>
                     </xsl:when>
                     <xsl:when test="string(@atLeast) or string(@atMost)">
                        <xsl:text>: </xsl:text>
                        <xsl:if test="string(@atLeast)">
                           <xsl:value-of select="@atLeast"/>
                        </xsl:if>
                        <xsl:text>-</xsl:text>
                        <xsl:if test="string(@atMost)">
                           <xsl:value-of select="@atMost"/>
                        </xsl:if>
                     </xsl:when>
                  </xsl:choose>
                  <xsl:if test="child::t:certainty[@match='../@value']">
                     <xsl:text>(?)</xsl:text>
                  </xsl:if>
               </xsl:attribute>
               <xsl:apply-imports/>
            </fo:inline>
         </xsl:when>
         <xsl:when test="$parm-leiden-style = 'panciera' and             ancestor::t:*[@xml:lang][1][@xml:lang = 'la']">
            <fo:inline border-top-style="solid" border-top-color="black" border-top-width="thin">
               <xsl:apply-imports/>
            </fo:inline>
         </xsl:when>
         <xsl:otherwise>
            <xsl:apply-imports/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

</xsl:stylesheet>