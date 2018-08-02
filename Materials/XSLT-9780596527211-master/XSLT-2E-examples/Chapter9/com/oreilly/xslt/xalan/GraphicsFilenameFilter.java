/*
 * GraphicsFilenameFilter.java
 * Created on Nov 28, 2006 by Doug Tidwell
 */

package com.oreilly.xslt.xalan;
// The filename filter for Saxon is identical except for the package 
// name (com.oreilly.xslt.saxon)

import java.io.File;
import java.io.FilenameFilter;

public class GraphicsFilenameFilter implements FilenameFilter
{
  public boolean accept(File dir, String name)
  {
    String lcName = name.toLowerCase();
    if (lcName.endsWith(".jpg")  ||
        lcName.endsWith(".jpeg") ||
        lcName.endsWith(".png")  ||
        lcName.endsWith(".gif")  ||
        lcName.endsWith(".bmp"))
      return true;
    else
      return false;
  }
}
