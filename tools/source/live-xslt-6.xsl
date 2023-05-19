<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text" encoding="UTF-8" />

    <xsl:template match="/">

      <xsl:value-of
       select="descendant::langUsage/language[@ident='it']/preceding-sibling::*[1]/text()"
      />

    </xsl:template>

</xsl:stylesheet>
