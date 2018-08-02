<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   
   xmlns:dc="http://purl.org/dc/elements/1.1/"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"  
   xpath-default-namespace="http://www.w3.org/2005/Atom">
    
   <xsl:output method="xml"/>
   <xsl:variable name="site">testurl</xsl:variable>
   <xsl:template match="/">
      <rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
         xmlns:dc="http://purl.org/dc/elements/1.1/">

         <channel>
            <xsl:variable name="feedurl" select="feed/link[@rel='self']/@href"/>
            <xsl:attribute name="rdf:about">
               <xsl:value-of select="$feedurl"/>
            </xsl:attribute>
            <title>
               <xsl:value-of select="feed/title"/>
            </title>

            <link>
               <xsl:value-of select="$feedurl"/>
            </link>

            <items>
               <rdf:Seq>
                  <xsl:for-each select="feed//entry">
                     <rdf:li>
                        <xsl:attribute name="rdf:resource">
                           <xsl:value-of select="id"/>
                        </xsl:attribute>
                     </rdf:li>
                  </xsl:for-each>
               </rdf:Seq>
            </items>

            <xsl:for-each select="//entry">
               <xsl:apply-templates select="."/>
            </xsl:for-each>
        
         </channel>

      </rdf:RDF>
   </xsl:template>
   <xsl:template match="entry">
      <item>         
         <xsl:attribute name="rdf:about">
            <xsl:value-of select="id"/>
         </xsl:attribute>
         <link>
            <xsl:value-of select="link/@href"/>
         </link>
         <dc:identifier>
            <xsl:value-of select="id"/>
         </dc:identifier>
         <dc:language>
            <xsl:value-of select="content/@xml:lang"/>
         </dc:language>
         <dc:title>
            <xsl:value-of select="title"/>
         </dc:title>
         <dc:date>
            <xsl:value-of select="updated"/>
         </dc:date>
         <dc:creator>
            <xsl:value-of select="author/name"/>
         </dc:creator>
         <dc:description>
            <xsl:value-of select="summary"/>
         </dc:description>
         <dc:format>
            <xsl:value-of select="content/@type"/>
         </dc:format>

         <xsl:for-each select="category">
            <dc:subject>
               <xsl:value-of select="./@label"/>
            </dc:subject>
         </xsl:for-each>

      </item>
   </xsl:template>

</xsl:stylesheet>
