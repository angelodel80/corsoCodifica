<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
   <xsl:attribute-set name="col">
      <xsl:attribute name="scope">col</xsl:attribute>
   </xsl:attribute-set>
   <xsl:attribute-set name="row">
      <xsl:attribute name="scope">row</xsl:attribute>
   </xsl:attribute-set>
   <xsl:attribute-set name="th_first" use-attribute-sets="col">
      <xsl:attribute name="class">firsthdr</xsl:attribute>
   </xsl:attribute-set>
   <xsl:attribute-set name="td_first" use-attribute-sets="row">
      <xsl:attribute name="class">firstcell</xsl:attribute>
   </xsl:attribute-set>
   <xsl:attribute-set name="td_required" use-attribute-sets="row">
      <xsl:attribute name="class">firstcellrequired</xsl:attribute>
   </xsl:attribute-set>
   <xsl:attribute-set name="td_deprecated" use-attribute-sets="row">
      <xsl:attribute name="class">firstcelldeprecated</xsl:attribute>
   </xsl:attribute-set>
</xsl:stylesheet>
