<?xml version="1.0"?>
<!-- root.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:ora="http://www.oreilly.com">
  
  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Tests of the root() function:</xsl:text>

    <xsl:variable name="testTree" as="node()*">
      <report month="8" year="2006">
        <title>Chocolate bar sales</title>
        <brand>
          <name>Lindt</name>
          <units>27408</units>
        </brand>
      </report>
      <otherReport month="9" year="2006">
        <title>Chocolate bar sales</title>
        <brand>
          <name>Callebaut</name>
          <units>8203</units>
        </brand>
      </otherReport>
    </xsl:variable>

    <xsl:text>&#xA;&#xA;  1. root(//listitem[3]):</xsl:text>
    <xsl:text>&#xA;</xsl:text>
    <xsl:value-of 
      select="ora:doc-node-test(root(//listitem[3]))"/>

    <xsl:text>&#xA;&#xA;  2. root(subsequence($testTree, 1, 1)):</xsl:text>
    <xsl:text>&#xA;</xsl:text>
    <xsl:value-of 
      select="ora:doc-node-test(root(subsequence($testTree, 1, 1)))"/>

    <xsl:text>&#xA;&#xA;  3. root(subsequence($testTree, 2)):</xsl:text>
    <xsl:text>&#xA;</xsl:text>
    <xsl:value-of 
      select="ora:doc-node-test(root(subsequence($testTree, 2, 1)))"/>

    <xsl:text>&#xA;&#xA;  4. root():</xsl:text>
    <xsl:text>&#xA;</xsl:text>
    <xsl:value-of 
      select="ora:doc-node-test(root())"/>

  </xsl:template>

  <xsl:function name="ora:doc-node-test" as="xs:string">
    <xsl:param name="node" as="node()*"/>
    <xsl:choose>
      <xsl:when test="empty($node)">
        <xsl:value-of select="'       [empty sequence]'"/>
      </xsl:when>
      <xsl:when test="$node instance of document-node()">
        <xsl:value-of 
          select="concat('       This IS a document node.&#xA;',
                  '       root node''s name: &lt;',
                  node-name($node/*[1]),
                  '&gt;')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of 
          select="concat('       This IS NOT a document node.&#xA;',
                  '       root node''s name: &lt;',
                  node-name($node),
                  '&gt;')"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>
  
</xsl:stylesheet>
