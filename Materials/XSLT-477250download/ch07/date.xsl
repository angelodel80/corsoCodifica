<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
   <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
   <xsl:variable name="date"
      select="format-date(current-date(),'[Y]-[M01]-[D01]')"/>
   <xsl:variable name="date_simple"
      select="format-date(current-date(),'[Y][M01][D01]')"/>
   <xsl:variable name="time" select="format-time(current-time(),'[H]:[m]:[s]Z')"/>
   <xsl:variable name="date_time"
      select="format-dateTime(current-dateTime(),'[Y]-[M01]-[D01]T[H]:[m]:[s]Z')"/>
   <xsl:variable name="date_am"
      select="format-dateTime(current-dateTime(),'[Y]-[M01]-[D01]T[H]:[m]:[s][ZN]','en','AN','GB')"/>

   <xsl:template match="/">
      <examples>
         <p>
            <xsl:value-of select="$date"/>
         </p>
         <p>
            <xsl:value-of select="$date_simple"/>
         </p>
         <p>
            <xsl:value-of select="$date_time"/>
         </p>
         <p>
            <xsl:value-of
               select="format-date(current-date(),'[Y]-[M01]-[D01]','es','AN','ES')"/>
         </p>
      </examples>
   </xsl:template>

</xsl:stylesheet>
