<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xd="http://www.pnp-software.com/XSLTdoc" xmlns:util="http://www.pnp-software.com/util"
  xmlns="http://www.w3.org/1999/xhtml" xmlns:xs="http://www.w3.org/2001/XMLSchema"
  exclude-result-prefixes="#all" version="2.0">
  <xd:doc type="stylesheet">
    Stylesheet to for the inline tag: xd:xml.
    <xd:author>ibirrer</xd:author>
    <xd:cvsId>$Id: xml.xsl 42 2009-01-16 15:02:32Z ibirrer $
    </xd:cvsId>
    <xd:copyright>2009, P&amp;P Software GmbH</xd:copyright>
  </xd:doc>
               
  <xd:doc>Formats as XML markup.</xd:doc>
  <xsl:template match="xd:xml" mode="XdocTags">
    <div class="source">
      <pre><xsl:copy-of select="util:xmlToHtml(node())"/></pre>
    </div>
  </xsl:template>
  <xd:doc>Formats a linked XML file as XML markup. Contributed by Harald Schmitt.</xd:doc>
  <xsl:template match="xd:xml[@href]" mode="XdocTags">
    <xsl:variable name="href-uri" as="xs:anyURI" select="resolve-uri(@href, base-uri(.))"/>
    <xsl:message select="$href-uri"/>
    <xsl:if test="doc-available($href-uri)">
      <div class="source">
        <pre><xsl:copy-of select="util:xmlToHtml(doc($href-uri)/*[1])"/></pre>
      </div>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>