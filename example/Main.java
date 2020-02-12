//package example;

//import javax.swing.*; 
//import javax.swing.SwingUtilities;

//import net.Test;
import net.sf.jodreports.cli.CreateDocument;
import java.lang.Byte;

public class Main {

    
    //private static void createAndShowGUI() {
        /*
        //Create and set up the window.
        JFrame frame = new JFrame("HelloWorldSwing");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        //Add the ubiquitous "Hello World" label.
        JLabel label = new JLabel("Hello World");
        frame.getContentPane().add(label);

        //Display the window.
        frame.pack();
        frame.setVisible(true);
        */
    //}
    

    public static void main(String args[]) {

        byte b = 10;
        Byte b2 = new Byte(b);

        System.out.println("Hello, Stripe 2");
        System.out.println(b2);

 /*
        javax.swing.SwingUtilities.invokeLater(new Runnable() {
            public void run() {
                createAndShowGUI();
            }
        });
*/

        String[] jod_args = new String[] {"test.odt",  "test.xml", "out.odt"};
        try{
            CreateDocument.main( jod_args );
        } catch(Exception e){
            return;            // Always must return something
        }
        //Test.main();

        
    }

}