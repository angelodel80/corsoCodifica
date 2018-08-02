<?xml version="1.0"?>
<!-- saxon-sql2.xsl -->
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:sql="java:/net.sf.saxon.sql.SQLElementFactory"
  xmlns:saxon="http://saxon.sf.net/"
  extension-element-prefixes="saxon sql">

  <xsl:output method="html"/>

  <xsl:template match="/">

    <!-- Create the JDBC connection -->
    <xsl:variable name="connection" 
      as="java:java.sql.Connection" 
      xmlns:java="http://saxon.sf.net/java-type">
      <sql:connect database="jdbc:db2:books"
        driver="COM.ibm.db2.jdbc.app.DB2Driver"
        user="Skippy"
        password="Zow3EAQW"/>
    </xsl:variable>

    <!-- Run the query -->
    <xsl:variable name="queryResults">
      <sql:query connection="$connection" table="compbks" 
        column="*" row-tag="tr" column-tag="td"/>
    </xsl:variable>

    <html>
      <head>
        <title>Computer books in our database</title>
      </head>
      <body style="font-family: sans-serif;">
        <h1>Computer books in our database</h1>
        <p>Here are the 
        <xsl:value-of select="count($queryResults/tr)"/>
        computer books we have in stock:</p>
        <table border="1" cellpadding="5">
          <tr>
            <th>ISBN</th>
            <th>Title</th>
            <th>Author</th>
            <th>Pages</th>
            <th>List price</th>
            <th>Publisher</th>
          </tr>
          <xsl:copy-of select="$queryResults"/>
        </table>
      </body>
    </html>

    <!-- Close the connection -->
    <sql:close connection="$connection"/>
  </xsl:template>

</xsl:stylesheet>
