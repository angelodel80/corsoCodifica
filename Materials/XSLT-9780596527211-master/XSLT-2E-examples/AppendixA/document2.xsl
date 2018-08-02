<?xml version="1.0"?>
<!-- document2.xsl -->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:variable name="ill-formed" as="node()*">
    <xsl:document>
      <xsl:element name="title">
        <xsl:text>Mr.</xsl:text>
      </xsl:element>
      <xsl:element name="first-name">
        <xsl:text>Kent Lyle</xsl:text>
      </xsl:element>
      <xsl:element name="last-name">
        <xsl:text>Birdley</xsl:text>
      </xsl:element>
    </xsl:document>
  </xsl:variable>

  <xsl:template match="/">
    <xsl:text>&#xA;A document node that isn't well formed:</xsl:text>
    <xsl:text>&#xA;&#xA;  Is this a document node? </xsl:text>
    <xsl:value-of select="if ($ill-formed instance of document-node())
                          then 'Yes!'
                          else 'No!'"/>
    <xsl:text>&#xA;  Number of child elements: </xsl:text>
    <xsl:value-of select="count($ill-formed/*)"/>

    <xsl:result-document method="xml" href="ill-formed.xml">
      <xsl:copy-of select="$ill-formed"/>
    </xsl:result-document>
  </xsl:template>

</xsl:stylesheet>
