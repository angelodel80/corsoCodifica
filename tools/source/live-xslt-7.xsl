<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text" encoding="UTF-8" />

    <xsl:template match="/">
    
      <xsl:value-of 
            select="concat(
                            name(TEI/descendant::langUsage/language[1]),' ',
                            count(TEI/descendant::langUsage/language),' ',
                            //w[contains(.,'fili')]/@lemma,' ',
                            upper-case(
                                substring(TEI/descendant::langUsage/language[@ident eq 'it'],0,4)
                                ), ' '
                            )
            " />

    </xsl:template>

</xsl:stylesheet>
