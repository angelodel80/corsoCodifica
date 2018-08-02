/**
 * ExtensionElementTester.java
 * Created on Aug 5, 2006 by Skippy
 */
package com.oreilly.xslt.saxon;

import javax.xml.transform.Result;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

public class ExtensionElementTester
{

  /**
   * @param args
   * @throws TransformerException 
   */
  public static void main(String[] args) 
    throws TransformerException
  {
    if (args.length < 2)
    {
      System.out.println("Usage: java ExtensionElementTester " + 
                         "XML-file XSL-file");
      System.exit(0);
    }
    
    Source xmlFile = new StreamSource(args[0]);
    Source xslFile = new StreamSource(args[1]);
    
    Result results = new StreamResult("saxon-test.html");
    
    TransformerFactory factory = TransformerFactory.newInstance();
    Transformer transformer = factory.newTransformer(xslFile);
    
    transformer.transform(xmlFile, results);
  }
}
