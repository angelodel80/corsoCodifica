<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" 
                version="2.0">
  <!-- Called from start-edition.xsl -->

  <xsl:template name="metadata">
      <p>
         <strong>Publikation: </strong>
         <xsl:value-of select="//t:div[@type = 'bibliography' and @subtype = 'principalEdition']
            /t:listBibl/t:bibl[@type = 'publication' and @subtype = 'principal']/t:title[@type = 'abbreviated']"/>
         <xsl:text> </xsl:text>
         <xsl:value-of select="//t:div[@type = 'bibliography' and @subtype = 'principalEdition']
            /t:listBibl/t:bibl[@type = 'publication' and @subtype = 'principal']/t:biblScope[@type='volume']"/>
         <xsl:value-of select="//t:div[@type = 'bibliography' and @subtype = 'principalEdition']
            /t:listBibl/t:bibl[@type = 'publication' and @subtype = 'principal']/t:biblScope[@type='fascicle']"/>
         <xsl:text> </xsl:text>
         <xsl:value-of select="//t:div[@type = 'bibliography' and @subtype = 'principalEdition']
            /t:listBibl/t:bibl[@type = 'publication' and @subtype = 'principal']/t:biblScope[@type='numbers']"/>
      </p>
      <xsl:if test="//t:div[@type = 'bibliography' and @subtype = 'otherPublications']">
         <p>
            <strong>Andere Publikationen: </strong>
            <xsl:for-each select="//t:div[@type = 'bibliography' and @subtype = 'otherPublications']//t:bibl">
               <xsl:value-of select="."/>
               <xsl:if test="following-sibling::t:bibl">
                  <xsl:text>; </xsl:text>
               </xsl:if>
            </xsl:for-each>
         </p>
      </xsl:if>
      <p>
         <strong>Datierung: </strong>
         <xsl:value-of select="//t:div[@type = 'commentary' and @subtype = 'textDate']
            /t:p/t:date[@type = 'textDate']"/>
      </p>
      <p>
         <strong>Ort: </strong>
         <xsl:value-of select="//t:div[@type = 'history' and @subtype = 'locations']/t:p"/>
      </p>
      <p>
         <strong>Originaltitel: </strong>
         <xsl:value-of select="//t:teiHeader/t:fileDesc/t:titleStmt/t:title"/>
      </p>
      <p>
         <strong>Material: </strong>
         <xsl:value-of select="//t:div[@type = 'description']//t:rs[@type = 'material']"/>
      </p>
      <p>
         <strong>Abbildung: </strong>
         <xsl:choose>
            <xsl:when test="//t:div[@type='bibliography' and @subtype='illustrations']//t:bibl[@type = 'illustration']">
               <xsl:for-each select="//t:div[@type='bibliography' and @subtype='illustrations']//t:bibl[@type = 'illustration']">
                  <xsl:if test="preceding-sibling::t:bibl[@type = 'illustration']">
                     <xsl:text>, </xsl:text>
                  </xsl:if>
                  <xsl:value-of select="."/>
               </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
               <xsl:text>keiner</xsl:text>
            </xsl:otherwise>
         </xsl:choose>
         <xsl:if test="string(//t:div[@type='figure']//t:figure/@href)">
            <xsl:for-each select="//t:div[@type='figure']//t:figure[string(@href)]">
               <br/>
               <a href="{@href}">
                  <xsl:value-of select="t:figDesc"/>
               </a>
            </xsl:for-each>
         </xsl:if>
      </p>
      <xsl:if test="//t:div[@type = 'bibliography' and @subtype = 'corrections']">
         <p>
            <strong>
               <xsl:value-of select="//t:div[@type = 'bibliography' and @subtype = 'corrections']/t:head"/>
               <xsl:text>: </xsl:text>
            </strong>
            <xsl:for-each select="//t:div[@type = 'bibliography' and @subtype = 'corrections']//t:bibl">
               <xsl:if test="preceding-sibling::t:bibl">
                  <xsl:text>, </xsl:text>
               </xsl:if>
               <xsl:value-of select="."/>
            </xsl:for-each>
         </p>
      </xsl:if>
      <p>
         <strong>Text der DDBDP: </strong>
         <xsl:variable name="db-link">
            <xsl:value-of select="//t:div[@type = 'bibliography' and @subtype = 'principalEdition']
               /t:listBibl/t:bibl[@type = 'DDbDP']/t:series"/>
            <xsl:text>:volume=</xsl:text>
            <xsl:value-of select="//t:div[@type = 'bibliography' and @subtype = 'principalEdition']
               /t:listBibl/t:bibl[@type = 'DDbDP']/t:biblScope[@type = 'volume']"/>
            <xsl:text>:document=</xsl:text>
            <xsl:value-of select="//t:div[@type = 'bibliography' and @subtype = 'principalEdition']
               /t:listBibl/t:bibl[@type = 'DDbDP']/t:biblScope[@type = 'numbers']"/>
         </xsl:variable>
         <a>
            <xsl:attribute name="href">
               <xsl:text>http://www.perseus.tufts.edu/cgi-bin/ptext?doc=Perseus:text:1999.05.</xsl:text>
               <xsl:value-of select="$db-link"/>
            </xsl:attribute>
            <xsl:text>Server in Somerville</xsl:text>
         </a>
         <xsl:text> </xsl:text>
         <a>
            <xsl:attribute name="href">
               <xsl:text>http://perseus.mpiwg-berlin.mpg.de/cgi-bin/ptext?doc=Perseus:text:1999.05.</xsl:text>
               <xsl:value-of select="$db-link"/>
            </xsl:attribute>
            <xsl:text>Server in Berlin</xsl:text>
         </a>
      </p>
      <p>
         <strong>Bemerkungen: </strong>
         <xsl:value-of select="//t:div[@type = 'commentary' and @subtype = 'general']/t:p"/>
      </p>
      <xsl:if test="//t:div[@type='bibliography' and @subtype='translations']">
         <p>
            <strong>Übersetzungen: </strong>
            <xsl:for-each select="//t:div[@type='bibliography' and @subtype='translations']/t:listBibl">
               <xsl:value-of select="t:head"/>
               <xsl:text> </xsl:text>
               <xsl:for-each select="t:bibl[@type = 'translations']">
                  <xsl:if test="preceding-sibling::t:bibl[@type = 'translations']">
                     <xsl:text>, </xsl:text>
                  </xsl:if>
                  <xsl:value-of select="."/>
               </xsl:for-each>
            </xsl:for-each>
         </p>
      </xsl:if>
      <p>
         <strong>Inhalt: </strong>
         <xsl:for-each select="//t:teiHeader/t:profileDesc//t:keywords/t:term/t:rs[@type = 'textType']">
            <xsl:if test="preceding-sibling::t:rs">
               <xsl:text>, </xsl:text>
            </xsl:if>
            <xsl:value-of select="."/>
         </xsl:for-each>
      </p>
      <xsl:if test="//t:div[@type = 'commentary' and @subtype = 'mentionedDates']//t:date[@type = 'mentioned']">
         <p>
            <strong>
               <xsl:value-of select="//t:div[@type = 'commentary' and @subtype = 'mentionedDates']/t:head"/>
               <xsl:text>: </xsl:text>
            </strong>
            <xsl:for-each select="//t:div[@type = 'commentary' and @subtype = 'mentionedDates']/t:p">
               <xsl:value-of select="."/>
               <xsl:if test="following-sibling::t:p">
                  <xsl:text>; </xsl:text>
               </xsl:if>
            </xsl:for-each>
         </p>
      </xsl:if>

  </xsl:template>

</xsl:stylesheet>