<?xml version="1.0" encoding="UTF-8"?>
<!-- upper-case.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="xml" encoding="UTF-8" indent="yes"/>

  <xsl:template match="/">
    <testcase>
      <heading>Tests of the upper-case() function:</heading>
      <test>
        <label>upper-case('Lily') = </label>
        <result><xsl:value-of select="upper-case('Lily')"/></result>
      </test>
      <test>
        <label>upper-case('LILY') = </label>
        <result><xsl:value-of select="upper-case('LILY')"/></result>
      </test>
      <test>
        <label>upper-case('lily') = </label>
        <result><xsl:value-of select="upper-case('lily')"/></result>
      </test>
      <test>
        <label>upper-case('jalape&#xF1;o') = </label>
        <result><xsl:value-of select="upper-case('jalape&#xF1;o')"/></result>
      </test>
    </testcase>
  </xsl:template>

</xsl:stylesheet>
