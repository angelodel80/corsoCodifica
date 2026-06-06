<!-- $Id$ --><xsl:stylesheet xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" version="2.0">
  <!-- Called from teisupplied.xsl -->

    <xsl:template name="supplied-parallel">
        <fo:inline text-decoration="underline">
            <xsl:apply-templates/>
        </fo:inline>
    </xsl:template>
    
    <xsl:template name="supplied-previouseditor">
        <fo:inline text-decoration="underline">
            <xsl:apply-templates/>
        </fo:inline>
    </xsl:template>

    <xsl:template name="supplied-subaudible">
        <xsl:text>(</xsl:text><em><xsl:text>scil.</xsl:text></em><xsl:text> </xsl:text>
        <xsl:apply-templates/>
        <xsl:call-template name="cert-low"/>
        <xsl:text>)</xsl:text>
    </xsl:template>

</xsl:stylesheet>