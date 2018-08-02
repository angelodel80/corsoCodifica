/*
 * HiddenWord.java
 * Created on Nov 22, 2006 by Doug Tidwell
 */

package com.oreilly.xslt;

import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Font;
import java.awt.FontMetrics;
import java.awt.Graphics2D;
import java.awt.GraphicsEnvironment;
import java.awt.Rectangle;
import java.awt.font.LineMetrics;
import java.awt.image.BufferedImage;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Random;

import com.sun.image.codec.jpeg.ImageFormatException;
import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

// This class creates a JPEG that contains a hidden word.
public class HiddenWord
{
  // Three fonts likely to installed on any system...
  // If you want to generate hidden words in a non-Latin language, 
  // you'll need to change the font names.
  public static String[] fontNames = {"Arial", "Times", "Verdana"};
  
  // createJPEG() is the name of the extension function.
  public static int createJPEG(String outputFilename, 
                               String secretWord, 
                               Double dFontSize,
                               Double dWidth, 
                               Double dHeight)
    throws IOException, FileNotFoundException, 
      ImageFormatException, Exception
  {
    int rc = 0;
    
    try
    {
      int fontSize = dFontSize.intValue();
      int width = dWidth.intValue();
      int height = dHeight.intValue();
      
      // Create a new BufferedImage.  We'll use it as a canvas;
      // we draw the hidden word and the lines that obscure it 
      // onto the canvas, then write it out to a JPEG file. 
      BufferedImage bi = 
        new BufferedImage(width, height, 
                          BufferedImage.TYPE_3BYTE_BGR);
      
      Random r = new Random();
      String fontName = fontNames[r.nextInt(fontNames.length)];
      
      // Fill the new graphic with a white background
      Graphics2D g = bi.createGraphics();
      g.setColor(Color.WHITE);
      g.fill(new Rectangle(0, 0, width, height));
      g.setColor(Color.BLACK);

      int fontStyle = Font.BOLD;
      int textWidth = 0;
      int textHeight = 0;

      // Now we have to load the font.  There's a chance the
      // font we selected isn't available, so we look through 
      // the list of fonts until we find the one we're looking for.
      // If the font we want isn't available, we use Arial.  
      // This is much more complicated than the .Net version, 
      // where we assume the fonts are installed on every Windows
      // system. 
      GraphicsEnvironment ge = GraphicsEnvironment.
                               getLocalGraphicsEnvironment();
      Font allFonts[] = ge.getAllFonts();
      Font chosenFont = new Font("Arial", fontStyle, fontSize);
      g.setFont(chosenFont);
      FontMetrics fm = g.getFontMetrics();
      
      boolean fontNotFound = true;
      int j = 0;
      while (fontNotFound && (j < allFonts.length))
      {
        if (allFonts[j].getFontName().contains(fontName))
        {
          chosenFont = allFonts[j].deriveFont(fontStyle, fontSize);
          if (!chosenFont.getFontName().equalsIgnoreCase(fontName))
          {
            fontStyle = Font.PLAIN;
            chosenFont = allFonts[j].deriveFont(fontStyle, fontSize);
          }
          g.setFont(chosenFont);
          fm = g.getFontMetrics();
          
          // We look at the width and height of the word as drawn in 
          // the current font.  If it's too big to fit into the graphic
          // canvas, we reduce the font size and try it again. 
          textWidth = fm.stringWidth(secretWord);
          while (textWidth > width && fontSize > 2)
          {
            fontSize -= 2;
            chosenFont = allFonts[j].deriveFont(fontStyle, fontSize);
            g.setFont(chosenFont);
            fm = g.getFontMetrics();
            textWidth = fm.stringWidth(secretWord);
          }
          if (fontSize < 1)
            chosenFont = allFonts[j].deriveFont(fontStyle, 12);

          g.setFont(chosenFont);
          fontNotFound = false;
        }
        else
          j++;
      }
      
      // Now we draw the string onto the canvas.  We use the dimensions of 
      // the canvas itself and the dimensions of the string to center the 
      // text in the graphic. 
      fm = g.getFontMetrics(chosenFont);
      LineMetrics lm = 
        chosenFont.getLineMetrics(secretWord, g.getFontRenderContext());
      textHeight = (int)lm.getAscent();
      textWidth = fm.stringWidth(secretWord);
      g.drawString(secretWord, (width - textWidth) / 2, 
                   textHeight + 30);

      // Now we'll draw some lines at random to obscure the text. 
      g.setStroke(new BasicStroke((float)2.0));

      for (int i = 0; i < width / 30; i++)
        g.drawLine(0, r.nextInt(height), width, r.nextInt(height));
        
      int numLines = java.lang.Math.max(height, width) / 30;
      for (int i = 0; i < numLines; i++)
      {
        int nextX = r.nextInt(width);
        g.drawLine(nextX, 0, nextX, height);
        int nextY = r.nextInt(height);
        g.drawLine(0, nextY, width, nextY);
      }
      
      for (int i = 0; i < height / 20; i++)
        g.drawLine(r.nextInt(width), 0, r.nextInt(width), height);

      // We've drawn everything on the canvas that we wanted, so we'll
      // write the contents of the canvas out to a JPEG file. 
      FileOutputStream fos = new FileOutputStream(outputFilename);
      JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(fos);
      encoder.encode(bi);
      fos.flush();
      fos.close();
    }
    catch (FileNotFoundException fnfe)
    {
      rc = 4;
      System.err.println(fnfe);
    }
    catch (IOException ioe)
    {
      rc = 8;
      System.err.println(ioe);
    }
    catch (Exception e)
    {
      rc = 12;
      System.err.println(e);
    }
    
    return rc;
  }
}
