<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0"
                xmlns:t="http://www.tei-c.org/ns/1.0"
               
                exclude-result-prefixes="t" 
                version="2.0">

  <!-- Called from start-edition.xsl -->
  <xsl:param name="sammelbuchIndex"> 
    <xsl:choose>
      <xsl:when test="matches(//t:teiHeader/t:fileDesc/t:publicationStmt/t:idno[@type='futurePrintRelease'], 'sb;\d+;\d+')">
        <xsl:value-of select="substring-after(substring-after(//t:teiHeader/t:fileDesc/t:publicationStmt/t:idno[@type='futurePrintRelease'], ';'), ';')" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="substring-after(substring-after(//t:teiHeader/t:fileDesc/t:publicationStmt/t:idno[@type='ddb-hybrid'], ';'), ';')" />
      </xsl:otherwise>  
    </xsl:choose>
  </xsl:param>

  <xsl:template name="metadata_header">
    <text:p text:style-name="Sammelbuch-Kopf">

      <!-- sammelbuch number -->
      <text:span text:style-name="Sammelbuch-Nummer">
        <xsl:value-of select="$sammelbuchIndex" />        
        <xsl:text>. </xsl:text>
      </text:span>

      <!-- material -->
      <xsl:value-of select="//t:teiHeader/t:fileDesc/t:sourceDesc/t:msDesc/t:physDesc/t:objectDesc/t:supportDesc/t:support/t:material"/>
      <xsl:text>. </xsl:text>

      <!-- title / new edition -->
      <xsl:choose>
        <xsl:when test="string(//t:teiHeader/t:fileDesc/t:sourceDesc/t:listBibl/t:bibl[@type='sb']/t:relatedItem[@type='reedition' and @subtype='reference']/t:bibl[@type='publication' and @subtype='other'])">
          <text:span text:style-name="Sammelbuch-Titel">
            <xsl:value-of select="//t:teiHeader/t:fileDesc/t:titleStmt/t:title"/>
            <xsl:text> (unter Nd. von </xsl:text>
            <xsl:value-of select="//t:teiHeader/t:fileDesc/t:sourceDesc/t:listBibl/t:bibl[@type='sb']/t:relatedItem[@type='reedition' and @subtype='reference']/t:bibl[@type='publication' and @subtype='other']"/>
            <xsl:text>). </xsl:text>
          </text:span>
        </xsl:when>
        <xsl:otherwise>
          <text:span text:style-name="Sammelbuch-Titel">
            <xsl:value-of select="//t:teiHeader/t:fileDesc/t:titleStmt/t:title"/>
            <xsl:text>. </xsl:text>
          </text:span>
        </xsl:otherwise>
      </xsl:choose>

      <!-- authors -->
      <xsl:for-each select="//t:teiHeader/t:fileDesc/t:sourceDesc/t:listBibl/t:bibl[@type='sb']/t:author">
        <text:span text:style-name="Sammelbuch-Herausgeber">
          <xsl:value-of select="." />
        </text:span>
        <xsl:choose>
          <xsl:when test="position() = last() - 1">
            <xsl:text> und </xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>, </xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:for-each>

      <!-- title -->
      <xsl:value-of select="//t:teiHeader/t:fileDesc/t:sourceDesc/t:listBibl/t:bibl[@type='sb']/t:title[@level='a' and @type='main']" />
      <xsl:text> </xsl:text>

      <!-- edition -->
      <xsl:text>(</xsl:text>
      <xsl:call-template name="metadata_edition">
        <xsl:with-param name="biblio" select="//t:teiHeader/t:fileDesc/t:sourceDesc/t:listBibl/t:bibl[@type='sb']"  />
      </xsl:call-template>
      <xsl:text>)</xsl:text>

    <!-- pagination -->
    <xsl:if test="string(//t:teiHeader/t:fileDesc/t:sourceDesc/t:listBibl/t:bibl[@type='sb']/t:biblScope[@type='page'])">
      <xsl:text>, S.</xsl:text>
      <xsl:value-of select="//t:teiHeader/t:fileDesc/t:sourceDesc/t:listBibl/t:bibl[@type='sb']/t:biblScope[@type='page']" />
    </xsl:if>
    <xsl:text>; </xsl:text>

    <!-- collection / inventory number -->
    <xsl:if test="string(//t:teiHeader/t:fileDesc/t:sourceDesc/t:msDesc/t:msIdentifier/t:collection)">
      <xsl:if test="string(//t:teiHeader/t:fileDesc/t:sourceDesc/t:msDesc/t:msIdentifier/t:placeName/t:settlement)">
        <xsl:value-of select="//t:teiHeader/t:fileDesc/t:sourceDesc/t:msDesc/t:msIdentifier/t:placeName/t:settlement" />
        <xsl:text>, </xsl:text>
      </xsl:if>
      <xsl:value-of select="//t:teiHeader/t:fileDesc/t:sourceDesc/t:msDesc/t:msIdentifier/t:collection" />
      <xsl:if test="string(//t:teiHeader/t:fileDesc/t:sourceDesc/t:msDesc/t:msIdentifier/t:idno[@type='invNo'])">
        <xsl:text>, </xsl:text>
        <xsl:value-of select="//t:teiHeader/t:fileDesc/t:sourceDesc/t:msDesc/t:msIdentifier/t:idno[@type='invNo']" />
      </xsl:if>
      <xsl:if test="//t:teiHeader/t:fileDesc/t:sourceDesc/t:msDesc/t:msIdentifier/t:altIdentifier[@type='temporary']">
        <xsl:text> (z.Z. </xsl:text>
        <xsl:value-of select="//t:teiHeader/t:fileDesc/t:sourceDesc/t:msDesc/t:msIdentifier/t:altIdentifier[@type='temporary']/t:note" />
        <xsl:text>, </xsl:text>
        <xsl:value-of select="//t:teiHeader/t:fileDesc/t:sourceDesc/t:msDesc/t:msIdentifier/t:altIdentifier[@type='temporary']/t:idno[@type='invNo']" />
        <xsl:text>)</xsl:text>
      </xsl:if>
      <xsl:text>. </xsl:text>
    </xsl:if>

    <!-- literature -->
    <xsl:if test="//t:text/t:body/t:div[@type='bibliography' and @subtype='citations']/t:listBibl/t:bibl">
      <xsl:text>Lit.: </xsl:text>
      <xsl:for-each select="//t:text/t:body/t:div[@type='bibliography' and @subtype='citations']/t:listBibl/t:bibl">
        <xsl:call-template name="metadata_literature">
          <xsl:with-param name="biblio" select="."  />
        </xsl:call-template>
        <xsl:choose>
					<xsl:when test="not(position() = last())">
	          <xsl:text>; </xsl:text>
				  </xsl:when>
					<xsl:when test="not(ends-with(t:biblScope[@type='page']/@to, '.'))">
	          <xsl:text>. </xsl:text>
	        </xsl:when>
			  </xsl:choose>
      </xsl:for-each>
			
    </xsl:if>

    <xsl:text> – </xsl:text>

    <!-- modern findspot -->
    <text:span text:style-name="Sammelbuch-Verortung">
      <xsl:value-of select="//t:teiHeader/t:fileDesc/t:sourceDesc/t:msDesc/t:history/t:origin/t:p/t:placeName[@type='ancientFindspot']" />
    </text:span>
    <xsl:if test="//t:teiHeader/t:fileDesc/t:sourceDesc/t:msDesc/t:history/t:origin/t:p/t:placeName[@type='modernFindspot']">
      <xsl:text> (= </xsl:text>
      <xsl:value-of select="//t:teiHeader/t:fileDesc/t:sourceDesc/t:msDesc/t:history/t:origin/t:p/t:placeName[@type='modernFindspot']" />
      <xsl:text>)</xsl:text>
     </xsl:if>
    <xsl:text>. </xsl:text>

    <!-- date -->
    <xsl:variable name="date" select="//t:teiHeader/t:fileDesc/t:sourceDesc/t:msDesc/t:history/t:origin/t:origDate[@type='textDate']" />
    <xsl:value-of select="concat(upper-case(substring($date, 1, 1)), substring($date, 2))" />
    <xsl:if test="not(ends-with(//t:teiHeader/t:fileDesc/t:sourceDesc/t:msDesc/t:history/t:origin/t:origDate[@type='textDate'], '.'))">
      <xsl:text>.</xsl:text>
    </xsl:if>
    
    </text:p>

  </xsl:template>

  <xsl:template name="metadata_footer">
      <xsl:if test="string(//t:text/t:body/t:div[@type='bibliography' and @subtype='illustrations']/t:p) or
                    string(//t:text/t:body/t:div[@type='commentary' and @subtype='general']/t:p)">
        <text:p text:style-name="Sammelbuch-Fußstrich" />
      </xsl:if>
    	<xsl:if test="string(//t:text/t:body/t:div[@type='bibliography' and @subtype='illustrations']/t:p)
				and not(//t:text/t:body/t:div[@type='bibliography' and @subtype='illustrations']/t:p = 'keine')">
        <text:p text:style-name="Sammelbuch-Fuß">
          <xsl:text>Photo: </xsl:text>
          <xsl:for-each select="//t:text/t:body/t:div[@type='bibliography' and @subtype='illustrations']/t:p">
            <xsl:variable name="illu" select="normalize-space(.)" />
            <xsl:value-of select="$illu" />
            <xsl:choose>
              <xsl:when test="position() = last()">
                <xsl:if test="not(ends-with($illu, '.'))">
                  <xsl:text>.</xsl:text>
                </xsl:if>
              </xsl:when>
              <xsl:otherwise>
                <xsl:text>, </xsl:text>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:for-each>
        </text:p>
      </xsl:if>
			<xsl:if test="string(//t:text/t:body/t:div[@type='commentary' and @subtype='general']/t:p)">
	    	<text:p text:style-name="Sammelbuch-Fuß">
				  <xsl:value-of select="//t:text/t:body/t:div[@type='commentary' and @subtype='general']/t:p" />
				</text:p>
			</xsl:if>

  </xsl:template>

  <xsl:template name="metadata_default">
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
  
  <xsl:template name="metadata_pagination">
    <xsl:param name = "pagination" />
    <xsl:if test="$pagination/@from and string($pagination/@from)">
			<!-- pagination from -->
	    <xsl:text>S. </xsl:text>
	    <xsl:value-of select="$pagination/@from" />
	    <!-- pagination to -->
	    <xsl:if test="$pagination/@to and string($pagination/@to)">
	      <xsl:choose>
          <xsl:when test="$pagination/@to = 'ff.'">
	          <xsl:text> ff.</xsl:text>
	        </xsl:when>
          <xsl:when test="$pagination/@to = 'f.'">
            <xsl:text> f.</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>-</xsl:text>
            <xsl:value-of select="$pagination/@to" />
          </xsl:otherwise>
	      </xsl:choose>
	    </xsl:if>
	  </xsl:if>
  </xsl:template>
  
  <xsl:template name="metadata_edition">
    <xsl:param name="biblio" />

    <xsl:choose>
        <xsl:when test="string(bliblio/t:title[@level='m' and @type='main'])
                     or string($biblio/t:title[@level='m' and @type='short'])">
          <xsl:text>in: </xsl:text>
          <!-- monographic title -->
          <xsl:choose>
            <xsl:when test="string($biblio/t:title[@level='m' and @type='short'])">
              <xsl:value-of select="$biblio/t:title[@level='m' and @type='short']" />
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$biblio/t:title[@level='m' and @type='main']" />
            </xsl:otherwise>
          </xsl:choose>
          <!-- series title and number -->
          <xsl:choose>
            <xsl:when test="string($biblio/t:series/t:title[@level='s'and @type='main'])">
              <xsl:text> [</xsl:text>
              <xsl:value-of select="$biblio/t:series/t:title[@level='s'and @type='main']" />
              <xsl:if test="string($biblio/t:series/t:biblScope[@type='volume'])">
                <xsl:text> </xsl:text>
                <xsl:number value="$biblio/t:series/t:biblScope[@type='volume']" format="I" />
              </xsl:if>
              <xsl:text>], </xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>, </xsl:text>
            </xsl:otherwise>
          </xsl:choose>
          <!-- editors -->
          <xsl:if test="$biblio/t:editor">
            <xsl:text>hrsg. von </xsl:text>
            <xsl:for-each select="$biblio/t:editor">
              <text:span text:style-name="Sammelbuch-Herausgeber">
                <xsl:value-of select="." />
              </text:span>
              <xsl:choose>
                <xsl:when test="position() = last() - 1">
                  <xsl:text> und </xsl:text>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:text>, </xsl:text>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:for-each>
          </xsl:if>
          <!-- publication place -->
          <xsl:value-of select="$biblio/t:pubPlace" />
          <xsl:text> </xsl:text>
          <!-- publication date -->
          <xsl:value-of select="$biblio/t:date" />
          <xsl:text>, </xsl:text>
          <xsl:call-template name="metadata_pagination">
            <xsl:with-param name="pagination" select="$biblio/t:biblScope[@type='page']" />
          </xsl:call-template>
        </xsl:when>
        <xsl:when test="$biblio/t:series/t:title[@level='j' and @type='short']">
          <xsl:value-of select="$biblio/t:series/t:title[@level='j' and @type='short']" />
          <xsl:if test="string($biblio/t:series/t:biblScope[@type='issue'])">
            <xsl:text> </xsl:text>
            <xsl:value-of select="$biblio/t:series/t:biblScope[@type='issue']" />
          </xsl:if>
          <xsl:if test="string($biblio/t:date)">
            <xsl:text>, </xsl:text>
            <xsl:value-of select="$biblio/t:date" />
          </xsl:if>
          <xsl:if test="string($biblio/t:biblScope[@type='page'])">
            <xsl:text>, </xsl:text>
            <xsl:call-template name="metadata_pagination">
              <xsl:with-param name="pagination" select="$biblio/t:biblScope[@type='page']" />
            </xsl:call-template>
          </xsl:if>
        </xsl:when>
      </xsl:choose>
  </xsl:template>

  <xsl:template name="metadata_literature">
    <!-- author -->
    <xsl:for-each select="t:author">
      <text:span text:style-name="Sammelbuch-Herausgeber">
        <xsl:value-of select="." />
      </text:span>
      <xsl:choose>
        <xsl:when test="position() = last() - 1">
          <xsl:text> und </xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>, </xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>

    <!-- article title -->
    <xsl:if test="string(t:title[@level='a'][@type='main'])">
      <xsl:value-of select="t:title[@level='a'][@type='main']" />
      <xsl:text>, </xsl:text>
    </xsl:if>

    <!-- book, journal, short-->
    <xsl:choose>
      <xsl:when test="string(t:title[@level='m'][@type='main'])">
        <xsl:text>in: </xsl:text>
        <xsl:if test="t:editor">
          <xsl:for-each select="t:editor">
            <text:span text:style-name="Sammelbuch-Herausgeber">
              <xsl:value-of select="." />
            </text:span>
            <xsl:if test="not(position() = last())">
             <xsl:text> – </xsl:text>
            </xsl:if>
          </xsl:for-each>
          <xsl:text> (Hrsg.): </xsl:text>
        </xsl:if>
        <xsl:value-of select="t:title[@level='m'][@type='main']" />
        <xsl:text>, </xsl:text>
      </xsl:when>
      <xsl:when test="string(t:title[@level='m'][@type='short'])">
        <xsl:value-of select="t:title[@level='m'][@type='short']" />
        <xsl:text>, </xsl:text>
      </xsl:when>
      <xsl:when test="string(t:series/t:title[@level='j' and @type='short'])">
        <xsl:value-of select="t:series/t:title[@level='j' and @type='short']" />
          <xsl:if test="string(t:series/t:biblScope[@type='issue'])">
            <xsl:text> </xsl:text>
            <xsl:value-of select="t:series/t:biblScope[@type='issue']" />
          </xsl:if>
        <xsl:text>, </xsl:text>
      </xsl:when>
    </xsl:choose>

    <!-- date -->
    <xsl:if test="(t:date and string(t:date)) or (t:pubPlace and string(t:pubPlace))">
      <xsl:value-of select="t:pubPlace" />
      <xsl:text> </xsl:text>
      <xsl:value-of select="t:date" />
      <xsl:text>, </xsl:text>
    </xsl:if>

    <!-- pagination-->
    <xsl:if test="string(t:biblScope[@type='page']/@from)">
      <xsl:call-template name="metadata_pagination">
        <xsl:with-param name="pagination" select="t:biblScope[@type='page']" />
      </xsl:call-template>
    </xsl:if>

    <xsl:if test="t:biblScope[@type='page'] and string(t:biblScope[@type='page'])">
      <xsl:if test="not(contains(t:biblScope[@type='page'], 'passim'))">
        <xsl:text> (</xsl:text>
      </xsl:if>
      <xsl:value-of select="t:biblScope[@type='page']" />
      <xsl:if test="not(contains(t:biblScope[@type='page'], 'passim'))">
        <xsl:text>)</xsl:text>
      </xsl:if>
    </xsl:if>

  </xsl:template>

</xsl:stylesheet>
