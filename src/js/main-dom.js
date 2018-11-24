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


    this.createDocument = function(){
        document.implementation.createDocument(namespaceURI, qualifiedName, doctype);
    }

    
}

