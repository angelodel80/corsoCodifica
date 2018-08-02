<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
   <xsl:param name="identifier"/>
   <xsl:param name="uri"/>
   <xsl:template match="/">
      <xsl:variable name="census" select="unparsed-text('census.csv')"/>
      <xsl:variable name="data">
         <data>
            <xsl:analyze-string select="$census" regex="\n">
               <xsl:non-matching-substring>
                  <row>
                     <xsl:analyze-string select="." regex="," flags="x">
                        <xsl:non-matching-substring>
                           <col>
                              <xsl:value-of select="normalize-space(.)"/>                            
                           </col>
                        </xsl:non-matching-substring>
                     </xsl:analyze-string>
                  </row>
               </xsl:non-matching-substring>
            </xsl:analyze-string>
         </data>
      </xsl:variable>
      
      <xsl:result-document href="census.xml">
         <census id="{$identifier}">
            <xsl:for-each select="$data//row">
               <person>                 
                  <folio>
                     <xsl:value-of select="col[1]"/>
                  </folio>
                  <page>
                     <xsl:value-of select="col[2]"/>
                  </page>
                  <number>
                     <xsl:value-of select="col[3]"/>
                  </number>
                  <surname>
                     <xsl:value-of select="col[4]"/>
                  </surname>
                  <firstname>
                     <xsl:value-of select="col[5]"/>
                  </firstname>
                  <relation>
                     <xsl:value-of select="col[6]"/>
                  </relation>
                  <condition>
                     <xsl:value-of select="col[7]"/>
                  </condition>
                  <sex>
                     <xsl:value-of select="col[8]"/>
                  </sex>
                  <age>
                     <xsl:value-of select="col[9]"/>
                  </age>
                  <occupation>
                     <xsl:value-of select="col[10]"/>
                  </occupation>
                  <birthplace>
                     <xsl:value-of select="col[11]"/>
                  </birthplace>
                  <county>
                     <xsl:value-of select="col[12]"/>
                  </county>
                  <sortkey>
                     <xsl:value-of select="col[13]"/>
                  </sortkey>
               </person>
            </xsl:for-each>           
         </census>
      </xsl:result-document>

   </xsl:template>
   
</xsl:stylesheet>
