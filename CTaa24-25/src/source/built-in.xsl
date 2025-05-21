<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text" />
    
    <xsl:template match="/">
        <xsl:apply-templates select="current()/descendant::text" />
    </xsl:template>
     
    <xsl:template match="div[@type='edition']|div[@type='translation']">
        <xsl:value-of select="normalize-space(.)" />
        <xsl:text>&#10;</xsl:text>
        <xsl:value-of 
                    select="some $e in ('io','tu','noi') satisfies (string-length($e) lt 3)"
        />
    </xsl:template>
    <xsl:template match="div" />
</xsl:stylesheet>

<!-- 
    - stylesheet ver 1  
    - xsl:output method text
    - template /
    - value-of //titleStmt/title
    - strip space
    - xml:space preserve
    - xpath
        - count(.//div[@type='edition']/descendant::persName[@type='emperor'])
        - <xsl:value-of select="count(.//div[@type='edition']/descendant::persName[@type='emperor'])" />
    - xpath functions
        - funzioni base matematiche
            - sum, count
        - funzioni base stringhe 
            - substring
            - name, contains, string-length, normalize-space
            <xsl:value-of select="//w[contains(.,'fili')]/@lemma" />
    - esempio sequenza con xslt2 e xpath2
        - <xsl:value-of select="(1 to 5)" />
            - sum, avg, min, max
            - upper-case, lower-case, translate, tokenize, replace, match
        - for-each-group
        - quantifies
            - every in stisfies
                -  <xsl:value-of 
                    select="every $e in ('io','tu','noi') satisfies (string-length($e) lt 3)"
        />
            - some in satisfies
                -  <xsl:value-of 
                    select="some $e in ('io','tu','noi') satisfies (string-length($e) gt 3)"
        />

    - esempi sintassi più complessa
        - <xsl:value-of select="//*[contains(.,'fili')]!name(.)" />
            - sintassi =>
        - <xsl:value-of select="reverse(1 to 5)" />
        - analyze-string
            - 
             <xsl:for-each select="('ciao, casa!', 'vado a casa.')">
            <xsl:analyze-string select="." regex="(c.+)[,.]">
                <xsl:matching-substring>
                    <xsl:value-of select="translate(.,',.','##')" /><xsl:text> : </xsl:text>
                    <xsl:value-of select="regex-group(1)" /><xsl:text>&#10;</xsl:text>
                </xsl:matching-substring>
            </xsl:analyze-string>
        </xsl:for-each>
        



<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="2.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:strip-space elements="w expan abbr ex" />
    
    <xsl:output method="text" encoding="UTF-8" />
    
    <xsl:template match="/">
        <xsl:value-of select="reverse(1 to 5)" />
        
        <xsl:value-of 
                    select="some $e in ('io','tu','noi') satisfies (string-length($e) gt 2)"
        />
        <xsl:for-each select="('ciao, casa!', 'vado a casa.')">
            <xsl:analyze-string select="." regex="(c.+)[,.]">
                <xsl:matching-substring>
                    <xsl:value-of select="translate(.,',.','##')" /><xsl:text> : </xsl:text>
                    <xsl:value-of select="regex-group(1)" /><xsl:text>&#10;</xsl:text>
                </xsl:matching-substring>
            </xsl:analyze-string>
        </xsl:for-each>
        
    </xsl:template>
     
</xsl:stylesheet>

<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <xsl:strip-space elements="*" />

    <xsl:template match="/">
        <xsl:value-of select="concat('&#10;','title : ', normalize-space(descendant::titleStmt/title=>string()))" />
        <xsl:apply-templates select="//text//div" />
    </xsl:template>

    <xsl:template match="div">
        <xsl:text>&#10;</xsl:text>
        <xsl:value-of select="name(.)=>concat(' : ',@type)" />
        <xsl:text>&#10;</xsl:text>
        <xsl:apply-templates select="head" />
    </xsl:template>

    <xsl:template match="head">
        <xsl:value-of select="name(.)=>concat(' : ', .,'&#10;')" />
        <xsl:apply-templates select="following-sibling::*" />
    </xsl:template>

    <xsl:template match="lb">
        <xsl:value-of select="concat('&#10;', 'riga ' , current()/@n, ' : ')" />
    </xsl:template>

</xsl:stylesheet>

 descendant::langUsage/language[@ident='it']/preceding-sibling::*[1]/text() 
    

<xsl:value-of select="name(id('irt1952'))" />

-->
