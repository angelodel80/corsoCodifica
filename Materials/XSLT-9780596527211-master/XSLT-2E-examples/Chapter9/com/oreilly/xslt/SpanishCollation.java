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
public class SpanishCollation extends RuleBasedCollator
{
  public SpanishCollation() throws ParseException
  {
    super(traditionalSpanishRules);
  }
  
  private static String smallnTilde  = new String("\u00F1");
  private static String capitalNTilde = new String("\u00D1");

  private static String traditionalSpanishRules =
    ("< a,A < b,B < c,C < ch, cH, Ch, CH "  +
     "< d,D < e,E < f,F < g,G < h,H < i,I " + 
     "< j,J < k,K < l,L < ll, lL, Ll, LL "  +
     "< m,M < n,N " +
     "< " + smallnTilde + "," + capitalNTilde + " " +
     "< o,O < p,P < q,Q < r,R < s,S < t,T " + 
     "< u,U < v,V < w,W < x,X < y,Y < z,Z");
}
