/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
 

/**
 * Write a description of class Main here.
 *
 * @author (Joshua Astron)
 * @version (V1, 13 Apr 2023)
 */
public class Main {
    public static void main(String args[])
    {
        
        System.out.printf("Program starting...%n");
        
        
        GUI mainWin = new GUI();
        
        do
        {
            mainWin.run();
            
            // Used for unit testing
            // This is for debugging
//            mainWin.checkUserSel("d");
//            mainWin.checkUserSel("e");
//            for (String LpFileName : testFileArr)
//            {
//                System.out.println(LpFileName);
//                mainWin.executeCode(LpFileName);
//                mainWin.clearStack();
//            }
//            mainWin.checkUserSel("s");
//            mainWin.checkUserSel("e");
//            System.out.println();
//            mainWin.checkUserSel("t4");
//            mainWin.checkUserSel("q");
        } while(!mainWin.getExitStatus() );
        
        System.out.printf("Program exited...%n");
    }
}
