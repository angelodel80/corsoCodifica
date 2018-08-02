<?xml version="1.0"?>
<!-- fo-greeting.xsl -->
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format">

  <xsl:output method="xml"/>

  <xsl:template match="/">
    <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
      <fo:layout-master-set>
        <fo:simple-page-master master-name="standard"
          margin-right="75pt" margin-left="75pt" 
          page-height="11in" page-width="8.5in"
          margin-bottom="25pt" margin-top="25pt">
          <fo:region-body margin-top="50pt" margin-bottom="50pt"/>
        </fo:simple-page-master>
      </fo:layout-master-set>
      
      <fo:page-sequence master-reference="standard">
        <fo:flow flow-name="xsl-region-body">
          <xsl:apply-templates select="greeting"/>
        </fo:flow>
      </fo:page-sequence>
    </fo:root>
  </xsl:template>

  <xsl:template match="greeting">
    <fo:block line-height="76pt" font-size="72pt" text-align="center">
      <xsl:value-of select="."/>
    </fo:block>
  </xsl:template>

</xsl:stylesheet>
