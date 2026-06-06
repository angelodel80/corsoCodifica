<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" 
	xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" 
	version="2.0">
	<!-- Contains named templates for default file structure (aka "metadata" aka "supporting data") -->  
	
	<!-- Specific named templates for HGV, InsLib, RIB, IOSPE, EDH, etc. are found in:
               htm-tpl-struct-hgv.xsl
               htm-tpl-struct-inslib.xsl
               htm-tpl-struct-rib.xsl
               htm-tpl-struct-iospe.xsl
               htm-tpl-struct-edh.xsl
               etc.
  -->
	
	
	<xsl:template name="eagle-structure">
		<xsl:param name="parm-leiden-style" tunnel="yes" required="no"></xsl:param>
		<xsl:param name="parm-line-inc" tunnel="yes" required="no" as="xs:double"></xsl:param>
		<html>
			<head>
				<title>
					<xsl:choose>
						<xsl:when test="($parm-leiden-style = 'ddbdp' or $parm-leiden-style = 'sammelbuch')">
							<xsl:choose>
								<xsl:when test="//t:sourceDesc//t:bibl/text()">
									<xsl:value-of select="//t:sourceDesc//t:bibl"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="//t:idno[@type='filename']"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:when test="//t:titleStmt/t:title/text()">
							<xsl:if test="//t:idno[@type='filename']/text()">
								<xsl:value-of select="//t:idno[@type='filename']"/>
								<xsl:text>. </xsl:text>
							</xsl:if>
							<xsl:value-of select="//t:titleStmt/t:title"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>EpiDoc example output, default style</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</title>
				<meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
				<!-- Found in htm-tpl-cssandscripts.xsl -->
				<xsl:call-template name="css-script"/>
			</head>
			<body>
				<xsl:call-template name="eagle-body-structure"/>
			</body>
			<eagleinlinetext>
				<xsl:call-template name="eagle-body-structure2"/>
			</eagleinlinetext>
		</html>
	</xsl:template>
	
	<xsl:template name="eagle-body-structure">
	
		<!-- Main text output -->
		<xsl:variable name="maintxt">
			<xsl:apply-templates/>
		</xsl:variable>
		<!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
		<xsl:variable name="maintxt2">
			<xsl:apply-templates select="$maintxt" mode="sqbrackets"/>
		</xsl:variable>
		<xsl:apply-templates select="$maintxt2" mode="sqbrackets"/>
		
		<!-- Found in htm-tpl-license.xsl -->
		<xsl:call-template name="license"/>
	</xsl:template>

	
	
	<xsl:template name="eagle-body-structure2">
		<xsl:variable name="withspaces"><xsl:apply-templates select=".//t:div/t:ab">
			<xsl:with-param name="parm-leiden-style"
				tunnel="yes">eagletxt</xsl:with-param>
		</xsl:apply-templates></xsl:variable>
		<xsl:variable name="withspaces2"><xsl:apply-templates select="$withspaces" mode="sqbrackets"/></xsl:variable>
		<xsl:value-of select="normalize-space($withspaces2)"/>
	</xsl:template>
	


	
</xsl:stylesheet>
