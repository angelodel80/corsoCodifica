import java.io.File;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

public class GlobalParameters
{
  public static void parseAndProcess(String sourceID, 
                                     String xslID,
                                     String outputID)
  {
    try
    {
      TransformerFactory tfactory = TransformerFactory.newInstance();
      
      Transformer transformer 
        = tfactory.newTransformer(new StreamSource(xslID));

      // Use the setParameter method to set global parameters
      transformer.setParameter("startX", new Integer(50));
      transformer.setParameter("baseColor", "magenta");
      
      transformer.transform(new StreamSource(sourceID),
                            new StreamResult(outputID));
    }
    catch (TransformerConfigurationException tce)
    {
      System.err.println("Exception: " + tce);
    }
    catch (TransformerException te)
    {
      System.err.println("Exception: " + te);
    }
  }
  
  public static void main(String argv[])
    throws java.io.IOException, 
           org.xml.sax.SAXException
  {
    GlobalParameters gp = new GlobalParameters();
    gp.parseAndProcess(argv[0], argv[1], argv[2]);
  }
}
