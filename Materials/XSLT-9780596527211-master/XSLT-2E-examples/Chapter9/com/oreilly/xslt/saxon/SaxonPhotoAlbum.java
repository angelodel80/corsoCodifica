/*
 * SaxonPhotoAlbum.java
 * Created on Nov 28, 2006 by Doug Tidwell
 */

package com.oreilly.xslt.saxon;

import java.io.File;

import net.sf.saxon.event.Receiver;
import net.sf.saxon.event.ReceiverOptions;
import net.sf.saxon.expr.Expression;
import net.sf.saxon.expr.SimpleExpression;
import net.sf.saxon.expr.XPathContext;
import net.sf.saxon.instruct.Executable;
import net.sf.saxon.om.NamePool;
import net.sf.saxon.style.ExtensionInstruction;
import net.sf.saxon.style.StandardNames;
import net.sf.saxon.trans.XPathException;

public class SaxonPhotoAlbum
  extends ExtensionInstruction
{
  Expression directory;
  Expression imagesPerRow;
  Expression includeFilenames;
 
  @Override
  public void prepareAttributes() throws XPathException
  {
    String directoryAttr = attributeList.getValue("", "directory");
    if (directoryAttr == null)
    {
      compileError("The directory attribute is required.", "");
      directoryAttr = "";
    }
    directory = makeAttributeValueTemplate(directoryAttr);
    
    String imagesPerRowAttr = 
      attributeList.getValue("", "imagesPerRow");
    if (imagesPerRowAttr == null)
      imagesPerRowAttr = "5";
    imagesPerRow = makeAttributeValueTemplate(imagesPerRowAttr); 
    
    String includeFilenamesAttr = 
      attributeList.getValue("", "includeFilenames");
    if (includeFilenamesAttr == null)
      includeFilenamesAttr = "no";
    includeFilenames = makeAttributeValueTemplate(includeFilenamesAttr); 
  }
  
  @Override
  public Expression compile(Executable arg0) throws XPathException
  {
    SaxonPhotoAlbumInstruction spa = 
      new SaxonPhotoAlbumInstruction(directory, 
                                     imagesPerRow, 
                                     includeFilenames);
    return spa;
  } 
  
  private static class SaxonPhotoAlbumInstruction 
    extends SimpleExpression {

    private static final long serialVersionUID = 1184239671886575198L;
    public static final int DIRECTORY = 0;
    public static final int IMAGES_PER_ROW = 1;
    public static final int INCLUDE_FILENAMES = 2;

    public SaxonPhotoAlbumInstruction(Expression directory, 
        Expression imagesPerRow, Expression includeFilenames)
    {
      Expression[] subs = {directory, imagesPerRow, includeFilenames};
      setArguments(subs);
    }

    /**
     * A subclass must provide one of the methods evaluateItem(), 
     * iterate(), or process(). This method indicates which of 
     * the three is provided.
     */

    public int getImplementationMethod() 
    {
        return Expression.PROCESS_METHOD;
    }

    public String getExpressionType() 
    {
        return "spa:SaxonPhotoAlbum";
    }

    public void process(XPathContext context) throws XPathException 
    {
      String directoryName = 
        arguments[DIRECTORY].evaluateAsString(context);

      int imagesPerRowValue = 5;
      try 
      {
        imagesPerRowValue = 
            Integer.parseInt(arguments[IMAGES_PER_ROW].
                             evaluateAsString(context));
      }
      catch (NumberFormatException nfe)
      {
        imagesPerRowValue = 5;
      }
      if (!(imagesPerRowValue > 0))
      {
        imagesPerRowValue = 5;
      }
      
      boolean includeFilenamesFlag = 
        arguments[INCLUDE_FILENAMES].evaluateAsString(context)
        .equals("yes");
     
      NamePool pool = context.getController().getNamePool();
      int anchorCode = pool.allocate("", "", "a");
      int borderCode = pool.allocate("", "", "border");
      int brCode = pool.allocate("", "", "br");
      int cellpaddingCode = pool.allocate("", "", "cellpadding");
      int colspanCode = pool.allocate("", "", "colspan");
      int heightCode = pool.allocate("", "", "height");
      int hrefCode = pool.allocate("", "", "href");
      int imgCode = pool.allocate("", "", "img");
      int spanCode = pool.allocate("", "", "span");
      int srcCode = pool.allocate("", "", "src");
      int styleCode = pool.allocate("", "", "style");
      int tableCode = pool.allocate("", "", "table");
      int colCode = pool.allocate("", "", "td");
      int rowCode = pool.allocate("", "", "tr");
      int widthCode = pool.allocate("", "", "width");
      
      Receiver out = context.getReceiver();
      
      // start <table>
      out.startElement(tableCode, StandardNames.XDT_UNTYPED, locationId, 0);
      out.attribute(borderCode, StandardNames.XDT_UNTYPED, 
                    "3", locationId, 0);
      out.attribute(cellpaddingCode, StandardNames.XDT_UNTYPED, 
                    "5", locationId, 0);

      String[] graphicsFiles;
      int numFiles = 0; 
      
      File dir = new File(directoryName);
      
      // Return an error message if the directory doesn't exist
      if (!dir.exists())
      {
        // start <tr> 
        out.startElement(rowCode, StandardNames.XDT_UNTYPED, locationId, 0);
        
        // start <td> 
        out.startElement(colCode, StandardNames.XDT_UNTYPED, locationId, 0);
        out.attribute(styleCode, StandardNames.XDT_UNTYPED, 
                      "font-weight: bold; font-size: 150%;", locationId, 0);
        out.characters("The directory ", locationId, 0);
        
        // start <span>
        out.startElement(spanCode, StandardNames.XDT_UNTYPED, locationId, 0);
        out.attribute(styleCode, StandardNames.XDT_UNTYPED, 
                      "font-family: monospace;", locationId, 0);
        out.characters(directoryName, locationId, 0);
        out.endElement(); // end <span>
        
        out.characters(" does not exist!", locationId, 0);
        out.endElement(); // end <td> 
        
        out.endElement(); // end <tr> 
      }
      else
      {
        // Use the filename filter to find the images
        graphicsFiles = dir.list(new GraphicsFilenameFilter());
        if (graphicsFiles != null)
          numFiles = graphicsFiles.length;

        // Return an error message if the directory doesn't contain
        // any images
        if (numFiles == 0)
        {
          // start <tr>
          out.startElement(rowCode, StandardNames.XDT_UNTYPED, locationId, 0);
          // start <td>
          out.startElement(colCode, StandardNames.XDT_UNTYPED, locationId, 0);
          out.attribute(styleCode, StandardNames.XDT_UNTYPED, 
                        "font-weight: bold; background: #CCCCCC; " +
                        "font-size: 150%;", 
                        locationId, 0);
          out.characters("The directory ", locationId, 0);
          // start <span>
          out.startElement(spanCode, StandardNames.XDT_UNTYPED, locationId, 0);
          out.attribute(styleCode, StandardNames.XDT_UNTYPED, 
                        "font-family: monospace;", locationId, 0);
          out.characters(directoryName, locationId, 0);
          out.endElement(); // end <span>
          out.characters(" doesn't contain any images!", locationId, 0);
          
          out.endElement(); // end <td>
          
          out.endElement(); // end <tr>
        }

        // We've got images, so let's process 'em...
        else
        {
          // start <tr>
          out.startElement(rowCode, StandardNames.XDT_UNTYPED, locationId, 0);

          // start <td>
          out.startElement(colCode, StandardNames.XDT_UNTYPED, locationId, 0);
          out.attribute(colspanCode, StandardNames.XDT_UNTYPED, String
              .valueOf(imagesPerRowValue), locationId, 0);
          out.attribute(styleCode, StandardNames.XDT_UNTYPED,
                        "font-weight: bold; background: #CCCCCC; "
                            + "font-size: 150%;", locationId, 0);
          out.characters("Photos from ", locationId, 0);

          // start <span>
          out.startElement(spanCode, StandardNames.XDT_UNTYPED, locationId, 0);
          out.attribute(styleCode, StandardNames.XDT_UNTYPED,
                        "font-family: monospace;", locationId, 0);
          out.characters(directoryName + ":", locationId, 0);
          out.endElement(); // end <span>

          out.endElement(); // end <td>

          out.endElement(); // end <tr>
        }

        int filesProcessed = 0;
        boolean emptyColumnNotCreated = true;

        while (filesProcessed < numFiles)
        {
          // start <tr>
          out.startElement(rowCode, StandardNames.XDT_UNTYPED, locationId, 0);

          for (int i = 0; i < imagesPerRowValue; i++)
          {
            if (filesProcessed < numFiles)
            {
              // start <td>
              out.startElement(colCode, StandardNames.XDT_UNTYPED, locationId,
                               0);
              out.attribute(styleCode, StandardNames.XDT_UNTYPED,
                            "text-align: center;", locationId, 0);

              String qualifiedFilename = "file:\\\\" + directoryName
                  + File.separatorChar + graphicsFiles[filesProcessed];

              // start <a>
              out.startElement(anchorCode, StandardNames.XDT_UNTYPED,
                               locationId, 0);
              out.attribute(hrefCode, StandardNames.XDT_UNTYPED,
                            qualifiedFilename, locationId, 0);

              // start <img>
              out.startElement(imgCode, StandardNames.XDT_UNTYPED, locationId,
                               0);
              out.attribute(widthCode, StandardNames.XDT_UNTYPED, "100px",
                            locationId, 0);
              out.attribute(heightCode, StandardNames.XDT_UNTYPED, "130px",
                            locationId, 0);
              out.attribute(srcCode, StandardNames.XDT_UNTYPED,
                            qualifiedFilename, locationId, 0);
              out.attribute(borderCode, StandardNames.XDT_UNTYPED, "0",
                            locationId, 0);
              out.endElement(); // end <img>

              out.endElement(); // end <a>

              if (includeFilenamesFlag)
              {
                // start <br>
                out.startElement(brCode, StandardNames.XDT_UNTYPED, locationId,
                                 0);
                out.endElement(); // end <br>

                // start <span style="font-family: monospace">
                out.startElement(spanCode, StandardNames.XDT_UNTYPED,
                                 locationId, 0);
                out.attribute(styleCode, StandardNames.XDT_UNTYPED,
                              "font-family: monospace;", locationId, 0);
                out.characters(graphicsFiles[filesProcessed], locationId, 0);
                out.endElement(); // end <span>
              }
              out.endElement(); // end <td>
              filesProcessed++;
            }
            // we've listed all the files, so create an empty column
            else if (emptyColumnNotCreated)
            {
              // start <td>
              out.startElement(colCode, StandardNames.XDT_UNTYPED, locationId,
                               0);
              out.attribute(styleCode, StandardNames.XDT_UNTYPED,
                            "background: #CCCCCC;", locationId, 0);
              out.attribute(colspanCode, StandardNames.XDT_UNTYPED, 
                            String.valueOf(imagesPerRowValue - i), 
                            locationId, 0);
              out.characters("&nbsp;", locationId,
                             ReceiverOptions.DISABLE_ESCAPING);
              out.endElement(); // end <td>
              emptyColumnNotCreated = false;
            }
          }
          out.endElement(); // end <tr>
        }
      }
      out.endElement(); // end <table> 
    }
  }
}
