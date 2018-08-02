<?xml version="1.0"?>
<!-- xalan-sql2.xsl -->
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:sql="org.apache.xalan.lib.sql.XConnection"
  extension-element-prefixes="sql">

  <xsl:output method="html"/>

  <xsl:template match="/">

    <!-- Create the JDBC connection -->
    <xsl:variable name="books" 
      select="sql:new('COM.ibm.db2.jdbc.app.DB2Driver', 
              'jdbc:db2:books', 'Skippy', 'Zow3EAQW')"/>

    <!-- Workaround for a bug in Xalan's SQL extension? -->
    <xsl:variable name="streaming"
      select="sql:disableStreamingMode($books)"/> 

    <!-- Run the query -->
    <xsl:variable name="queryResults"
      select="sql:query($books, 'select * from compbks')"/>

    <html>
      <head>
        <title>Computer books in our database</title>
      </head>
      <body style="font-family: sans-serif;">
        <h1>Computer books in our database</h1>
        <p>Here are the 
        <xsl:value-of select="count($queryResults/sql/row-set/row)"/>
        computer books we have in stock:</p>
        <table border="1" cellpadding="5">
          <tr>
            <xsl:for-each select="$queryResults/sql/metadata/column-header">
              <th>
                <xsl:value-of select="@column-label"/>
              </th>
            </xsl:for-each>
          </tr>
          <xsl:apply-templates select="$queryResults/sql/row-set/row"/> 
        </table>
      </body>
    </html>

    <!-- Close the connection -->
    <xsl:value-of select="sql:close($books)"/>
  </xsl:template>

  <xsl:template match="row">
    <tr>
      <xsl:apply-templates select="col"/>
    </tr>
  </xsl:template>

  <xsl:template match="col">
    <td>
      <xsl:value-of select="text()"/>
    </td>
  </xsl:template>

</xsl:stylesheet>
