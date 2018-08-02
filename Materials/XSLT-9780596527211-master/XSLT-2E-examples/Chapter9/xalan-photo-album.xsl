<?xml version="1.0"?>
<!-- xalan-photo-album.xsl -->
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xpa="xalan://com.oreilly.xslt.xalan.XalanPhotoAlbumExtension"
  extension-element-prefixes="xpa">
  
  <xsl:output method="html"/>

  <xsl:template match="photo-album">
    <html>
      <head>
        <title>Photo album extension element test</title>
      </head>
      <body style="font-family: sans-serif;">
        <xsl:choose>
          <xsl:when test="element-available('xpa:XalanPhotoAlbum')">
            <h1>Xalan photo album extension element test</h1>
            <xpa:XalanPhotoAlbum/>
          </xsl:when>
          <xsl:otherwise>
            <p><i>[Sorry, the photo album function is not available.]</i></p>
          </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
