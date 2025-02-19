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

package xs;

import java.io.StringReader;

import javax.xml.XMLConstants;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.xerces.impl.Constants;
import org.apache.xerces.impl.dv.xs.XSSimpleTypeDecl;
import org.apache.xerces.impl.xs.SchemaSymbols;
import org.apache.xerces.impl.xs.XMLSchemaLoader;
import org.apache.xerces.impl.xs.XSAnnotationImpl;
import org.apache.xerces.impl.xs.XSAttributeDecl;
import org.apache.xerces.impl.xs.XSAttributeGroupDecl;
import org.apache.xerces.impl.xs.XSComplexTypeDecl;
import org.apache.xerces.impl.xs.XSElementDecl;
import org.apache.xerces.impl.xs.XSGroupDecl;
import org.apache.xerces.impl.xs.XSModelGroupImpl;
import org.apache.xerces.impl.xs.XSWildcardDecl;
import org.apache.xerces.impl.xs.identity.Field;
import org.apache.xerces.impl.xs.identity.IdentityConstraint;
import org.apache.xerces.impl.xs.identity.KeyRef;
import org.apache.xerces.impl.xs.identity.Selector;
import org.apache.xerces.impl.xs.util.XS11TypeHelper;
import org.apache.xerces.xs.StringList;
import org.apache.xerces.xs.XSAttributeUse;
import org.apache.xerces.xs.XSComplexTypeDefinition;
import org.apache.xerces.xs.XSConstants;
import org.apache.xerces.xs.XSElementDeclaration;
import org.apache.xerces.xs.XSFacet;
import org.apache.xerces.xs.XSIDCDefinition;
import org.apache.xerces.xs.XSModel;
import org.apache.xerces.xs.XSModelGroup;
import org.apache.xerces.xs.XSMultiValueFacet;
import org.apache.xerces.xs.XSNamedMap;
import org.apache.xerces.xs.XSObject;
import org.apache.xerces.xs.XSObjectList;
import org.apache.xerces.xs.XSParticle;
import org.apache.xerces.xs.XSSimpleTypeDefinition;
import org.apache.xerces.xs.XSTerm;
import org.apache.xerces.xs.XSTypeDefinition;
import org.apache.xerces.xs.XSValue;
import org.apache.xerces.xs.XSWildcard;
import org.w3c.dom.DOMException;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.bootstrap.DOMImplementationRegistry;
import org.w3c.dom.ls.DOMImplementationLS;
import org.w3c.dom.ls.LSOutput;
import org.w3c.dom.ls.LSSerializer;
import org.xml.sax.InputSource;

/**
 * XSModel serialization utility.
 * This utility serializes the Xerces XSModel instance into lexical, XSD syntax.
 * 
 * @author Mukul Gandhi, IBM
 * @version $Id$
 */
public class XSSerializer {
    
    private static final String XSD_LANGUAGE_URI = SchemaSymbols.URI_SCHEMAFORSCHEMA;    
    private static final String XML_SCHEMA_VERSION = Constants.XERCES_PROPERTY_PREFIX + Constants.XML_SCHEMA_VERSION_PROPERTY;
    private static String XSD_LANGUAGE_PREFIX = "xs:";


    /*
     * "Main method"
     * 
     * An entry point to test this utility.
     * 
     * The XSModel could be synthesized by various means (for example, by direct
     * API calls to Xerces Schema API, methods) -- in which case, the method
     * "serialize" will be used directly, passing in the XSModel object. 
     */
    public static void main(String[] args) {

        if (args.length == 0 || args.length > 5) {
            printUsage();
            System.exit(-1);
        }

        // the last command line argument must be a schema URI
        String schemaUri = args[args.length - 1];

        // iterate other command line arguments
        String schemaVersion = null;
        String schemaPrefix = null;
        for (int argIndx = 0; argIndx < args.length - 1; argIndx += 2) {
            if (args[argIndx].equals("-version")) {
                schemaVersion = args[argIndx + 1];     
            }
            else if (args[argIndx].equals("-prefix")) {
                if (argIndx + 1 < args.length - 1) {
                    schemaPrefix = args[argIndx + 1];
                }
            }
        }

        XMLSchemaLoader xsLoader = new XMLSchemaLoader();
        if ("1.1".equals(schemaVersion)) {
            xsLoader.setProperty(XML_SCHEMA_VERSION, Constants.W3C_XML_SCHEMA11_NS_URI);    
        }
        else if (schemaVersion != null && !"1.0".equals(schemaVersion)) {
            printUsage();
            System.exit(-1);    
        }

        if (schemaPrefix != null) {
            XSD_LANGUAGE_PREFIX = schemaPrefix + ":";    
        }

        // construct the XSModel object from a schema document       
        XSModel xsModel = xsLoader.loadURI(schemaUri);

        try {
            // instantiate the serializer and invoke serialization method
            XSSerializer xsSerializer = new XSSerializer();
            xsSerializer.serialize(xsModel);
        }
        catch(Exception ex) {
            ex.printStackTrace();   
        }

    } // main


    /*
     * Print a diagnostic message, explaining how to invoke this sample.
     */
    private static void printUsage() {

        System.err.println("Usage:");
        System.err.println("java xs.XSSerializer [options] schema.xsd");
        System.err.println("\nOptions:");
        System.err.println("-version [1.0|1.1]      XSD language level (default level is 1.0)");
        System.err.println("-prefix  <prefix>       XSD language URI prefix (for e.g 'xs' or 'xsd'), for the serialized output");

    } // printUsage


    /*
     * Serialize an XML Schema, XSModel object to the standard output.
     */
    public void serialize(XSModel xsModel) throws Exception {       

        //get DOM after conversion, from XSModel
        Document xsdDocument = transformXSModelToDOMTree(xsModel);

        // serialize the DOM to XML Schema document
        DOMImplementationRegistry registry = DOMImplementationRegistry.newInstance();
        DOMImplementationLS impl =  (DOMImplementationLS) registry.getDOMImplementation("LS");
        LSSerializer writer = impl.createLSSerializer();
        writer.getDomConfig().setParameter("format-pretty-print", Boolean.TRUE);                  
        LSOutput output = impl.createLSOutput();
        output.setEncoding("UTF-8");
        output.setByteStream(System.out);
        writer.write(xsdDocument, output);

    } // serialize


    /*
     * Transform an XML Schema, XSModel object into DOM document.
     */
    public Document transformXSModelToDOMTree(XSModel xsModel) throws Exception {

        DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
        DocumentBuilder dBuilder = dbf.newDocumentBuilder();
        Document document = dBuilder.newDocument();

        Element schemaDeclDomNode = document.createElementNS(XSD_LANGUAGE_URI, XSD_LANGUAGE_PREFIX + SchemaSymbols.ELT_SCHEMA);
        
        document.appendChild(schemaDeclDomNode);

        // process global element declarations
        XSNamedMap globalElemDecls = xsModel.getComponents(XSConstants.ELEMENT_DECLARATION);
        processGlobalElementDecl(globalElemDecls, document, schemaDeclDomNode);

        // process global complex type declarations
        XSNamedMap globalComplexTypeDecls = xsModel.getComponents(XSTypeDefinition.COMPLEX_TYPE);
        processGlobalComplexTypeDecl(globalComplexTypeDecls, document, schemaDeclDomNode);

        // process global simple type declarations
        XSNamedMap globalSimpleTypeDecls = xsModel.getComponents(XSTypeDefinition.SIMPLE_TYPE);
        processGlobalSimpleTypeDecl(globalSimpleTypeDecls, document, schemaDeclDomNode);

        // process global attribute declarations
        XSNamedMap globalAttrDecls = xsModel.getComponents(XSConstants.ATTRIBUTE_DECLARATION);
        processGlobalAttrDecl(globalAttrDecls, document, schemaDeclDomNode);

        // process global attribute group declarations
        XSNamedMap globalAttrGroupDecls = xsModel.getComponents(XSConstants.ATTRIBUTE_GROUP);
        processGlobalAttrGroupDecl(globalAttrGroupDecls, document, schemaDeclDomNode);

        // process global model group declarations
        XSNamedMap globalGroupDecls = xsModel.getComponents(XSConstants.MODEL_GROUP_DEFINITION);
        processGlobalGroupDecl(globalGroupDecls, document, schemaDeclDomNode);

        return document;

    } // transformXSModelToDOMTree


    /*
     * Process global attribute group declarations.
     */
    private void processGlobalAttrGroupDecl(XSNamedMap globalAttrGpDecls, Document document, Element schemaDeclDomNode) {

        // iterating global attribute group declarations in the Schema
        for (int attrGpIdx = 0; attrGpIdx < globalAttrGpDecls.size(); attrGpIdx++) {
            XSAttributeGroupDecl attrGpDecl = (XSAttributeGroupDecl) globalAttrGpDecls.item(attrGpIdx);            
            String attrGpName = attrGpDecl.getName();
            Element attrGpDomNode = document.createElementNS(XSD_LANGUAGE_URI, XSD_LANGUAGE_PREFIX + SchemaSymbols.ELT_ATTRIBUTEGROUP);
            attrGpDomNode.setAttributeNS(null, SchemaSymbols.ATT_NAME, attrGpName);

            // add annotation to attribute group
            XSAnnotationImpl attrGpAnnotation = (XSAnnotationImpl) attrGpDecl.getAnnotation();
            if (attrGpAnnotation != null) {
                addAnnotationToSchemaComponent(document, attrGpDomNode, attrGpAnnotation);
            }

            XSObjectList attrUses = attrGpDecl.getAttributeUses();
            for (int attrUsesIdx = 0; attrUsesIdx < attrUses.size(); attrUsesIdx++) {
                XSAttributeUse attrUse = (XSAttributeUse) attrUses.item(attrUsesIdx);
                XSAttributeDecl attrDecl = (XSAttributeDecl) attrUse.getAttrDeclaration();
                String constraintName = null;
                String constraintVal = null;           
                if (attrUse.getConstraintType() != XSConstants.VC_NONE) {
                    constraintName = (attrUse.getConstraintType() == XSConstants.VC_DEFAULT) ? SchemaSymbols.ATT_DEFAULT : SchemaSymbols.ATT_FIXED;
                    XSValue xsConstraintVal = attrUse.getValueConstraintValue();
                    constraintVal = xsConstraintVal.getNormalizedValue();
                }
                String requiredVal = (attrUse.getRequired() == true) ? SchemaSymbols.ATTVAL_REQUIRED : SchemaSymbols.ATTVAL_OPTIONAL; 
                addAttributeToSchemaComponent(document, attrGpDomNode, attrDecl, constraintName, constraintVal, requiredVal);
            }

            // possible serialization of <anyAttribute/>
            XSWildcard attrWildCard = attrGpDecl.getAttributeWildcard();
            if (attrWildCard != null) {
                addWildcardToSchemaComponent(document, attrGpDomNode, (XSWildcardDecl) attrWildCard, SchemaSymbols.ELT_ANYATTRIBUTE, null, null);
            }

            schemaDeclDomNode.appendChild(attrGpDomNode);
        }  

    } // processGlobalAttrGroupDecl


    /*
     * Process global element declarations.
     */
    private void processGlobalElementDecl(XSNamedMap globalElemDecls, Document document, Element schemaDeclDomNode) throws DOMException {      
        // iterating global element declarations in the Schema
        for (int elemIdx = 0; elemIdx < globalElemDecls.size(); elemIdx++) {
            XSElementDecl elemDecl = (XSElementDecl) globalElemDecls.item(elemIdx);
            addElementDeclToSchemaComponent(document, schemaDeclDomNode, elemDecl, null, null, true);
        }      
    } // processGlobalElementDecl


    /*
     * Adding an element declaration to Schema component.
     */
    private void addElementDeclToSchemaComponent(Document document, Element parentDomNode, XSElementDecl elemDecl, String minOccurs, String maxOccurs, boolean isGlobal) throws DOMException {

        String elemName = elemDecl.getName();         
        Element elemDeclDomNode = document.createElementNS(XSD_LANGUAGE_URI, XSD_LANGUAGE_PREFIX + SchemaSymbols.ELT_ELEMENT);
        elemDeclDomNode.setAttributeNS(null, SchemaSymbols.ATT_NAME, elemName);

        // add annotation to an element declaration
        XSAnnotationImpl elemAnnotation = (XSAnnotationImpl) elemDecl.getAnnotation();
        if (elemAnnotation != null) {
            addAnnotationToSchemaComponent(document, elemDeclDomNode, elemAnnotation);
        }

        XSTypeDefinition typeDef = elemDecl.getTypeDefinition();
        if (!typeDef.getAnonymous()) {
            // handling a non-anonymous schema type
            String typeName = typeDef.getName();                     
            if (XMLConstants.W3C_XML_SCHEMA_NS_URI.equals(typeDef.getNamespace())) {               
                elemDeclDomNode.setAttributeNS(null, SchemaSymbols.ATT_TYPE, XSD_LANGUAGE_PREFIX + typeName);
            }
            else {
                elemDeclDomNode.setAttributeNS(null, SchemaSymbols.ATT_TYPE, typeName);  
            }         
        }
        else {
            // handling an anonymous schema type          
            if (typeDef.getTypeCategory() == XSTypeDefinition.SIMPLE_TYPE) {
                XSSimpleTypeDecl simpleTypeDecl = (XSSimpleTypeDecl) typeDef;
                processSimpleTypeContents(document, elemDeclDomNode, simpleTypeDecl, simpleTypeDecl.getName()); 
            }
            else if (typeDef.getTypeCategory() == XSTypeDefinition.COMPLEX_TYPE) {
                processAnonComplexTypeOnElement(document, elemDeclDomNode, typeDef);
            }   
        }

        // add possible, minOccurs & maxOccurs attributes
        if (!isGlobal) {
            if (minOccurs != null) {
                elemDeclDomNode.setAttributeNS(null, SchemaSymbols.ATT_MINOCCURS, minOccurs);  
            }
            if (maxOccurs != null) {
                elemDeclDomNode.setAttributeNS(null, SchemaSymbols.ATT_MAXOCCURS, maxOccurs);  
            }
        }

        // add "abstract" attribute to xs:element component, if applicable
        if (elemDecl.getAbstract() == true) {
            elemDeclDomNode.setAttributeNS(null, SchemaSymbols.ATT_ABSTRACT, SchemaSymbols.ATTVAL_TRUE);   
        }

        // add "block" attribute to xs:element component, if applicable
        String blockVal = getElementBlockAttrValue(elemDecl);
        if (!blockVal.equals("")) {
            elemDeclDomNode.setAttributeNS(null, SchemaSymbols.ATT_BLOCK, blockVal);   
        }

        // add "nillable" attribute to xs:element component, if applicable
        if (elemDecl.getNillable() == true) {
            elemDeclDomNode.setAttributeNS(null, SchemaSymbols.ATT_NILLABLE, SchemaSymbols.ATTVAL_TRUE);  
        }

        // add identity constraint definitions to an 'element declaration'
        addIDConstraintsToElementDecl(document, elemDecl, elemDeclDomNode);

        parentDomNode.appendChild(elemDeclDomNode);

    } // addElementDeclToSchemaComponent


    // construct value of the, "block" attribute for an element declaration.
    private String getElementBlockAttrValue(XSElementDecl elemDecl) {

        String blockVal = "";        
        boolean blockExt = false;
        boolean blockRestr = false;
        boolean blockSubst = false;        
        if (elemDecl.isDisallowedSubstitution(XSConstants.DERIVATION_EXTENSION) == true) {
            blockExt = true;
        }
        if (elemDecl.isDisallowedSubstitution(XSConstants.DERIVATION_RESTRICTION) == true) {
            blockRestr = true;
        }
        if (elemDecl.isDisallowedSubstitution(XSConstants.DERIVATION_SUBSTITUTION) == true) {
            blockSubst = true;
        }

        if ((blockExt == true) && (blockRestr == true) && (blockSubst == true)) {
            blockVal = SchemaSymbols.ATTVAL_POUNDALL;   
        }
        else {
            if (blockExt == true) {
                blockVal = blockVal + SchemaSymbols.ATTVAL_EXTENSION;  
            }
            if (blockRestr == true) {
                blockVal = blockVal + " " + SchemaSymbols.ATTVAL_RESTRICTION;  
            }
            if (blockSubst == true) {
                blockVal = blockVal + " " + SchemaSymbols.ATTVAL_SUBSTITUTION;  
            }
        }

        return blockVal;

    } // getElementBlockAttrValue


    /*
     * Add identity constraints to element declaration.
     */
    private void addIDConstraintsToElementDecl(Document document, XSElementDecl elemDecl, Element elemDeclDomNode) throws DOMException {

        XSNamedMap idConstraintsMap = elemDecl.getIdentityConstraints();

        // iterate all identity constraints on an element declaration
        for (int idConsIdx = 0; idConsIdx < idConstraintsMap.getLength(); idConsIdx++) {
            IdentityConstraint idCons = (IdentityConstraint) idConstraintsMap.item(idConsIdx);
            String consType = null;
            String idReferStr = null;           
            if (idCons.getCategory() == XSIDCDefinition.IC_UNIQUE) {
                consType = SchemaSymbols.ELT_UNIQUE;  
            }
            else if (idCons.getCategory() == XSIDCDefinition.IC_KEY) {
                consType = SchemaSymbols.ELT_KEY;    
            }
            else if (idCons.getCategory() == XSIDCDefinition.IC_KEYREF) {
                consType = SchemaSymbols.ELT_KEYREF;
                idReferStr = (((KeyRef) idCons).getKey()).getName(); 
            }

            Element idConsDomNode = document.createElementNS(XSD_LANGUAGE_URI, XSD_LANGUAGE_PREFIX + consType);
            String idConsName = idCons.getName();
            idConsDomNode.setAttributeNS(null, SchemaSymbols.ATT_NAME, idConsName);

            if (idReferStr != null) {
                idConsDomNode.setAttributeNS(null, SchemaSymbols.ATT_REFER, idReferStr);  
            }

            // add annotation to an ID constraint
            XSAnnotationImpl idConsAnnotation = (XSAnnotationImpl) idCons.getAnnotations().item(0);
            if (idConsAnnotation != null) {
                addAnnotationToSchemaComponent(document, idConsDomNode, idConsAnnotation);
            }

            Selector idSelector = idCons.getSelector();
            String selectorXPathStr = idSelector.getXPath().toString();
            Element selectorDomNode = document.createElementNS(XSD_LANGUAGE_URI, XSD_LANGUAGE_PREFIX + SchemaSymbols.ELT_SELECTOR);
            selectorDomNode.setAttributeNS(null, SchemaSymbols.ATT_XPATH, selectorXPathStr);
            idConsDomNode.appendChild(selectorDomNode);             

            for (int fieldIdx = 0; fieldIdx < idCons.getFieldCount(); fieldIdx++) {
                Field field = idCons.getFieldAt(fieldIdx);
                String fieldXpathStr = field.getXPath().toString();
                Element fieldDomNode = document.createElementNS(XSD_LANGUAGE_URI, XSD_LANGUAGE_PREFIX + SchemaSymbols.ELT_FIELD);
                fieldDomNode.setAttributeNS(null, SchemaSymbols.ATT_XPATH, fieldXpathStr);
                idConsDomNode.appendChild(fieldDomNode);
            }

            elemDeclDomNode.appendChild(idConsDomNode);             
        }

    } // addIDConstraintsToElementDecl


    /*
     * Process global complex type declarations.
     */
    private void processGlobalComplexTypeDecl(XSNamedMap globalComplexTypeDecls, Document document, Element schemaDeclDomNode) throws DOMException {

        // iterating global complex type definitions in the Schema.
        // leaving out built-in Schema type, "anyType" from iteration        
        for (int ctIdx = 0; ctIdx < globalComplexTypeDecls.size() - 1; ctIdx++) {
            XSComplexTypeDecl complexTypeDecl = (XSComplexTypeDecl) globalComplexTypeDecls.item(ctIdx);
            String ctName = complexTypeDecl.getName();
            Element complxTypeDomNode = document.createElementNS(XSD_LANGUAGE_URI, XSD_LANGUAGE_PREFIX + SchemaSymbols.ELT_COMPLEXTYPE);
            complxTypeDomNode.setAttributeNS(null, SchemaSymbols.ATT_NAME, ctName);

            // add annotation to complex type
            XSAnnotationImpl complexTypeAnnot = (XSAnnotationImpl) complexTypeDecl.getAnnotations().item(0);
            if (complexTypeAnnot != null) {
                addAnnotationToSchemaComponent(document, complxTypeDomNode, complexTypeAnnot);
            }

            addChildrenToComplexType(document, schemaDeclDomNode, complexTypeDecl, complxTypeDomNode);
        }

    } // processGlobalComplexTypeDecl


    /*
     * Process global simple type declarations.
     */
    private void processGlobalSimpleTypeDecl(XSNamedMap globalSimpleTypeDecls, Document document, Element schemaDeclDomNode) throws DOMException {
        // iterating global simple types in the Schema
        for (int stIdx = 0; stIdx < globalSimpleTypeDecls.size(); stIdx++) {
            XSSimpleTypeDecl simpleTypeDecl = (XSSimpleTypeDecl) globalSimpleTypeDecls.item(stIdx);
            // consider only user defined simple types
            if (!XMLConstants.W3C_XML_SCHEMA_NS_URI.equals(simpleTypeDecl.getNamespace())) {
                String stName = simpleTypeDecl.getName();
                processSimpleTypeContents(document, schemaDeclDomNode, simpleTypeDecl, stName);
            }
        }
    } // processGlobalSimpleTypeDecl


    /*
     * Processing Simple Type contents.
     */
    private void processSimpleTypeContents(Document document,Element parentDomNode, XSSimpleTypeDecl simpleTypeDecl, String stName) throws DOMException {

        Element simpleTypeDomNode = document.createElementNS(XSD_LANGUAGE_URI, XSD_LANGUAGE_PREFIX + SchemaSymbols.ELT_SIMPLETYPE);
        if (stName != null) {
            simpleTypeDomNode.setAttributeNS(null, SchemaSymbols.ATT_NAME, stName);
        }
        parentDomNode.appendChild(simpleTypeDomNode);

        // add annotation to a simple type
        XSAnnotationImpl simpleTypeAnnotation = (XSAnnotationImpl) simpleTypeDecl.getAnnotations().item(0);
        if (simpleTypeAnnotation != null) {
            addAnnotationToSchemaComponent(document, simpleTypeDomNode, simpleTypeAnnotation);
        }

        if (simpleTypeDecl.getVariety() == XSSimpleTypeDefinition.VARIETY_ATOMIC) {
            Element restrictionDomNode = document.createElementNS(XSD_LANGUAGE_URI, XSD_LANGUAGE_PREFIX + SchemaSymbols.ELT_RESTRICTION);
            XSTypeDefinition baseType = simpleTypeDecl.getBaseType();            
            addRestrictionToSimpleContent(document, simpleTypeDecl, simpleTypeDomNode, restrictionDomNode, baseType);
        }
        else if (simpleTypeDecl.getVariety() == XSSimpleTypeDefinition.VARIETY_LIST) {
            XSSimpleTypeDefinition listType = simpleTypeDecl.getItemType();
            addListDeclToSimpleType(document, simpleTypeDomNode, listType);
        }
        else if (simpleTypeDecl.getVariety() == XSSimpleTypeDefinition.VARIETY_UNION) {
            XSObjectList unionMemberTypes = simpleTypeDecl.getMemberTypes();           
            addUnionDeclToSimpleType(document, simpleTypeDomNode, unionMemberTypes);
        }

    } // processSimpleTypeContents


    /*
     * Add children to "xs:restriction" for simple contents.
     */
    private void addRestrictionToSimpleContent(Document document, XSTypeDefinition typeDefn, Element parentDomNode, Element restrictionDomNode, XSTypeDefinition baseType) throws DOMException {

        if (XMLConstants.W3C_XML_SCHEMA_NS_URI.equals(baseType.getNamespace())) {
            restrictionDomNode.setAttributeNS(null, SchemaSymbols.ATT_BASE, XSD_LANGUAGE_PREFIX + baseType.getName());   
        }
        else {
            restrictionDomNode.setAttributeNS(null, SchemaSymbols.ATT_BASE, baseType.getName());   
        }                

        // simple type definition to be used, to get the facets
        XSSimpleTypeDefinition simpleTypeDefn = null;

        if (typeDefn instanceof XSComplexTypeDefinition) {
            XSComplexTypeDefinition complexTypeDefn = (XSComplexTypeDefinition) typeDefn;
            simpleTypeDefn = complexTypeDefn.getSimpleType();

        }
        else {
            simpleTypeDefn = (XSSimpleTypeDefinition) typeDefn;     
        }

        // handling single-valued facets
        XSObjectList facets = simpleTypeDefn.getFacets();
        for (int facetIdx = 0; facetIdx < facets.getLength(); facetIdx++) {
            XSFacet facet = (XSFacet) facets.item(facetIdx);
            Element facetDomNode = document.createElementNS(XSD_LANGUAGE_URI, XSD_LANGUAGE_PREFIX + getFacetName(facet.getFacetKind()));
            facetDomNode.setAttributeNS(null, SchemaSymbols.ATT_VALUE, facet.getLexicalFacetValue());
            restrictionDomNode.appendChild(facetDomNode);
        }

        // handling multi-valued Facets ("enumeration" or "pattern")
        XSObjectList mvFacets = simpleTypeDefn.getMultiValueFacets();
        for (int mvFacetIdx = 0; mvFacetIdx < mvFacets.getLength(); mvFacetIdx++) {
            XSMultiValueFacet mvFacet = (XSMultiValueFacet) mvFacets.item(mvFacetIdx);
            StringList facetValues = mvFacet.getLexicalFacetValues();
            for (int facValIdex = 0; facValIdex < facetValues.getLength(); facValIdex++) {
                String facetValue = (String) facetValues.get(facValIdex);
                Element facetDomNode = null;
                if (mvFacet.getFacetKind() == XSSimpleTypeDefinition.FACET_ENUMERATION) {
                    facetDomNode = document.createElementNS(XSD_LANGUAGE_URI, XSD_LANGUAGE_PREFIX + SchemaSymbols.ELT_ENUMERATION);
                }
                else if (mvFacet.getFacetKind() == XSSimpleTypeDefinition.FACET_PATTERN) {
                    facetDomNode = document.createElementNS(XSD_LANGUAGE_URI, XSD_LANGUAGE_PREFIX + SchemaSymbols.ELT_PATTERN);
                }
                facetDomNode.setAttributeNS(null, SchemaSymbols.ATT_VALUE, facetValue);
                restrictionDomNode.appendChild(facetDomNode);
            }
        }

        parentDomNode.appendChild(restrictionDomNode);

    } // addRestrictionToSimpleContent


    /*
     * Process global attribute declarations.
     */
    private void processGlobalAttrDecl(XSNamedMap globalAttrDecls, Document document, Element schemaDeclDomNode) throws DOMException {

        // iterating global attribute declarations in the Schema             
        for (int attrIdx = 0; attrIdx < globalAttrDecls.size(); attrIdx++) {
            XSAttributeDecl attrDecl = (XSAttributeDecl) globalAttrDecls.item(attrIdx);
            String constraintName = null;
            String constraintVal = null;           
            if (attrDecl.getConstraintType() != XSConstants.VC_NONE) {
                constraintName = (attrDecl.getConstraintType() == XSConstants.VC_DEFAULT) ? SchemaSymbols.ATT_DEFAULT : SchemaSymbols.ATT_FIXED;
                constraintVal = attrDecl.getConstraintValue();
            }
            addAttributeToSchemaComponent(document, schemaDeclDomNode, attrDecl, constraintName, constraintVal, null);
        }

    } // processGlobalAttrDecl


    /*
     * Process global group declarations.
     */
    private void processGlobalGroupDecl(XSNamedMap globalGroupDecls, Document document, Element schemaDeclDomNode) {        
        // iterating global group declarations in the Schema             
        for (int groupIdx = 0; groupIdx < globalGroupDecls.size(); groupIdx++) {
            XSGroupDecl groupDecl = (XSGroupDecl) globalGroupDecls.item(groupIdx);
            addGroupChildToSchemaComponent(document, schemaDeclDomNode, groupDecl, true);
        }        
    } // processGlobalGroupDecl


    /*
     * Add xs:group child to a Schema component.
     */
    private void addGroupChildToSchemaComponent(Document document, Element parentDomNode, XSGroupDecl groupDecl, boolean isGlobal) {

        Element groupDeclDomNode = document.createElementNS(XSD_LANGUAGE_URI, XSD_LANGUAGE_PREFIX + SchemaSymbols.ELT_GROUP);
        // add annotation to a group declaration
        XSAnnotationImpl groupAnnotation = (XSAnnotationImpl) groupDecl.getAnnotation();
        if (groupAnnotation != null) {
            addAnnotationToSchemaComponent(document, groupDeclDomNode, groupAnnotation);
        }

        if (isGlobal) {
            String groupName = groupDecl.getName();
            groupDeclDomNode.setAttributeNS(null, SchemaSymbols.ATT_NAME, groupName); 
            XSModelGroup modelGroup = groupDecl.getModelGroup();
            if (modelGroup.getCompositor() == XSModelGroup.COMPOSITOR_SEQUENCE) {
                addCompositorOnSchemaComponent(document, groupDeclDomNode, modelGroup, SchemaSymbols.ELT_SEQUENCE, "1", "1");
            }
            else if (modelGroup.getCompositor() == XSModelGroup.COMPOSITOR_CHOICE) {
                addCompositorOnSchemaComponent(document, groupDeclDomNode, modelGroup, SchemaSymbols.ELT_CHOICE, "1", "1");
            }
            else if (modelGroup.getCompositor() == XSModelGroup.COMPOSITOR_ALL) {
                addAllCompositorOnComplexType(document, groupDeclDomNode, modelGroup, "1", "1");
            }
        }

        parentDomNode.appendChild(groupDeclDomNode);

    } // addGroupChildToSchemaComponent 


    /*
     * Add attribute declaration to a Schema component (like xs:schema, xs:complexType etc).
     */
    private void addAttributeToSchemaComponent(Document document, Element parentDomNode, XSAttributeDecl attrDecl, String constraintName, 
                                               String constraintVal, String requiredVal) throws DOMException {

        String attrName = attrDecl.getName();            
        Element attrDeclDomNode = document.createElementNS(XSD_LANGUAGE_URI, XSD_LANGUAGE_PREFIX + SchemaSymbols.ELT_ATTRIBUTE);
        attrDeclDomNode.setAttributeNS(null, SchemaSymbols.ATT_NAME, attrName);        
        parentDomNode.appendChild(attrDeclDomNode);

        // add annotation to attribute declaration
        XSAnnotationImpl attrAnnotation = (XSAnnotationImpl) attrDecl.getAnnotation();
        if (attrAnnotation != null) {
            addAnnotationToSchemaComponent(document, attrDeclDomNode, attrAnnotation);
        }

        if (constraintName != null) {
            attrDeclDomNode.setAttributeNS(null, constraintName, constraintVal);  
        }

        if (requiredVal != null) {
            attrDeclDomNode.setAttributeNS(null, SchemaSymbols.ATT_USE, requiredVal);  
        }

        XSTypeDefinition typeDef = attrDecl.getTypeDefinition();
        if (!typeDef.getAnonymous()) {
            // handling a non-anonymous schema type
            String typeName = typeDef.getName();                     
            if (XMLConstants.W3C_XML_SCHEMA_NS_URI.equals(typeDef.getNamespace())) {               
                attrDeclDomNode.setAttributeNS(null, SchemaSymbols.ATT_TYPE, XSD_LANGUAGE_PREFIX + typeName);
            }
            else {
                attrDeclDomNode.setAttributeNS(null, SchemaSymbols.ATT_TYPE, typeName);  
            }   
        }
        else {
            // handling an anonymous schema type
            XSSimpleTypeDecl simpleTypeDecl = (XSSimpleTypeDecl) typeDef;
            processSimpleTypeContents(document, attrDeclDomNode, simpleTypeDecl, simpleTypeDecl.getName());              
        }

    } // addAttributeToSchemaComponent


    /*
     * Processing an "anonymous" complex type declaration, on an element.
     */
    private void processAnonComplexTypeOnElement(Document document, Element elemDeclDomNode, XSTypeDefinition typeDef) throws DOMException {

        XSComplexTypeDecl complexTypeDecl = (XSComplexTypeDecl) typeDef;       
        Element complexTypeDomNode = document.createElementNS(XSD_LANGUAGE_URI, XSD_LANGUAGE_PREFIX + SchemaSymbols.ELT_COMPLEXTYPE);
        // add annotation to a complex type
        XSAnnotationImpl cmplxTypeAnnotation = (XSAnnotationImpl) complexTypeDecl.getAnnotations().item(0);
        if (cmplxTypeAnnotation != null) {
            addAnnotationToSchemaComponent(document, complexTypeDomNode, cmplxTypeAnnotation);
        }

        addChildrenToComplexType(document, elemDeclDomNode, complexTypeDecl, complexTypeDomNode);

    } // processAnonComplexTypeOnElement


    /*
     * Add child content to complex type definition.
     */
    private void addChildrenToComplexType(Document document, Element parentDomNode, XSComplexTypeDecl complexTypeDecl, Element complexTypeDomNode) throws DOMException {

        // add "abstract" & "mixed" attributes if applicable  
        boolean isAbstract = complexTypeDecl.getAbstract();
        boolean isMixed = (complexTypeDecl.getContentType() == XSComplexTypeDefinition.CONTENTTYPE_MIXED);
        if (isAbstract) {
            complexTypeDomNode.setAttributeNS(null, SchemaSymbols.ATT_ABSTRACT, SchemaSymbols.ATTVAL_TRUE);   
        }
        if (isMixed) {
            complexTypeDomNode.setAttributeNS(null, SchemaSymbols.ATT_MIXED, SchemaSymbols.ATTVAL_TRUE);   
        }

        // add "block" attribute if applicable
        short prohSubstitutions = complexTypeDecl.getProhibitedSubstitutions();
        String prohSubsStr = "";
        if (prohSubstitutions == (XSConstants.DERIVATION_EXTENSION | XSConstants.DERIVATION_RESTRICTION)) {
            prohSubsStr = SchemaSymbols.ATTVAL_POUNDALL;   
        }
        else if (prohSubstitutions == XSConstants.DERIVATION_EXTENSION) {
            prohSubsStr = SchemaSymbols.ELT_EXTENSION; 
        }
        else if (prohSubstitutions == XSConstants.DERIVATION_RESTRICTION) {
            prohSubsStr = SchemaSymbols.ELT_RESTRICTION; 
        }        
        if (!prohSubsStr.equals("")) {
            complexTypeDomNode.setAttributeNS(null, SchemaSymbols.ATT_BLOCK, prohSubsStr);   
        }

        // add "final" attribute if applicable
        short finalSet = complexTypeDecl.getFinalSet();
        String finalStr = "";
        if (finalSet == (XSConstants.DERIVATION_EXTENSION | XSConstants.DERIVATION_RESTRICTION)) {
            finalStr = SchemaSymbols.ATTVAL_POUNDALL;   
        }
        else if (finalSet == XSConstants.DERIVATION_EXTENSION) {
            finalStr = SchemaSymbols.ELT_EXTENSION; 
        }
        else if (finalSet == XSConstants.DERIVATION_RESTRICTION) {
            finalStr = SchemaSymbols.ELT_RESTRICTION; 
        }        
        if (!finalStr.equals("")) {
            complexTypeDomNode.setAttributeNS(null, SchemaSymbols.ATT_FINAL, finalStr);   
        }

        parentDomNode.appendChild(complexTypeDomNode);

        short derivationMethod = complexTypeDecl.getDerivationMethod();

        if (complexTypeDecl.getContentType() == XSComplexTypeDefinition.CONTENTTYPE_SIMPLE) {
            // add xs:simpleContent as child of xs:complexType
            addSimpleContentToComplexType(document, complexTypeDomNode, complexTypeDecl);   
        }
        else if ((derivationMethod == XSConstants.DERIVATION_RESTRICTION) || (derivationMethod == XSConstants.DERIVATION_EXTENSION)) {
            if (!XMLConstants.W3C_XML_SCHEMA_NS_URI.equals(complexTypeDecl.getBaseType().getNamespace())) {
                // add xs:complexContent as child of xs:complexType
                addComplexContentToComplexType(document, complexTypeDomNode, complexTypeDecl, derivationMethod);
            }
            else {
                XSParticle particle = complexTypeDecl.getParticle();
                if (particle != null) {
                    processParticleFromComplexType(document, complexTypeDomNode, particle);
                    // add attributes to the complex type
                    addAttributesToComplexType(document, complexTypeDecl, complexTypeDomNode);
                } 
                else {
                    addAttributesToComplexType(document, complexTypeDecl, complexTypeDomNode);
                }
            }
        }

    } // addChildrenToComplexType


    /*
     * Add xs:simpleContent as child of xs:complexType.
     */
    private void addSimpleContentToComplexType(Document document, Element complexTypeDomNode, XSComplexTypeDecl complexTypeDecl) {

        Element simpleContentDomNode = document.createElementNS(XSD_LANGUAGE_URI, XSD_LANGUAGE_PREFIX + SchemaSymbols.ELT_SIMPLECONTENT);
        if (complexTypeDecl.getDerivationMethod() == XSConstants.DERIVATION_RESTRICTION) {
            Element simpleContentRestrDomNode = document.createElementNS(XSD_LANGUAGE_URI, XSD_LANGUAGE_PREFIX + SchemaSymbols.ELT_RESTRICTION);
            XSTypeDefinition baseType = complexTypeDecl.getBaseType();
            if (XMLConstants.W3C_XML_SCHEMA_NS_URI.equals(baseType.getNamespace())) {
                simpleContentRestrDomNode.setAttributeNS(null, SchemaSymbols.ATT_BASE, XSD_LANGUAGE_PREFIX + baseType.getName());   
            }
            else {
                simpleContentRestrDomNode.setAttributeNS(null, SchemaSymbols.ATT_BASE, baseType.getName());   
            }     

            addRestrictionToSimpleContent(document, complexTypeDecl, simpleContentDomNode, simpleContentRestrDomNode, complexTypeDecl.getBaseType());
            addAttributesToComplexType(document, complexTypeDecl, simpleContentRestrDomNode);

            simpleContentDomNode.appendChild(simpleContentRestrDomNode);
        }
        else if (complexTypeDecl.getDerivationMethod() == XSConstants.DERIVATION_EXTENSION) {
            Element simpleContentExtDomNode = document.createElementNS(XSD_LANGUAGE_URI, XSD_LANGUAGE_PREFIX + SchemaSymbols.ELT_EXTENSION);
            XSTypeDefinition baseType = complexTypeDecl.getBaseType();
            if (XMLConstants.W3C_XML_SCHEMA_NS_URI.equals(baseType.getNamespace())) {
                simpleContentExtDomNode.setAttributeNS(null, SchemaSymbols.ATT_BASE, XSD_LANGUAGE_PREFIX + baseType.getName());   
            }
            else {
                simpleContentExtDomNode.setAttributeNS(null, SchemaSymbols.ATT_BASE, baseType.getName());   
            }
            addAttributesToComplexType(document, complexTypeDecl, simpleContentExtDomNode);
            simpleContentDomNode.appendChild(simpleContentExtDomNode);
        }

        complexTypeDomNode.appendChild(simpleContentDomNode);

    } // addSimpleContentToComplexType 


    /*
     * Add xs:complexContent as child of xs:complexType.
     */
    private void addComplexContentToComplexType(Document document, Element complexTypeDomNode, XSComplexTypeDecl complexTypeDecl, short derivationMethod) {

        Element complexContentDomNode = document.createElementNS(XSD_LANGUAGE_URI, XSD_LANGUAGE_PREFIX + SchemaSymbols.ELT_COMPLEXCONTENT);
        Element complexContentDerivationNode = null;        
        if (derivationMethod == XSConstants.DERIVATION_RESTRICTION) {
            complexContentDerivationNode = document.createElementNS(XSD_LANGUAGE_URI, XSD_LANGUAGE_PREFIX + SchemaSymbols.ELT_RESTRICTION);                                    
        }
        else if (derivationMethod == XSConstants.DERIVATION_EXTENSION) {
            complexContentDerivationNode = document.createElementNS(XSD_LANGUAGE_URI, XSD_LANGUAGE_PREFIX + SchemaSymbols.ELT_EXTENSION);
        }

        if (complexContentDerivationNode != null) {
            XSTypeDefinition baseType = complexTypeDecl.getBaseType();
            if (XMLConstants.W3C_XML_SCHEMA_NS_URI.equals(baseType.getNamespace())) {
                complexContentDerivationNode.setAttributeNS(null, SchemaSymbols.ATT_BASE, XSD_LANGUAGE_PREFIX + baseType.getName());   
            }
            else {
                complexContentDerivationNode.setAttributeNS(null, SchemaSymbols.ATT_BASE, baseType.getName());   
            }
            complexContentDomNode.appendChild(complexContentDerivationNode);
        }

        XSParticle particle = complexTypeDecl.getParticle();
        if (derivationMethod == XSConstants.DERIVATION_EXTENSION) {
            XSTerm particleTerm = null;
            if (particle != null) {
                particleTerm = particle.getTerm();
                XSModelGroupImpl modelGroup = (XSModelGroupImpl) particleTerm;
                if (modelGroup.fParticles.length == 2) {
                    particle = modelGroup.fParticles[1];  
                }
            }             
        }

        if (particle != null) {
            processParticleFromComplexType(document, complexContentDerivationNode, particle);
        }

        addAttributesToComplexType(document, complexTypeDecl, complexContentDerivationNode);

        complexTypeDomNode.appendChild(complexContentDomNode);

    } // addComplexContentToComplexType


    /*
     * Add attributes to the complex type.
     */
    private void addAttributesToComplexType(Document document, XSComplexTypeDecl complexTypeDecl, Element parentDomNode) throws DOMException {

        // iterate all attributes on the complex type. all attributes on a complex type (from all-of 
        // it's xs:attribute & xs:attributeGroup declarations) are expanded, into an XSObjectList list.  
        XSObjectList attributeUses = complexTypeDecl.getAttributeUses();
        for (int attrUsesIdx = 0; attrUsesIdx < attributeUses.getLength(); attrUsesIdx++) {
            XSAttributeUse attrUse = (XSAttributeUse) attributeUses.item(attrUsesIdx);
            String constraintName = null;
            String constraintVal = null;           
            if (attrUse.getConstraintType() != XSConstants.VC_NONE) {
                constraintName = (attrUse.getConstraintType() == XSConstants.VC_DEFAULT) ? SchemaSymbols.ATT_DEFAULT : SchemaSymbols.ATT_FIXED;
                XSValue xsConstraintVal = attrUse.getValueConstraintValue();
                constraintVal = xsConstraintVal.getNormalizedValue();
            }

            String requiredVal = (attrUse.getRequired() == true) ? SchemaSymbols.ATTVAL_REQUIRED : SchemaSymbols.ATTVAL_OPTIONAL;           
            XSAttributeDecl attrDecl = (XSAttributeDecl) attrUse.getAttrDeclaration();
            XSComplexTypeDefinition enclosingCTDefn = attrDecl.getEnclosingCTDefinition();
            boolean complexTypesIdentical = (enclosingCTDefn == null) ? false : XS11TypeHelper.isSchemaTypesIdentical(complexTypeDecl, enclosingCTDefn);
            // do not add attributes, from the base type. they will be serialized as part of the base type serialization.
            if (complexTypesIdentical) {
                addAttributeToSchemaComponent(document, parentDomNode, attrDecl, constraintName, constraintVal, requiredVal); 
            }
        }
        
        // possible serialization of <anyAttribute/>
        XSWildcard attrWildCard = complexTypeDecl.getAttributeWildcard();
        if (attrWildCard != null) {            
            addWildcardToSchemaComponent(document, parentDomNode, (XSWildcardDecl) attrWildCard, SchemaSymbols.ELT_ANYATTRIBUTE, null, null);
        }

    } // addAttributesToComplexType    


    /*
     * Processing a "particle" from a complex type.
     */
    private void processParticleFromComplexType(Document document, Element parentDomNode, XSParticle particle) throws DOMException {

        XSTerm particleTerm = particle.getTerm();

        if (particleTerm instanceof XSModelGroup) {
            XSModelGroup modelGroup = (XSModelGroup) particleTerm;
            String minOccurs = getMinOccursVal(particle);
            String maxOccurs = getMaxOccursVal(particle);
            if (modelGroup.getCompositor() == XSModelGroup.COMPOSITOR_SEQUENCE) {
                addCompositorOnSchemaComponent(document, parentDomNode, modelGroup, SchemaSymbols.ELT_SEQUENCE, minOccurs, maxOccurs);
            }
            else if (modelGroup.getCompositor() == XSModelGroup.COMPOSITOR_CHOICE) {
                addCompositorOnSchemaComponent(document, parentDomNode, modelGroup, SchemaSymbols.ELT_CHOICE, minOccurs, maxOccurs);
            }
            else if (modelGroup.getCompositor() == XSModelGroup.COMPOSITOR_ALL) {
                addAllCompositorOnComplexType(document, parentDomNode, modelGroup, minOccurs, maxOccurs);
            }
        }        

    } // processParticleFromComplexType


    /*
     * Adding a "sequence" or "choice" compositor on a complex type.
     */
    private void addCompositorOnSchemaComponent(Document document, Element parentDomNode, XSModelGroup modelGroup, String compositor, String minOccurs, String maxOccurs) throws DOMException {

        Element compositorDomNode = document.createElementNS(XSD_LANGUAGE_URI, XSD_LANGUAGE_PREFIX + compositor);
        // add minOccurs & maxOccurs attributes to the compositor root
        if (minOccurs != null && !minOccurs.equals("1")) {
            compositorDomNode.setAttributeNS(null, SchemaSymbols.ATT_MINOCCURS, minOccurs);
        }
        if (maxOccurs != null && !maxOccurs.equals("1")) {
            compositorDomNode.setAttributeNS(null, SchemaSymbols.ATT_MAXOCCURS, maxOccurs);
        }

        XSObjectList compositorChildren = modelGroup.getParticles();
        for (int seqIdx = 0; seqIdx < compositorChildren.getLength(); seqIdx++) {
            XSObject seqItem = compositorChildren.item(seqIdx);
            XSParticle compositorParticle = (XSParticle) seqItem;
            String minOccursParticle = getMinOccursVal(compositorParticle);
            String maxOccursParticle = getMaxOccursVal(compositorParticle);
            XSTerm partclTerm = compositorParticle.getTerm();            
            if (partclTerm instanceof XSElementDeclaration) {
                XSElementDecl elemDecl = (XSElementDecl) partclTerm;
                addElementDeclToSchemaComponent(document, compositorDomNode, elemDecl, minOccursParticle, maxOccursParticle, false);
            }
            else if (partclTerm instanceof XSModelGroup) {
                // recursively adding model groups
                XSModelGroup partlModelGroup = (XSModelGroup) partclTerm;
                if (partlModelGroup.getCompositor() == XSModelGroup.COMPOSITOR_CHOICE) {
                    addCompositorOnSchemaComponent(document, compositorDomNode, partlModelGroup, SchemaSymbols.ELT_CHOICE, minOccursParticle, maxOccursParticle); 
                }
                else if (partlModelGroup.getCompositor() == XSModelGroup.COMPOSITOR_SEQUENCE) {
                    addCompositorOnSchemaComponent(document, compositorDomNode, partlModelGroup, SchemaSymbols.ELT_SEQUENCE, minOccursParticle, maxOccursParticle);  
                }
            }
            else if (partclTerm instanceof XSWildcard) {
                addWildcardToSchemaComponent(document, compositorDomNode, (XSWildcardDecl) partclTerm, SchemaSymbols.ELT_ANY, minOccursParticle, maxOccursParticle);   
            }
        }

        parentDomNode.appendChild(compositorDomNode);

    } // addCompositorOnSchemaComponent


    /*
     * Processing an "all" declaration on a complex type.
     */
    private void addAllCompositorOnComplexType(Document document, Element complxTypeDomNode, XSModelGroup modelGroup, String minOccurs, String maxOccurs) throws DOMException {

        Element allDeclDomNode = document.createElementNS(XSD_LANGUAGE_URI, XSD_LANGUAGE_PREFIX + SchemaSymbols.ELT_ALL);
        // add minOccurs & maxOccurs attributes to the compositor root
        if (minOccurs != null && !minOccurs.equals("1")) {
            allDeclDomNode.setAttributeNS(null, SchemaSymbols.ATT_MINOCCURS, minOccurs);
        }
        if (maxOccurs != null && !maxOccurs.equals("1")) {
            allDeclDomNode.setAttributeNS(null, SchemaSymbols.ATT_MAXOCCURS, maxOccurs);
        }

        XSObjectList modelParticles = modelGroup.getParticles();
        for (int prtclIdx = 0; prtclIdx < modelParticles.getLength(); prtclIdx++) {
            XSParticle partclItem = (XSParticle) modelParticles.item(prtclIdx);
            String minOccursParticle = getMinOccursVal(partclItem);
            String maxOccursParticle = getMaxOccursVal(partclItem);            
            XSTerm partclTerm = partclItem.getTerm();            
            if (partclTerm instanceof XSElementDeclaration) {                
                addElementDeclToSchemaComponent(document, allDeclDomNode, (XSElementDecl) partclTerm, minOccursParticle, maxOccursParticle, false);   
            }
            else if (partclTerm instanceof XSWildcard) {
                XSWildcardDecl wildCardDecl = (XSWildcardDecl) partclTerm;
                addWildcardToSchemaComponent(document, allDeclDomNode, wildCardDecl, SchemaSymbols.ELT_ANY, minOccursParticle, maxOccursParticle);                                        
            }
        }

        complxTypeDomNode.appendChild(allDeclDomNode);

    } // addAllCompositorOnComplexType 


    /*
     * Adding wild-card to a Schema component.
     */
    private void addWildcardToSchemaComponent(Document document, Element parentNode, XSWildcardDecl wildCardDecl, String wildCardType, String minOccurs, String maxOccurs) {        
        Element wildCardDomNode = document.createElementNS(XSD_LANGUAGE_URI, XSD_LANGUAGE_PREFIX + wildCardType);
        String processContentsVal = wildCardDecl.getProcessContentsAsString();
        if (!processContentsVal.equals(SchemaSymbols.ATTVAL_STRICT)) {
            wildCardDomNode.setAttributeNS(null, SchemaSymbols.ATT_PROCESSCONTENTS, processContentsVal);
        }
        if (minOccurs != null) {
            wildCardDomNode.setAttributeNS(null, SchemaSymbols.ATT_MINOCCURS, minOccurs);
        }
        if (maxOccurs != null) {
            wildCardDomNode.setAttributeNS(null, SchemaSymbols.ATT_MAXOCCURS, maxOccurs);
        }
        parentNode.appendChild(wildCardDomNode);                
    } // addWildcardToSchemaComponent


    /*
     * Add xs:list as child of xs:simpleType.
     */
    private void addListDeclToSimpleType(Document document, Element simpleTypeDomNode, XSSimpleTypeDefinition listType) {

        Element listDomNode = document.createElementNS(XSD_LANGUAGE_URI, XSD_LANGUAGE_PREFIX + SchemaSymbols.ELT_LIST);
        simpleTypeDomNode.appendChild(listDomNode);
        if (XMLConstants.W3C_XML_SCHEMA_NS_URI.equals(listType.getNamespace())) {
            listDomNode.setAttributeNS(null, SchemaSymbols.ATT_ITEMTYPE, XSD_LANGUAGE_PREFIX + listType.getName());
        }
        else {
            if (listType.getName() != null) {
                listDomNode.setAttributeNS(null, SchemaSymbols.ATT_ITEMTYPE, listType.getName());
            }
            else {
                // add xs:simpleType as child of, xs:list
                XSSimpleTypeDecl simpleTypeDeclOfList = (XSSimpleTypeDecl) listType;
                processSimpleTypeContents(document, listDomNode, simpleTypeDeclOfList, simpleTypeDeclOfList.getName());
            }
        }

    } // addListDeclToSimpleType


    /*
     * Add xs:union as child of xs:simpleType.
     */
    private void addUnionDeclToSimpleType(Document document, Element simpleTypeDomNode, XSObjectList unionMemberTypes) {        

        Element unionDomNode = document.createElementNS(XSD_LANGUAGE_URI, XSD_LANGUAGE_PREFIX + SchemaSymbols.ATTVAL_UNION);
        simpleTypeDomNode.appendChild(unionDomNode);

        String memberTypesStr = "";
        for (int unionTypeListIdx = 0; unionTypeListIdx < unionMemberTypes.getLength(); unionTypeListIdx++) {
            XSSimpleTypeDecl memberType = (XSSimpleTypeDecl) unionMemberTypes.item(unionTypeListIdx);
            if (XMLConstants.W3C_XML_SCHEMA_NS_URI.equals(memberType.getNamespace())) {
                memberTypesStr = memberTypesStr + " " + XSD_LANGUAGE_PREFIX + memberType.getName();   
            }
            else {
                if (memberType.getName() != null) {
                    memberTypesStr = memberTypesStr + " " + memberType.getName();
                }
                else {
                    // add xs:simpleType as child of, xs:union
                    XSSimpleTypeDecl simpleTypeDeclOfUnion = (XSSimpleTypeDecl) memberType;
                    processSimpleTypeContents(document, unionDomNode, simpleTypeDeclOfUnion, simpleTypeDeclOfUnion.getName());
                }
            }          
        }

        if (!memberTypesStr.equals("")) {
            // discard a blank space character, at the beginning
            memberTypesStr = memberTypesStr.substring(1);
            unionDomNode.setAttributeNS(null, SchemaSymbols.ATT_MEMBERTYPES, memberTypesStr);   
        }

    } // addUnionDeclToSimpleType


    /*
     * Add annotation to a schema component.
     */
    private void addAnnotationToSchemaComponent(Document document, Element parentDomNode, XSAnnotationImpl annotation) throws DOMException {

        String annotString = annotation.getAnnotationString();
        StringReader annotationReader = new StringReader(annotString);
        InputSource annotationInputSrc = new InputSource(annotationReader);
        DocumentBuilderFactory annotationDbf = DocumentBuilderFactory.newInstance();
        Element annotationElement = null;
        try {
            DocumentBuilder annotationDb = annotationDbf.newDocumentBuilder();
            Document annotationDom = annotationDb.parse(annotationInputSrc);
            annotationElement = (Element) document.importNode(annotationDom.getDocumentElement(), true);
        }
        catch(Exception ex) {
            ex.printStackTrace();   
        }

        parentDomNode.appendChild(annotationElement);

    } // addAnnotationToSchemaComponent


    /*
     * Get name of a facet given it's kind.
     */
    private String getFacetName(short facetKind) {      

        if (facetKind == XSSimpleTypeDefinition.FACET_MINEXCLUSIVE) {
            return SchemaSymbols.ELT_MINEXCLUSIVE;
        }
        else if (facetKind == XSSimpleTypeDefinition.FACET_MININCLUSIVE) {
            return SchemaSymbols.ELT_MININCLUSIVE;  
        }
        else if (facetKind == XSSimpleTypeDefinition.FACET_MAXEXCLUSIVE) {
            return SchemaSymbols.ELT_MAXEXCLUSIVE;  
        }
        else if (facetKind == XSSimpleTypeDefinition.FACET_MAXINCLUSIVE) {
            return SchemaSymbols.ELT_MAXINCLUSIVE;  
        }
        else if (facetKind == XSSimpleTypeDefinition.FACET_TOTALDIGITS) {
            return SchemaSymbols.ELT_TOTALDIGITS;  
        }
        else if (facetKind == XSSimpleTypeDefinition.FACET_FRACTIONDIGITS) {
            return SchemaSymbols.ELT_FRACTIONDIGITS;  
        }
        else if (facetKind == XSSimpleTypeDefinition.FACET_LENGTH) {
            return SchemaSymbols.ELT_LENGTH;  
        }
        else if (facetKind == XSSimpleTypeDefinition.FACET_MINLENGTH) {
            return SchemaSymbols.ELT_MINLENGTH;  
        }
        else if (facetKind == XSSimpleTypeDefinition.FACET_MAXLENGTH) {
            return SchemaSymbols.ELT_MAXLENGTH;  
        }
        else if (facetKind == XSSimpleTypeDefinition.FACET_WHITESPACE) {
            return SchemaSymbols.ELT_WHITESPACE;  
        }

        // unreach
        return null;

    } // getFacetName 


    /*
     * Given an XSD particle, get it's minOccurs value as a String.
     */
    private String getMinOccursVal(XSParticle particle) {
        String minOccursStr = null;
        int minOccurs = particle.getMinOccurs();        
        if (minOccurs != 1) {
            minOccursStr = String.valueOf(minOccurs);   
        } 
        return minOccursStr;
    } // getMinOccursVal


    /*
     * Given an XSD particle, get it's maxOccurs value as a String.
     */
    private String getMaxOccursVal(XSParticle particle) {        
        String maxOccursStr = null;         
        if (particle.getMaxOccursUnbounded()) {
            maxOccursStr = SchemaSymbols.ATTVAL_UNBOUNDED;  
        }
        else {
            int maxOccurs = particle.getMaxOccurs();
            if (maxOccurs != 1) {
                maxOccursStr = String.valueOf(maxOccurs);  
            }
        }        
        return maxOccursStr;        
    } // getMaxOccursVal 
    
} // class XSSerializer
