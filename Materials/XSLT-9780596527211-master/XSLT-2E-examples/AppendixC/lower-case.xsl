<?xml version="1.0" encoding="UTF-8"?>
<!-- lower-case.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="xml" encoding="UTF-8" indent="yes"/>

  <xsl:template match="/">
    <testcase>
      <heading>Tests of the lower-case() function:</heading>
      <test>
        <label>lower-case('Lily') = </label>
        <result><xsl:value-of select="lower-case('Lily')"/></result>
      </test>
      <test>
        <label>lower-case('LILY') = </label>
        <result><xsl:value-of select="lower-case('LILY')"/></result>
      </test>
      <test>
        <label>lower-case('lily') = </label>
        <result><xsl:value-of select="lower-case('lily')"/></result>
      </test>
      <test>
        <label>lower-case('JALAPE&#xD1;O') = </label>
        <result><xsl:value-of select="lower-case('JALAPE&#xD1;O')"/></result>
      </test>
    </testcase>
  </xsl:template>

</xsl:stylesheet>
