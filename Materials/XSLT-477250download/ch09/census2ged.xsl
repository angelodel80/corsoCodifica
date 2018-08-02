<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
   <xsl:param name="censusyear">1851</xsl:param>
   <xsl:param name="censusdate">30 MARCH 1851</xsl:param>
   <xsl:param name="censuscounty">KEN</xsl:param>
   <xsl:param name="censusplace">Ringwould</xsl:param>
   <xsl:template match="/">

      <xsl:result-document href="gedcom60.xml">
         <GEDCOM>
            <xsl:variable name="families"
               select="//person[relation='Head' or relation='Wife' or relation='Daughter'or relation='Son']"/>
            <xsl:for-each select="$families">

               <IndividualRec Id="{generate-id()}">
                  <IndivName>
                     <NamePart Type="given name" Level="3">
                        <xsl:value-of select="firstname"/>
                     </NamePart>
                     <NamePart Type="surname" Level="1">
                        <xsl:value-of select="surname"/>
                     </NamePart>
                  </IndivName>
                  <Gender>
                     <xsl:value-of select="upper-case(sex)"/>
                  </Gender>
                  <xsl:if test="string-length(occupation) gt 0">
                     <PersInfo Type="occupation">
                        <Information>
                           <xsl:value-of select="occupation"/>
                        </Information>
                        <Date>
                           <xsl:value-of select="$censusdate"/>
                        </Date>
                     </PersInfo>
                  </xsl:if>
                  <PersInfo Type="residence">
                     <Date>
                        <xsl:value-of select="$censusdate"/>
                     </Date>
                     <Place>
                        <PlaceName>
                           <PlacePart Type="country" Level="1">GBR</PlacePart>
                           <PlacePart Type="county" Level="2">
                              <xsl:value-of select="$censuscounty"/>
                           </PlacePart>
                           <PlacePart Level="4">
                              <xsl:value-of select="$censusplace"/>
                           </PlacePart>
                        </PlaceName>
                     </Place>
                  </PersInfo>
                  <ExternalID Type="User"
                     Id="{concat(ancestor::census/@xml:id,'/',folio,'/',page)}"
                  />
               </IndividualRec>

               <EventRec Type="birth">
                  <xsl:attribute name="Id">
                     <xsl:text>E</xsl:text>
                     <xsl:number level="any" format="001"/>
                  </xsl:attribute>
                  <Participant>
                     <Link Target="IndividualRec" Ref="{generate-id()}"/>
                  </Participant>
                  <Date>
                     <xsl:value-of select="concat('CAL ',$censusyear - age)"/>
                  </Date>
                  <Place>
                     <PlaceName>
                        <PlacePart Type="country" Level="1">GBR</PlacePart>
                        <PlacePart Type="county" Level="2">
                           <xsl:value-of select="county"/>
                        </PlacePart>
                        <PlacePart Level="4">
                           <xsl:value-of select="birthplace"/>
                        </PlacePart>
                     </PlaceName>
                  </Place>
               </EventRec>

            </xsl:for-each>

            <xsl:for-each-group select="$families" group-adjacent="number">
               <FamilyRec>
                  <xsl:attribute name="Id">
                     <xsl:text>F</xsl:text>
                     <xsl:number level="any" format="001"/>
                  </xsl:attribute>
                  <xsl:for-each select="current-group()">


                     <xsl:choose>
                        <xsl:when test="relation='Head'">
                           <HusbFath>
                              <Link Target="IndividualRec" Ref="{generate-id()}"
                              />
                           </HusbFath>
                        </xsl:when>
                        <xsl:when test="relation='Wife'">
                           <WifeMoth>> <Link Target="IndividualRec"
                                 Ref="{generate-id()}"/>
                           </WifeMoth>
                        </xsl:when>
                        <xsl:when test="relation='Daughter' or relation='Son'">
                           <Child>
                              <Link Target="IndividualRec" Ref="{generate-id()}"
                              />
                           </Child>
                        </xsl:when>

                     </xsl:choose>

                  </xsl:for-each>
               </FamilyRec>
            </xsl:for-each-group>

         </GEDCOM>
      </xsl:result-document>

   </xsl:template>



</xsl:stylesheet>
