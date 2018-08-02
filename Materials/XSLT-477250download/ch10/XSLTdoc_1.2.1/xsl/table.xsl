<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xd="http://www.pnp-software.com/XSLTdoc" version="2.0">
   <xd:doc type="stylesheet">
      <xd:short>Specifies the attribute sets used in tables.</xd:short>
   </xd:doc>
   <xd:doc>
      <xd:short>Specifies the <code>scope</code> attribute for columns.</xd:short>
   </xd:doc>
   <xsl:attribute-set name="col">
      <xsl:attribute name="scope">col</xsl:attribute>
   </xsl:attribute-set>
   <xd:doc>
      <xd:short>Specifies the <code>scope</code> attribute for rows.</xd:short>
   </xd:doc>
   <xsl:attribute-set name="row">
      <xsl:attribute name="scope">row</xsl:attribute>
   </xsl:attribute-set>
   <xd:doc>
      <xd:short>Specifies the <code>class</code> attribute for first column header cell.</xd:short>
   </xd:doc>
   <xsl:attribute-set name="th_first" use-attribute-sets="col">
      <xsl:attribute name="class">firsthdr</xsl:attribute>
   </xsl:attribute-set>
   <xd:doc>
      <xd:short>Specifies the <code>class</code> attribute for first column cells.</xd:short>
   </xd:doc>
   <xsl:attribute-set name="td_first" use-attribute-sets="row">
      <xsl:attribute name="class">firstcell</xsl:attribute>
   </xsl:attribute-set>

</xsl:stylesheet>
