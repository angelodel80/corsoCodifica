function App() {
    console.log('funziona');
    this.run = function(){
        console.log('run');
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


