<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xd="http://www.pnp-software.com/XSLTdoc" version="2.0">
   <xd:doc type="stylesheet">
      <xd:short>Specifies the processing of parameters passed to the named
         template <code>head</code>.</xd:short>
   </xd:doc>
   <xd:doc>
      <xd:param name="title">The value of the <code>title</code>
         element.</xd:param>
      <xd:param name="style">The value of the <code>href</code> attribute on the
            <code>link</code> element.</xd:param>
   </xd:doc>
   <xsl:template name="head">
      <xsl:param name="title"/>
      <xsl:param name="style"/>
      <head>
         <meta http-equiv="Content-Type" content="text/xml;charset=UTF-8"/>
         <title>
            <xsl:value-of select="$title"/>
         </title>
         <link rel="stylesheet" type="text/css">
            <xsl:attribute name="href">
               <xsl:value-of select="$style"/>
            </xsl:attribute>
            <!--<xsl:message>Head section link processed</xsl:message>-->
         </link>
      </head>
   </xsl:template>
</xsl:stylesheet>
