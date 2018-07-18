<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
  <html>
    <head>
      <title>TV Guide</title>
      <link rel="stylesheet" href="TVGuide.css" />
      <script type="text/javascript">
        function toggle(element) {
          if (element.style.display == 'none') {
            element.style.display = 'block';
          } else {
            element.style.display = 'none';
          }
        }
      </script>
    </head>

    <body>
      <h1>TV Guide</h1>
      <xsl:for-each select="/TVGuide/Channel">
        <h2 class="channel"><xsl:value-of select="Name" /></h2>
        <xsl:for-each select="Program">
          <div>
            <p>
              <span class="date"><xsl:value-of select="Start" /></span><br />
              <span class="title"><xsl:value-of select="Series" /></span><br />
              <xsl:value-of select="Description" />
              <span onclick="toggle({Series}Cast);">[Cast]</span>
            </p>
            <div id="{Series}Cast" style="display: none;">
              <ul class="castlist">
                <xsl:for-each select="CastList/CastMember">
                  <li>
                    <span class="character">
                      <xsl:value-of select="Character/Name" />
                    </span>
                    <span class="actor">
                      <xsl:value-of select="Actor/Name" />
                    </span>
                  </li>
                </xsl:for-each>
              </ul>
            </div>
          </div>
        </xsl:for-each>
      </xsl:for-each>
    </body>
  </html>
</xsl:template>

</xsl:stylesheet>