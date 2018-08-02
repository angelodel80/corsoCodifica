/**
 * SpanishCollation.java
 * Created on Nov 22, 2006 by Skippy
 */

package com.oreilly.xslt;

import java.text.ParseException;
import java.text.RuleBasedCollator;

/**
 * @author Skippy
 *
 */
public class GermanCollation extends RuleBasedCollator
{
  public GermanCollation() throws ParseException
  {
    super(traditionalGermanRules);
  }
  
  private static String sharpS  = new String("\u00DF");
  private static String uppercaseUmlautA = new String("\u00C4");
  private static String lowercaseUmlautA = new String("\u00E4");
  private static String uppercaseUmlautO = new String("\u00D6");
  private static String lowercaseUmlautO = new String("\u00F6");
  private static String uppercaseUmlautU = new String("\u00DC");
  private static String lowercaseUmlautU = new String("\u00FC");

  private static String traditionalGermanRules =
    ("< a,A " + 
     "<" + lowercaseUmlautA + "=ae " +
     "<" + uppercaseUmlautA + "=AE " +
     "< b,B < c,C < d,D < e,E < f,F " +
     "< g,G < h,H < i,I < j,J < k,K " +
     "< l,L < m,M < n,N < o,O " + 
     "<" + lowercaseUmlautO + "=oe " +
     "<" + uppercaseUmlautO + "=OE " + 
     "< p,P < q,Q < r,R < s,S " + 
     "< ss=" + sharpS + 
     "< t,T < u,U " + 
     "<" + lowercaseUmlautU + "=ue " + 
     "<" + uppercaseUmlautU + "=UE " + 
     "< v,V < w,W < x,X < y,Y < z,Z");
}
