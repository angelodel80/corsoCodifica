<?xml version="1.0"?>
<!-- PhotoAlbum.xsl -->
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:dotnet="http://www.oreilly.com/xslt"
  extension-element-prefixes="dotnet">

  <xsl:output method="html"/>

  <xsl:template match="/">
    <html>
      <head>
        <title>Photo album extension function test</title>
      </head>
      <body style="font-family: sans-serif;">
        <xsl:choose>
          <xsl:when test="function-available('dotnet:getPhotoListing')">
            <h1>.Net photo album extension function test</h1>
            <xsl:copy-of 
			  		  select="dotnet:getPhotoListing(/photo-album/@directory, 
				  		  /photo-album/@imagesPerRow, 
					  	  /photo-album/@includeFilenames)"/>
          </xsl:when>
          <xsl:otherwise>
            <p>
              <i>[Sorry, the photo album function is not available.]</i>
            </p>
          </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
