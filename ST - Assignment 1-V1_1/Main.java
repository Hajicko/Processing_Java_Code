
/**
 * Write a description of class Main here.
 *
 * @author (Joshua Astron, u3242675)
 * @version (V1, 16 Mar 2023)
 */
public class Main
{
    public static void main(String args[])
    {
        GUI mainWin = new GUI();
        
        do
        {
            mainWin.run();
        } while(!mainWin.getExitStatus() );
    }
}
