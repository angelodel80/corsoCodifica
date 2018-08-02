<?xml version="1.0"?>
<!-- translate.xsl -->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>&#xA;Tests of the translate() function:</xsl:text>

    <xsl:text>&#xA;&#xA;  Convert a string to uppercase:</xsl:text>
    <xsl:text>&#xA;    translate('Lily', </xsl:text>
    <xsl:text>'abcdefghijklmnopqrstuvwxyz', </xsl:text>
    <xsl:text>&#xA;              'ABCDEFGHIJKLMNOPQRSTUVWXYZ')=</xsl:text>
    <xsl:value-of 
      select="translate('Lily', 'abcdefghijklmnopqrstuvwxyz', 
                        'ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
    <xsl:text>&#xA;&#xA;  Convert a string to lowercase:</xsl:text>
    <xsl:text>&#xA;    translate('Lily', </xsl:text>
    <xsl:text>'ABCDEFGHIJKLMNOPQRSTUVWXYZ', </xsl:text>
    <xsl:text>&#xA;              'abcdefghijklmnopqrstuvwxyz')=</xsl:text>
    <xsl:value-of 
      select="translate('Lily', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 
                        'abcdefghijklmnopqrstuvwxyz')"/>
    <xsl:text>&#xA;&#xA;  Remove parentheses, spaces, and dashes </xsl:text>
    <xsl:text>from a U.S. phone number:</xsl:text>
    <xsl:text>&#xA;    translate('(555) 555-1212', '() -', '')=</xsl:text>
    <xsl:value-of select="translate('(555) 555-1212', '() -', '')"/>
    <xsl:text>&#xA;&#xA;  Replace all but the last four digits of a </xsl:text>
    <xsl:text>credit card number with Xs:&#xA;</xsl:text>
    <xsl:variable name="credit" select="'1234 5678 9101 1810'"/>
    <xsl:text>    $credit='</xsl:text>
    <xsl:value-of select="$credit"/>
    <xsl:text>'</xsl:text>
    <xsl:text>&#xA;    translate(substring($credit, 1, 15), </xsl:text>
    <xsl:text>'1234567890 ', 'XXXXXXXXXX-')</xsl:text>
    <xsl:text>&#xA;    substring($credit, 16)</xsl:text>
    <xsl:text>&#xA;&#xA;    The first part is </xsl:text>
    <xsl:value-of 
      select="translate(substring($credit, 1, 15), '1234567890 ', 
                        'XXXXXXXXXX-')"/>
    <xsl:text>&#xA;    The second part is </xsl:text>
    <xsl:value-of select="substring($credit, 16)"/>
    <xsl:text>&#xA;    Here's how they look together: &#xA;      </xsl:text>
    <xsl:value-of 
      select="translate(substring($credit, 1, 15), '1234567890 ', 
                        'XXXXXXXXXX-')"/>
    <xsl:value-of select="substring($credit, 16)"/>
  </xsl:template>

</xsl:stylesheet>
