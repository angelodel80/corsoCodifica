/*
 * XalanPhotoAlbumExtension.java
 * Created on Nov 28, 2006 by Doug Tidwell
 */

package com.oreilly.xslt.xalan;

import java.io.File;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.apache.xalan.extensions.XSLProcessorContext;
import org.apache.xalan.templates.ElemExtensionCall;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

//This class creates a photo album with all of the images in a 
//given directory.
public class XalanPhotoAlbumExtension
{
  // XalanPhotoAlbum is the name of the extension element.  Notice that 
  // it returns an Element node; that node is inserted into the output tree. 
  public static Element XalanPhotoAlbum(XSLProcessorContext context,
      ElemExtensionCall elem) 
    throws ParserConfigurationException
  {
    Element contextNode = (Element) context.getContextNode();

    // For parameters, we get the name of the directory, the number of
    // images per row, and whether the names of the files should be displayed.

    int imagesPerRowValue;
    try
    {
      imagesPerRowValue = 
        Integer.parseInt(contextNode.getAttribute("imagesPerRow"));
    } 
    catch (NumberFormatException nfe)
    {
      imagesPerRowValue = 5;
    }

    String directoryName = contextNode.getAttribute("directory");

    boolean includeFilenamesFlag = 
      (contextNode.getAttribute("includeFilenames").
          equalsIgnoreCase("yes"));

    // We're building a DOM tree, so we create a Document and some
    // elements beforehand.  We'll return a <table> element that
    // contains the images or an error message if something goes wrong.
    DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
    DocumentBuilder db = dbf.newDocumentBuilder();
    Document doc = db.newDocument();

    Element a = null, br = null, img = null, span = null, 
    table = null, td = null, tr = null;

    table = doc.createElement("table");
    table.setAttribute("border", "3");
    table.setAttribute("cellpadding", "5");

    File dir = new File(directoryName);
    
    // Return an error message if the directory doesn't exist
    if (!dir.exists())
    {
      tr = doc.createElement("tr");

      td = doc.createElement("td");
      td.setAttribute("style", "font-weight:bold; font-size: 150%");

      td.appendChild(doc.createTextNode("The directory "));

      span = doc.createElement("span");
      span.setAttribute("style", "font-family: monospace;");
      span.appendChild(doc.createTextNode(directoryName));
      td.appendChild(span);

      td.appendChild(doc.createTextNode(" does not exist!"));
      tr.appendChild(td);
      table.appendChild(tr);
    }
    else
    {
      // Use the filename filter to find the images      
      String[] graphicsFiles = dir.list(new GraphicsFilenameFilter());
      int numFiles = 0;
      if (graphicsFiles != null)
        numFiles = graphicsFiles.length;

      // Return an error message if the directory doesn't contain 
      // any images
      if (numFiles == 0)
      {
        tr = doc.createElement("tr");

        td = doc.createElement("td");
        td.setAttribute("style", "font-weight:bold; font-size: 150%");

        td.appendChild(doc.createTextNode("The directory "));

        span = doc.createElement("span");
        span.setAttribute("style", "font-family: monospace;");
        span.appendChild(doc.createTextNode(directoryName));
        td.appendChild(span);

        td.appendChild(doc.createTextNode(" doesn't contain any images!"));
        tr.appendChild(td);
        table.appendChild(tr);
      }
      
      // We've got images, so let's process 'em...
      else
      {
        tr = doc.createElement("tr");

        td = doc.createElement("td");
        td.setAttribute("colspan", String.valueOf(imagesPerRowValue));
        td.setAttribute("style", 
                        "font-weight:bold; background: #CCCCCC; " +
                        "font-size: 150%");
        td.appendChild(doc.createTextNode("Photos from "));

        span = doc.createElement("span");
        span.setAttribute("style", "font-family: monospace;");
        span.appendChild(doc.createTextNode(directoryName + ":"));
        td.appendChild(span);

        tr.appendChild(td);
        table.appendChild(tr);

        int filesProcessed = 0;
        boolean emptyColumnNotCreated = true; 

        while (filesProcessed < numFiles)
        {
          tr = doc.createElement("tr");
          for (int i = 0; i < imagesPerRowValue; i++)
          {
            if (filesProcessed < numFiles)
            {
              td = doc.createElement("td");
              td.setAttribute("style", "text-align: center;");

              String qualifiedFilename = "file:\\\\" +
              directoryName + File.separatorChar + 
              graphicsFiles[filesProcessed];

              a = doc.createElement("a");
              a.setAttribute("href", qualifiedFilename);

              img = doc.createElement("img");
              img.setAttribute("src", qualifiedFilename);
              img.setAttribute("width", "100px");
              img.setAttribute("height", "130px");
              img.setAttribute("border", "0");
              a.appendChild(img);

              td.appendChild(a);

              if (includeFilenamesFlag)
              {
                br = doc.createElement("br");
                td.appendChild(br);

                span = doc.createElement("span");
                span.setAttribute("style", "font-family: monospace;");
                span.appendChild(doc.createTextNode
                                 (graphicsFiles[filesProcessed]));
                td.appendChild(span);
              }
              tr.appendChild(td);
              filesProcessed++;
            }
            // we've listed all the files, so create an empty column
            else if (emptyColumnNotCreated) 
            {
              td = doc.createElement("td");
              td.setAttribute("colspan",
                              String.valueOf(imagesPerRowValue - i));
              td.setAttribute("bgcolor", "#CCCCCC");
              tr.appendChild(td);
              emptyColumnNotCreated = false;
            }
          }
          table.appendChild(tr);
        }
      }
    }
    return table;
  }
}
