<?xml version="1.0"?>
<!-- comments.xsl -->
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:for-each select="cars/make">
      <xsl:text>&#xA;  Car: </xsl:text>
      <xsl:value-of select="."/>
      <xsl:text> - </xsl:text>
      <xsl:value-of 
        select="(: Most of our cars are from North America, 
                   so we look there first :)
                if (@geography = 'North America') then 
                  'Domestic car'

                (: Next, see if the car is from Europe :)
                else if (@geography = 'Europe') then 
                  'Import from Europe'

                (: Check for Asia :)
                else if (@geography = 'Asia') then 
                  &quot;It's from Asia&quot;

                (: If it's anything else, just say
                   'We don't know' :)
                else 
                   'We don''t know!'"/>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
