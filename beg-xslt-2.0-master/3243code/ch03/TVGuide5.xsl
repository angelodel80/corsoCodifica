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
      <xsl:apply-templates select="/TVGuide/Channel" />
    </body>
  </html>
</xsl:template>

<xsl:template match="Channel">
  <h2 class="channel"><xsl:value-of select="Name" /></h2>
  <xsl:apply-templates select="Program" />
</xsl:template>

<xsl:template match="Program">
  <div>
    <p>
      <span class="date"><xsl:value-of select="Start" /></span><br />
      <span class="title"><xsl:value-of select="Series" /></span><br />
      <xsl:value-of select="Description" />
      <span onclick="toggle({Series}Cast);">[Cast]</span>
    </p>
    <div id="{Series}Cast" style="display: none;">
      <ul class="castlist">
        <xsl:apply-templates select="CastList/CastMember" />
      </ul>
    </div>
  </div>
</xsl:template>

<xsl:template match="CastMember">
  <li>
    <span class="character"><xsl:value-of select="Character" /></span>
    <span class="actor"><xsl:value-of select="Actor" /></span>
  </li>
</xsl:template>

</xsl:stylesheet>