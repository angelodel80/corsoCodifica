/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 * 
 *      http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package dom;

import javax.xml.namespace.QName;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.DOMImplementation;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.ElementTraversal;

/**
 * This sample illustrates how to use the org.w3c.dom.ElementTraversal API.
 * 
 * @author Michael Glavassevich, IBM
 * 
 * @version $Id: ElementPrinter.java 950353 2010-06-02 03:35:11Z mrglavas $
 */
public class ElementPrinter {
    
    public static void main(String[] argv) {
        
        if (argv.length == 0) {
            printUsage();
            System.exit(1);
        }
        
        try {
            DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
            dbf.setNamespaceAware(true);
            dbf.setExpandEntityReferences(false);
            DocumentBuilder db = dbf.newDocumentBuilder();
            Document doc = db.parse(argv[0]);
            
            DOMImplementation domImpl = doc.getImplementation();
            if (domImpl.hasFeature("ElementTraversal", "1.0")) {
                print(doc.getDocumentElement(), 0);
            }
            else {
                System.err.println("The DOM implementation does not claim support for ElementTraversal.");
            }
        }
        catch (Exception ex) {
            ex.printStackTrace();
        }
    }
    
    private static void print(Element e, int depth) {
        do {
            ElementTraversal et = (ElementTraversal) e;
            for (int i = 0; i < depth; ++i) {
                System.out.print("--");
            }
            System.out.print("--> [");
            System.out.print(new QName(e.getNamespaceURI(), e.getLocalName()));
            System.out.println("], Child Element Count = " + et.getChildElementCount());
            Element firstElementChild = et.getFirstElementChild();
            if (firstElementChild != null) {
                print(firstElementChild, depth + 1);
            }
            e = et.getNextElementSibling();
        }
        while (e != null);
    }
    
    private static void printUsage() {
        System.err.println("usage: java dom.ElementPrinter uri");
    }

}
