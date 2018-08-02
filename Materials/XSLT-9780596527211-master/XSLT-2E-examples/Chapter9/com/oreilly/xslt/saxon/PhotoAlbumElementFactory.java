/*
 * PhotoAlbumElementFactory.java
 * Created on Nov 28, 2006 by Doug Tidwell
 */

package com.oreilly.xslt.saxon;

import net.sf.saxon.style.ExtensionElementFactory;

public class PhotoAlbumElementFactory
  implements ExtensionElementFactory
{
  public Class getExtensionClass(String elementName)
  {
    if (elementName.equals("SaxonPhotoAlbum"))
      return SaxonPhotoAlbum.class;
    return null;
  }
}
