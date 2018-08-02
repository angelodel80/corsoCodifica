<?xml version="1.0"?>
<!-- error2.xsl -->
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Test #2 of the error() function:</xsl:text>

    <xsl:value-of 
      select="error(QName('http://www.w3.org/2005/xqt-errors', 
              'err:FORX0004'))"/>
  </xsl:template>

</xsl:stylesheet>
