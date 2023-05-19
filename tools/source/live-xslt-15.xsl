<xsl:stylesheet version="2.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text" encoding="UTF-8" />

    <xsl:key name="lang" match="language" use="@ident"></xsl:key>

    <xsl:template match="/">
            <xsl:if test="key('lang','la')">
                <xsl:value-of 
                   select="key('lang','la')"
                />
            </xsl:if>
    </xsl:template>

</xsl:stylesheet>
