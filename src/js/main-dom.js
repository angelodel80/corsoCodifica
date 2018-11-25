function App() {
    console.log('funziona');
    this.run = function(){
        console.log('run');
        //var node = new Node();
    };
    this.write = function (){
        document.writeln('è attivo il modulo DOM per l\'XML? ', this.test_xml());
        document.writeln('<br />');
        document.writeln('è attivo il modulo Core 2.0? ', this.test_core2());
        document.writeln('<br />');
        document.writeln('è attivo il modulo Core 3.0? ', this.test_core3());
        document.writeln('<br />');
    };

    this.test_xml = function () {
        var supportsDOM2XML = document.implementation.hasFeature('XML', 2.0);
        console.log('XML 2.0', supportsDOM2XML);
        return supportsDOM2XML?'SI':'NO';
    }

    this.test_core2 = function () {
        var supportsDOM2Core = document.implementation.hasFeature('Core', 2.0);
        console.log('Core 2.0', supportsDOM2Core);
        return supportsDOM2Core?'SI':'NO';
    }

    this.test_core3 = function () {
        var supportsDOM3Core = document.implementation.hasFeature('Core', 3.0);
        console.log('Core 3.0', supportsDOM3Core);
        return supportsDOM3Core?'SI':'NO';
    }

    
}


function NodeApp() {
    this.nodetypes = function(){
       
        Node.ELEMENT_NODE;                  // 1
        Node.ATTRIBUTE_NODE;                // 2
        Node.TEXT_NODE;                     // 3
        Node.CDATA_SECTION_NODE;            // 4
        Node.ENTITY_REFERENCE_NODE;         // 5
        Node.ENTITY_NODE;                   // 6
        Node.PROCESSING_INSTRUCTION_NODE    // 7
        Node.COMMENT_NODE;                  // 8
        Node.DOCUMENT_NODE;                 // 9
        Node.DOCUMENT_TYPE_NODE;            // 10
        Node.DOCUMENT_FRAGMENT_NODE;        // 11
        Node.NOTATION_NODE;                 // 12

    }

    this.createNode = function(){
        var mynode = document.getRootNode();
        console.log('node type', mynode.nodeType);
    }

    this.getNodeList = function(){
        var nodelist = document.documentElement.childNodes;
        console.log('nodelist',nodelist);
        console.log('figlio', nodelist[2]);
        var child = nodelist.item(0);
        console.log('child', child);

        var myDiv = document.getElementById("n1");
        console.log('DIV', myDiv);

        var myDivList = document.getElementsByTagName('div');
        console.log('div list', myDivList);

        console.log('tagName == nodeName: ', myDiv.tagName == myDiv.nodeName);

        var lang = myDiv.getAttribute('lang');
        console.log('lang: ', lang);

        var textNode = myDiv.firstChild;
        var text = textNode.nodeValue;
        console.log('text', text);

        var newTextNode = document.createTextNode(' testo aggiunto');
        myDiv.appendChild(newTextNode);
        console.log('nuovo testo: ', newTextNode);

        myDiv.normalize();

    }

    this.nodeManipulation = function(){
        var node = document.documentElement;

        node.appendChild(newChild);
        node.insertBefore(newChild, refChild);
        node.replaceChild(newChild, oldChild);
        node.removeChild(oldChild);

        node.cloneNode(deep);

        node.normalize();
    }

    
}

function XMLApp(){

    this.createDocument = function(){
        var doctype = document.implementation.createDocumentType('TEI', '', 'tei_all.dtd');
        var xmlDoc =  document.implementation.createDocument('http://www.tei-c.org/ns/1.0', 'tei:TEI', doctype);
        console.log('nuovo doc TEI', xmlDoc);
        console.log('NS doc TEI', xmlDoc.lookupNamespaceURI('tei'));

        

        var teiHeaderElem = xmlDoc.createElement('tei:teiHeader'); 
        xmlDoc.documentElement.appendChild(teiHeaderElem);

        console.log('TEI DOC with teiHeader: ', xmlDoc);
    }

    this.parseDocument = function(){
        var parser = new DOMParser();
       var xmldom = parser.parseFromString("<TEI><teiHeader/></TEI>", "text/xml");
       var textElem = xmldom.createElement("text");
       xmldom.documentElement.appendChild(textElem);
       console.log('TEI DOC PARSED', xmldom);

        var serializer = new XMLSerializer();
        var xmlString = serializer.serializeToString(xmldom);
        console.log('Serializzato DOM-XML', xmlString);

        document.documentElement.appendChild(document.createTextNode(xmlString));

    }

    this.loadXML = function(){
        var path="test.xml";
        var xhr = new XMLHttpRequest();
        xhr.open('get', path, false);
        xhr.send(null);
        var txt = xhr.responseText;
        var teiDoc = xhr.responseXML;
        console.log('XHR textResponse', txt);
        console.log('XHR DOM Response', teiDoc);
    }

    this.xpath = function(){
        var supportsXPath = document.implementation.hasFeature('XPath', 3.0);
        console.log('xpath support? ', supportsXPath);
        var evaluator = new XPathEvaluator();
        console.log('XPATH evaluator', evaluator);

        var path="test.xml";
        var xhr = new XMLHttpRequest();
        xhr.open('get', path, false);
        xhr.send(null);
        
        var teiDoc = xhr.responseXML;
        console.log('XHR DOM Response', teiDoc);

        var result = evaluator.evaluate('TEI/teiHeader/fileDesc/titleStmt/title', teiDoc, null, XPathResult.STRING_TYPE, null);

        console.log('XPATH result: ', result);

        var ele = document.createElement('div');
        var textNode = document.createTextNode(result.stringValue);
        ele.appendChild(textNode);
        document.documentElement.appendChild(ele);

    }

    this.xpathRes = function(){

        
       XPathResult.ANY_TYPE;
       XPathResult.NUMBER_TYPE;
       XPathResult.STRING_TYPE;
       XPathResult.BOOLEAN_TYPE;
       XPathResult.UNORDERED_NODE_ITERATOR_TYPE;
       XPathResult.ORDERED_NODE_ITERATOR_TYPE;
       XPathResult.UNORDERED_NODE_SNAPSHOT_TYPE;
       XPathResult.ORDERED_NODE_SNAPSHOT_TYPE;
       XPathResult.ANY_UNORDERED_NODE_TYPE;
       XPathResult.FIRST_ORDERED_NODE_TYPE;

    }

    this.xsltprocess = function(){
        var processor = new XSLTProcessor();

        
    }

}

