<?xml version="1.0" encoding="utf-8"?>
<!-- reluctant.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>Original string: 'Call me at 19195551212'&#xA;</xsl:text>
    <xsl:text>  replace($x, '([0-9]+)', '[$1]'):&#xA;    </xsl:text>
    <xsl:value-of 
      select="replace('Call me at 19195551212', 
              '([0-9]+)',
              '[$1]')"/>
    <xsl:text>&#xA;</xsl:text>
    <xsl:text>  replace($x, '(([0-9])+?)', '[$1]'):&#xA;    </xsl:text>
    <xsl:value-of 
      select="replace('Call me at 19195551212', 
              '(([0-9])+?)',
              '[$1]')"/>
    <xsl:text>&#xA;</xsl:text>
    <xsl:text>  replace($x, '(([0-9]){2,4}?)', '[$1]'):&#xA;    </xsl:text>
    <xsl:value-of 
      select="replace('Call me at 19195551212', 
              '(([0-9]){2,4}?)',
              '[$1]')"/>
    <xsl:text>&#xA;</xsl:text>
  </xsl:template>

</xsl:stylesheet>
