<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"
   version="2.0">


   <xsl:include href="head.xsl"/>
   <xsl:include href="table.xsl"/>
   <xsl:include href="link.xsl"/>
   <xsl:include href="term.xsl"/>
   <xsl:include href="function.xsl"/>


   <xsl:param name="identifier" select="reference/@xml:id"/>

   <xsl:param name="meta" select="$resourcelist//entry[@xml:id=$identifier]"/>
   <xsl:param name="title" select="$meta/title"/>
   <xsl:param name="copyright">&#x00a9; Copyright statement.</xsl:param>
   
   <xsl:param name="labels" select="document('labels.xml')"/>


   <xsl:template match="purpose">
      <h2>Purpose</h2>
      <xsl:apply-templates select="p"/>
   </xsl:template>

   <xsl:template match="usage">
      <h2>Usage</h2>
      <xsl:apply-templates select="p"/>
   </xsl:template>

   <xsl:template match="syntax">
      <h2>Signature</h2>
      <p>
         <span class="code">
            <xsl:value-of select="//syntax"/>
         </span>
      </p>
   </xsl:template>

   <xsl:template match="contains | containedby | common">
      <xsl:param name="source_id" tunnel="yes"/>
      <xsl:param name="default_scheme" tunnel="yes"/>
      <xsl:call-template name="getlinks">
         <xsl:with-param name="label" select="@label"/>
         <xsl:with-param name="display" select="@display"/>
      </xsl:call-template>
   </xsl:template>

   <xsl:template match="related">
      <xsl:param name="identifier" tunnel="yes"/>
      <xsl:param name="scheme" tunnel="yes"/>
      <xsl:call-template name="getlinks">
         <xsl:with-param name="label" select="@label"/>
         <xsl:with-param name="display" select="@display"/>
      </xsl:call-template>
   </xsl:template>

   <xsl:template match="properties">
      <xsl:choose>
         <xsl:when test="@type='attribute'">
            <xsl:call-template name="attribute"/>
         </xsl:when>
         <xsl:when test="@type='parameter'">
            <xsl:call-template name="parameter"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:apply-templates/>
         </xsl:otherwise>
      </xsl:choose>
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
               <xsl:choose>
                  <xsl:when test="required/@state='required'">
                     <th xsl:use-attribute-sets="td_required">
                        <xsl:value-of select="name"/>
                     </th>
                  </xsl:when>
                  <xsl:when test="required/@state='deprecated'">
                     <th xsl:use-attribute-sets="td_deprecated">
                        <xsl:value-of select="name"/>
                     </th>
                  </xsl:when>
                  <xsl:otherwise>
                     <th xsl:use-attribute-sets="td_first">
                        <xsl:value-of select="name"/>
                     </th>
                  </xsl:otherwise>
               </xsl:choose>
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
   <xsl:template name="parameter">
      <h2>Parameter<xsl:if test="count(//property) gt 1">s</xsl:if>
      </h2>
      <table cellspacing="0">
         <tr>
            <th xsl:use-attribute-sets="th_first">Name</th>
            <th xsl:use-attribute-sets="col">Description</th>
            <th xsl:use-attribute-sets="col">Type</th>
            <th xsl:use-attribute-sets="col">Use</th>
         </tr>
         <xsl:for-each select="//property">
            <!-- don't sort -->
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

   <xsl:template match="reftable">
      <xsl:param name="default_scheme" tunnel="yes"/>
      <xsl:call-template name="maketable"/>
   </xsl:template>

   <xsl:template match="termtable">
      <xsl:call-template name="getterms">
         <xsl:with-param name="default_scheme" select="$scheme"/>
         <xsl:with-param name="label" select="@label"/>
      </xsl:call-template>
   </xsl:template>
</xsl:stylesheet>
