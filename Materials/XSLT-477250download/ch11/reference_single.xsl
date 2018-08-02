
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

   <xsl:output method="html" encoding="UTF-8"
      doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
      doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"/>

 
   <xsl:include href="head.xsl"/>
   <xsl:include href="table.xsl"/>

   <xsl:include href="function.xsl"/>
   <xsl:include href="link.xsl"/>
   
   <!--   $map is used only to show start, next and previous links-->
   <xsl:param name="map" select="document('map_xsl.xml')"/>
   
   <xsl:param name="identifier" select="reference/@xml:id"/>
   <xsl:param name="scheme" select="reference/@scheme"/>
   <xsl:param name="resourcelist" select="document(concat('../reslist_',$scheme,'.xml'))"/>
   <xsl:param name="meta" select="$resourcelist//entry[@xml:id eq $identifier]"/>
   <xsl:param name="title" select="$meta/title"/>
   
   <xsl:param name="style">../reference.css</xsl:param>
  

   <xsl:template match="/">
      <html>
         <xsl:call-template name="head">
            <xsl:with-param name="title" select="$title"/>
            <xsl:with-param name="style" select="$style"/>
         </xsl:call-template>
         <body>
            <h1>
               <xsl:value-of select="$title"/>
            </h1>
            <xsl:apply-templates select="reference/body"/>

            <!-- remove comments to see start, previous and next links
               
               <xsl:call-template name="nav">
               <xsl:with-param name="source_id" select="$identifier"
                  tunnel="yes"/>
               <xsl:with-param name="default_scheme" select="$scheme"
               tunnel="yes"/>
               <xsl:with-param name="topicrefs" select="$map"/>
            </xsl:call-template>
            -->
            
         </body>
      </html>
   </xsl:template>

   <xsl:template match="purpose">
      <h2>Purpose</h2>
      <xsl:apply-templates select="p"/>
   </xsl:template>

   <xsl:template match="usage">
      <h2>Usage</h2>
      <xsl:apply-templates select="p"/>
   </xsl:template>

   <xsl:template match="contains | containedby | common">
      <xsl:call-template name="getlinks">
         <xsl:with-param name="source_id" select="$identifier" tunnel="yes"/>
         <xsl:with-param name="default_scheme" select="$scheme" tunnel="yes"/>
         <xsl:with-param name="label" select="@label"/>
         <xsl:with-param name="display" select="@display"/>
      </xsl:call-template>
   </xsl:template>
   
   <xsl:template match="related">
      <xsl:call-template name="getlinks">
         <xsl:with-param name="source_id" select="$identifier" tunnel="yes"/>
         <xsl:with-param name="default_scheme" select="$scheme" tunnel="yes"/>
         <xsl:with-param name="label" select="@label"/>
         <xsl:with-param name="display" select="@display"/>
      </xsl:call-template>
   </xsl:template>

   <xsl:template match="properties[@type='attribute']">
      <xsl:call-template name="attribute"/>
   </xsl:template>

   <xsl:template name="attribute">
      <h2>Attribute<xsl:if test="count(//property) gt 1">s</xsl:if>
      </h2>
      <table cellspacing="0">
         <tr>
            <th xsl:use-attribute-sets="th_first">Name</th>
            <th xsl:use-attribute-sets="col">Description</th>
            <th xsl:use-attribute-sets="col">Type</th>
            <th xsl:use-attribute-sets="col">Default</th>
            <th xsl:use-attribute-sets="col">Options</th>
            <th xsl:use-attribute-sets="col">Use</th>
         </tr>
         <xsl:for-each select="//property">
            <xsl:sort select="name"/>
            <tr>
               <th xsl:use-attribute-sets="td_first">
                  <xsl:value-of select="name"/>
               </th>
               <td xsl:use-attribute-sets="row">
                  <xsl:apply-templates select="description"/>
               </td>
               <td xsl:use-attribute-sets="row">
                  <xsl:apply-templates select="type"/>
               </td>
               <td xsl:use-attribute-sets="row">
                  <xsl:value-of select="default"/>&#160;</td>
               <td xsl:use-attribute-sets="row">
                  <xsl:value-of select="values"/>&#160;</td>
               <td xsl:use-attribute-sets="row">
                  <xsl:value-of select="required/@state"/>&#160;</td>

            </tr>
         </xsl:for-each>
      </table>
   </xsl:template>

   <xsl:template match="p">
      <p>
         <xsl:apply-templates/>
      </p>
   </xsl:template>

   <xsl:template match="attr | element | code">
      <code>
         <xsl:attribute name="class">
            <xsl:value-of select="name()"/>
         </xsl:attribute>
         <xsl:value-of select="."/>
      </code>
   </xsl:template>

   <xsl:template match="examples">
      <xsl:if test="codeblock">
         <h2>Example<xsl:if test="count(codeblock) gt 1">s</xsl:if>
         </h2>
         <xsl:apply-templates/>
      </xsl:if>
   </xsl:template>

   <xsl:template match="codeblock">
      <pre class="code">
         <xsl:copy-of select="."/>
      </pre>
   </xsl:template>

</xsl:stylesheet>
