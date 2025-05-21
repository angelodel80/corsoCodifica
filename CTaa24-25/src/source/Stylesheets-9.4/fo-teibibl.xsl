<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:f="http://example.com/ns/functions" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:html="http://www.w3.org/1999/html" exclude-result-prefixes="t f" version="2.0">
	<!--

Pietro notes on 14/8/2015 work on this template, from mail to Gabriel.

- I have converted the TEI bibliography of IRT and IGCyr to ZoteroRDF 
(https://github.com/EAGLE-BPN/BiblioTEI2ZoteroRDF) in this passage I have tried to 
distinguish books, bookparts, articles and conference proceedings.

- I have uploaded these to the zotero eagle open group bibliography 
(https://www.zotero.org/groups/eagleepigraphicbibliography)

- I have created a parametrized template in my local epidoc xslts which looks at the json 
and TEI output of the Zotero api basing the call on the content of ptr/@target in each 
bibl. It needs both because the key to build the link is in the json but the TEI xml is 
much more accessible for the other data. I tried also to grab the html div exposed in the 
json, which would have been the easiest thing to do, but I can only get it escaped and 
thus is not usable.
** If set on 'zotero' it prints surname, name, title and year with a link to the zotero 
item in the eagle group bibliography. It assumes bibl only contains ptr and citedRange.
** If set on 'localTEI' it looks at a local bibliography (no zotero) and compares the 
@target to the xml:id to take the results and print something (in the sample a lot, but 
I'd expect more commonly Author-Year references(.
** I have also created sample values for irt and igcyr which are modification of the 
zotero option but deal with some of the project specific ways of encoding the 
bibliography. All examples only cater for book and article.



-->

	<!--
		
		Pietro Notes on 10.10.2016
		
		this should be modified based on parameters to
		
		* decide wheather to use zotero or a local version of the bibliography in TEI
	
		* assuming that the user has entered a unique tag name as value of ptr/@target, decide group or user in zotero to look up based on parameter value entered at transformation time
	
		* output style based on Zotero Style Repository stored in a parameter value entered at transformation time
		
		
	
	-->

	<xsl:template match="t:bibl" priority="1">
		<xsl:param name="parm-bib" tunnel="yes" required="no"/>
		<xsl:param name="parm-bibloc" tunnel="yes" required="no"/>
		<xsl:param name="parm-zoteroUorG" tunnel="yes" required="no"/>
		<xsl:param name="parm-zoteroKey" tunnel="yes" required="no"/>
		<xsl:param name="parm-zoteroNS" tunnel="yes" required="no"/>
		<xsl:param name="parm-zoteroStyle" tunnel="yes" required="no"/>


		<xsl:choose>
			<!-- default general zotero behaviour prints 
				author surname and name, title in italics, date and links to the zotero item page on the zotero bibliography. 
				assumes the inscription source has no free text in bibl, 
				!!!!!!!only a <ptr target='key'/> and a <citedRange>pp. 45-65</citedRange>!!!!!!!
			it also assumes that the content of ptr/@target is a unique tag used in the zotero bibliography as the ids assigned by Zotero are not
			reliable enough for this purpose according to Zotero forums.
			
			if there is no ptr/@target, this will try anyway and take a lot of time.
			-->

			<xsl:when test="$parm-bib = 'none'">
				<xsl:apply-templates/>
			</xsl:when>

			<xsl:when test="$parm-bib = 'zotero'">
				<xsl:choose>
					<!--					check if there is a ptr at all
					
					WARNING. if the pointer is not there, the transformation will simply stop and return a premature end of file message e.g. it cannot find what it is looking for via the zotero api
					-->
					<xsl:when test=".[t:ptr]">

						<!--						check if a namespace is provided for tags/xml:ids and use it as part of the tag for zotero-->
						<xsl:variable name="biblentry" select="         if ($parm-zoteroNS)         then          concat($parm-zoteroNS, ./t:ptr/@target)         else          ./t:ptr/@target"/>

						<xsl:variable name="zoteroapitei">

							<xsl:value-of select="concat('https://api.zotero.org/',$parm-zoteroUorG,'/',$parm-zoteroKey,'/items?tag=', $biblentry, '&amp;format=tei')"/>
							<!-- to go to the json with the escaped html included  use &format=json&include=bib,data and the code below: the result is anyway escaped... -->

						</xsl:variable>

						<xsl:variable name="zoteroapijson">
							<xsl:value-of select="concat('https://api.zotero.org/',$parm-zoteroUorG,'/',$parm-zoteroKey,'/items?tag=', $biblentry, '&amp;format=json&amp;style=',$parm-zoteroStyle,'&amp;include=citation')"/>
						</xsl:variable>
			
						
						<xsl:variable name="unparsedtext" select="unparsed-text($zoteroapijson)"/>
						<xsl:variable name="zoteroitemKEY">

							<xsl:analyze-string select="$unparsedtext" regex="(\[\s+\{{\s+&#34;key&#34;:\s&#34;)(.+)&#34;">
								<xsl:matching-substring>
									<xsl:value-of select="regex-group(2)"/>
								</xsl:matching-substring>
							</xsl:analyze-string>

						</xsl:variable>

						<xsl:choose>
							<!--this will print a citation according to the selected style with a link around it pointing to the resource DOI, url or zotero item view-->
							<xsl:when test="not(ancestor::t:div[@type = 'bibliography'])">
								<xsl:variable name="pointerurl">
									<xsl:choose>
										<xsl:when test="document($zoteroapitei)//t:idno[@type = 'DOI']">
											<xsl:value-of select="document($zoteroapitei)//t:idno[@type = 'DOI']"/>
										</xsl:when>
										<xsl:when test="document($zoteroapitei)//t:idno[@type = 'url']">
											<xsl:value-of select="document($zoteroapitei)//t:idno[@type = 'url']"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="document($zoteroapitei)//t:biblStruct/@corresp"/>
										</xsl:otherwise>
									</xsl:choose>

								</xsl:variable>

								<fo:basic-link external-destination="{$pointerurl}">

									<xsl:variable name="citation">

										<xsl:analyze-string select="$unparsedtext" regex="(\s+&#34;citation&#34;:\s&#34;&lt;span&gt;)(.+)(&lt;/span&gt;&#34;)">
											<xsl:matching-substring>
												<xsl:value-of select="regex-group(2)"/>
											</xsl:matching-substring>
										</xsl:analyze-string>
									</xsl:variable>
									<xsl:value-of select="$citation"/>
									<xsl:if test="t:citedRange">
										<xsl:text>, </xsl:text>
										<xsl:value-of select="t:citedRange"/>
									</xsl:if>
								</fo:basic-link>
							</xsl:when>
							<!--	if it is in the bibliography print styled reference-->
							<xsl:otherwise>
								<!--	print out using Zotoro parameter format with value bib and the selected style-->
								<xsl:copy-of select="document(concat('https://api.zotero.org/',$parm-zoteroUorG,'/',$parm-zoteroKey,'/items?tag=', $biblentry, '&amp;format=bib&amp;style=',$parm-zoteroStyle))/div"/>

							</xsl:otherwise>
						</xsl:choose>

					</xsl:when>

					<!-- if there is no ptr, print simply what is inside bibl and a warning message-->
					<xsl:otherwise>
						<xsl:value-of select="."/>
						<xsl:message>There is no ptr with a @target in the bibl element <xsl:copy-of select="."/>. A target equal to a tag in your zotero bibliography is
							necessary.</xsl:message>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>


			<!--uses the local TEI bibliography at the path specified in parameter parm-bibloc -->
			<xsl:when test="$parm-bib = 'localTEI'">

				<xsl:variable name="biblentry" select="./t:ptr/@target"/>
				<xsl:variable name="biblentryID" select="substring-after(./t:ptr/@target, '#')"/>
				<!--					parameter localbibl should contain the path to the bibliography relative to this xslt -->
				<xsl:variable name="textref" select="document(string($parm-bibloc))//t:bibl[@xml:id = $biblentryID]"/>
				<xsl:for-each select="$biblentry">
					<xsl:choose>
						<!--this will print a citation according to the selected style with a link around it pointing to the resource DOI, url or zotero item view-->
						<xsl:when test="not(ancestor::t:div[@type = 'bibliography'])">

							<!-- basic	render for citations-->
							<xsl:choose>
								<xsl:when test="$textref/@xml:id = $biblentryID">
									<xsl:choose>
										<xsl:when test="$textref//t:author">
											<xsl:value-of select="$textref//t:author[1]"/>
											<xsl:if test="$textref//t:author[2]">
												<xsl:text>-</xsl:text>
												<xsl:value-of select="$textref//t:author[2]"/>
											</xsl:if>
											<xsl:text>, </xsl:text>
										</xsl:when>
										<xsl:when test="$textref//t:editor">
											<xsl:value-of select="$textref//t:editor[1]"/>
											<xsl:if test="$textref//t:editor[2]">
												<xsl:text>-</xsl:text>
												<xsl:value-of select="$textref//t:editor[2]"/>
											</xsl:if>
										</xsl:when>
									</xsl:choose>
									<xsl:text> (</xsl:text>
									<xsl:value-of select="$textref//t:date"/>
									<xsl:text>), </xsl:text>
									<xsl:value-of select="$textref//t:biblScope"/>

								</xsl:when>
								<xsl:otherwise>
									<!--if this appears the id do not really correspond to each other, 
									ther might be a typo or a missing entry in the bibliography-->
									<xsl:message>
										<xsl:text> there is no entry in your bibliography file at </xsl:text>
										<xsl:value-of select="$parm-bibloc"/>
										<xsl:text> with the @xml:id</xsl:text>
										<xsl:value-of select="$biblentry"/>
										<xsl:text>!</xsl:text>
									</xsl:message>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:otherwise>

							<!--						rudimental render for each entry in bibliography-->
							<xsl:choose>
								<xsl:when test="$textref/@xml:id = $biblentryID">
									<xsl:value-of select="$textref"/>
									<!--assumes a sligthly "formatted" bibliography...-->

								</xsl:when>
								<xsl:otherwise>
									<!--if this appears the id do not really correspond to each other, 
									ther might be a typo or a missing entry in the bibliography-->
									<xsl:message>
										<xsl:text> there is no entry in your bibliography file at </xsl:text>
										<xsl:value-of select="$parm-bibloc"/>
										<xsl:text> for the entry </xsl:text>
										<xsl:value-of select="$biblentry"/>
										<xsl:text>!</xsl:text>
									</xsl:message>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>

				</xsl:for-each>

			</xsl:when>
			<xsl:otherwise>
				<!-- This applyes other templates and does not call the zotero api -->
				<xsl:apply-templates/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


</xsl:stylesheet>