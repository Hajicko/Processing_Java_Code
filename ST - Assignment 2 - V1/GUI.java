import java.io.File;
import java.io.FileReader;
import java.util.Hashtable;
import java.util.Scanner;

/**
 * Write a description of class Main here.
 *
 * @author (Joshua Astron)
 * @version (V1, 13 Apr 2023)
 */
public class GUI {
    private boolean exitStatus;
    
    Interpreter SAIL2023 = new Interpreter();
    
    final String dir = new File("").getAbsolutePath() +"/Files/";
    final String fileNames[][] = {
        {"ConsoleMenuWord.txt"}, 
        {"Task1a", "Task1b", "Task1c", "Task1d", "Task1Ma", "Task1Mb", "Task1Mc"}, 
        {"Task2a", "Task2b", "Task2Ma"}, 
        {"Task3a", "Task3b", "Task3Ma", "Task3Mb", "Task3Mc", "Task3Md"}, 
        {"Task4a", "Task4b", "Task4c", "Task4Ma", "Task4Mb"}, 
        {"Task5a", "Task5Ma", "Task5Mb"}
    };
    private String consoleMenuLines[][] = null;
    private String ALLOWED_INPUTS[] = null;
    private final int COLUMN_SPACING[] = {4, 25, 20};
    
    Scanner scannerReader;
    
    private String userInput;
    private String currFileName;
    
    /**
     * Constructor for objects of class GUI
     */
    public GUI()
    {
        // Clear the console.
        System.out.print("\f");
        
        // initialise instance variables
        exitStatus = false;
        currFileName = null;
        
        scannerReader = new Scanner(System.in);
        consoleMenuLines = loadConsoleMenu();
        
        // Gets all the command words from the consolemenu
        ALLOWED_INPUTS = new String[consoleMenuLines.length -1];
        for (int lp1 = 1; lp1 < consoleMenuLines.length; lp1++)
        {
            ALLOWED_INPUTS[lp1 -1] = consoleMenuLines[lp1][0];
        }
    }
    
    private String[][] loadConsoleMenu()
    {
        String fileRawLines[] = SAIL2023.loadFile(dir +fileNames[0][0]);
        
        String outputLines[][] = new String[fileRawLines.length][3];
        
        // Loads in all the menu lines from the txt file.
        for (int lp1 = 0; lp1 < fileRawLines.length; lp1++)
        {
            if (SAIL2023.CharacterCheck(fileRawLines[lp1], ',') != 0)
            {
                String tempArr[] = SAIL2023.SplitByChar(fileRawLines[lp1], ',', '\\');
                for (int lp2 = 0; lp2 < tempArr.length; lp2++)
                    if (lp2 < 3)
                        outputLines[lp1][lp2] = tempArr[lp2];
                    else
                        lp2 = tempArr.length;
            } else
                outputLines[lp1][0] = fileRawLines[lp1];
        }
        
        return outputLines;
    }
    
    private void consoleGUI()
    {
        // Prints out all the consolemenuword.txt lines. To set up the menu.
        for (int lp1 = 0; lp1 < consoleMenuLines.length; lp1++)
        {
            if (consoleMenuLines[lp1][1] == null)
            {
                if (lp1 == 0)
                {
                    printFormatted("", COLUMN_SPACING[0], ' ');
                    System.out.print(consoleMenuLines[lp1][0]);
                } else
                {
                    if (lp1 == consoleMenuLines.length -1)
                        System.out.println();
                    System.out.print(consoleMenuLines[lp1][0]);
                }
            } else
            {
                for (int lp2 = 0; lp2 < consoleMenuLines[0].length; lp2++)
                    printFormatted(consoleMenuLines[lp1][lp2], COLUMN_SPACING[lp2], ' ');
            }
            System.out.println();
            
        }
    }

    public void run()
    {
        System.out.println();
        consoleGUI();
        userInput = "" +getStrInput("Select Option: \n>> ", ALLOWED_INPUTS, 2);
        
        checkUserSel(userInput);
        
    }
    
    private String getStrInput(String userPrompt, String allowedInputStrs[], int allowedStrLength)
    {
        String userInputStr = ""; // (char)(0);
        
        try
        {
            boolean acceptedInput = false;
            
            // Do until you get the input you want.
            do
            {
                System.out.print(userPrompt);
                userInputStr = scannerReader.nextLine().trim();
                if (userInputStr.length() <= allowedStrLength || allowedStrLength == -1) // -1 means infinite
                {
                    // This is to check if the user cares about the set input types.
                    if (allowedInputStrs == null)
                        acceptedInput = true;
                    else
                    {
                        // Checks to make sure that the input is in the correct char range.
                        for (String allowedInputStr : allowedInputStrs)
                            if (userInputStr.toLowerCase().equals(allowedInputStr))
                                acceptedInput = true;
                    }

                    if (!acceptedInput)
                        System.out.printf("The characters you have entered '%s' isn't one of the options listed above, please try again.%n", userInputStr);

                }
                else
                    System.out.printf("Your input '%s' is too long, a valid input is only %d characters in length, please try again.%n", userInputStr, allowedStrLength);

                
            } while(!acceptedInput);
        }
        catch (Exception ex1)
        {
            System.out.println("Something has gone wrong here, '" +ex1 +"'.");
        }
        
        return userInputStr;
    }
    
    private char getCharInput(String userPrompt, String allowedInputChars)
    {
        String userInputStr = ""; // (char)(0);
        
        try
        {
            boolean acceptedInput = false;
            
            // Do until you get the input you want.
            do
            {
                System.out.print(userPrompt);
                userInputStr = scannerReader.nextLine().trim();
                if (userInputStr.length() == 1)
                {
                    // Checks to make sure that the input is in the correct char range.
                    for (int lp1 = 0; lp1 < allowedInputChars.length(); lp1++)
                        if (userInputStr.toLowerCase().charAt(0) == allowedInputChars.charAt(lp1))
                            acceptedInput = true;

                    if (!acceptedInput)
                        System.out.printf("The character you have entered '%c' isn't one of the options listed above, please try again.%nSelect Option:%n", userInputStr.charAt(0));

                }
                else
                    System.out.printf("Your input '%s' is too long, a valid input is only 1 character in length like 'E', please try again.%nSelect Option:%n", userInputStr);

                
            } while(!acceptedInput);
        }
        catch (Exception ex1)
        {
            System.out.println("Something has gone wrong here, '" +ex1 +"'.");
        }
        
        return userInputStr.charAt(0);
    }
    
    public void checkUserSel(String inUserInput)
    {
        switch (inUserInput.toLowerCase()) {
        // Exit /Quit the program
            case "q":
                printTitleBox("Option Q", 30);
                exitStatus = true;
                System.out.println("\n" +StrFormatted("", 62, '_'));
                break;
        // Who Am I (Task 1)
            case "w":
                printTitleBox("Option W", 30);
                System.out.printf("The creator of this program is Joshua Astron.\n");
                System.out.println("\n" +StrFormatted("", 62, '_'));
                break;
        // Read SAIL2023 File  (not actually assessed and is optional)
            case "r":
                printTitleBox("Option R", 30);
                System.out.printf("Isn't needed as the file is reloaded when executed.\n");
                System.out.println("\n" +StrFormatted("", 62, '_'));
                break;
            case "e":
                printTitleBox("Option E", 30);
                if (currFileName == null)
                    System.out.printf("You haven't selected the file yet, please run "
                            + "Option S to select a file before running this.\n");
                else
                    executeCode(currFileName);
                System.out.println("\n" +StrFormatted("", 62, '_'));
                break;
            case "a":
                printTitleBox("Option A", 30);
                int forCnter = 0;
                for (String fileNameArr[] : fileNames)
                {
                    if (forCnter > 0)
                    for (String fileName : fileNameArr)
                        executeCode(fileName);
                    forCnter++;
                }
                System.out.println("\n" +StrFormatted("", 62, '_'));
                break;
            case "s":
                printTitleBox("Option S", 30);
                setFileName();
                System.out.println("\n" +StrFormatted("", 62, '_'));
                break;
            case "d":
                printTitleBox("Option D", 30);
                
                if (currFileName == null)
                    System.out.printf("You haven't selected the file yet, please run "
                            + "Option S to select a file before running this.\n");
                else
                {
                    SAIL2023.debugMode = true;
                    executeCode(currFileName);
                    SAIL2023.debugMode = false;
                }
                System.out.println("\n" +StrFormatted("", 62, '_'));
                break;
            case "t1":
                printTitleBox("Option T1", 30);
                System.out.printf("This has nothing to run due to the tokenizer happening at runtime.\n");
                System.out.println("\n" +StrFormatted("", 62, '_'));
                break;
            case "t2":
                printTitleBox("Option T2", 30);
                System.out.printf("This has nothing to run.\n");
                System.out.println("\n" +StrFormatted("", 62, '_'));
                break;
            case "t3":
                printTitleBox("Option T3", 30);
                SAIL2023 = new Interpreter();
                SAIL2023.addCodeLine("set xx to 3");
                SAIL2023.addCodeLine("set xx to 4");
                SAIL2023.addCodeLine("print 'test it '");
                SAIL2023.addCodeLine("println xx");
                SAIL2023.addCodeLine("end");
                SAIL2023.listCode();
                SAIL2023.runCode();
                System.out.println("\n" +StrFormatted("", 62, '_'));
                break;
            case "t4":
                printTitleBox("Option T4", 30);
                System.out.println(StrFormatted("", 18, '-'));
                System.out.printf("%-10s | %-5s\n%s\n", "Variable", "Value", StrFormatted("", 18, '-'));
                for (String var : SAIL2023.variables.keySet()) {
                    System.out.printf("%-10s | %-5s\n", var, SAIL2023.variables.get(var));
                }
                System.out.println(StrFormatted("", 18, '-'));
                System.out.println("\n" +StrFormatted("", 62, '_'));
                break;
            default:
                printTitleBox("Option Unknown", 30);
                System.out.printf("The input '%s' wasn't found.\n", inUserInput);
                System.out.println("\n" +StrFormatted("", 62, '_'));
                break;
        }
        
    }
    
    public void executeCode(String inFileName)
    {
        String tempStrArr[] = SAIL2023.loadFile(dir +"TestFiles/" +inFileName +".txt");
        if (tempStrArr != null)
        {
            clearStack();
            SAIL2023.saveCodeLines(tempStrArr);
            int numOfNormLines = SAIL2023.ReformatCodeLines();
            
            System.out.printf("Reading code file '%s'\n", inFileName);
            System.out.printf("Number Of Lines Read in is            : %d\n", 
                    tempStrArr.length);
            System.out.printf("Number Of Non Comment Lines Read in is: %d\n", 
                    numOfNormLines);
            printFormatted("", 11, '-');
            System.out.print(" Running code ");
            printFormatted("", 11, '-');
            System.out.println();
            SAIL2023.runCode();
        }
        else
            System.out.printf("\nThe file 'Task1a.txt' wasn't able to load in.\n");
    }
    
    public void clearStack()
    {
        SAIL2023.variables.clear();
    }
    
    
    public void setFileName()
    {
        System.out.printf("Select Option:\n");
        System.out.printf("0  - Enter file name\n");
        
        Hashtable<String, String> allowedInputs = new Hashtable<String, String>();
        allowedInputs.put("0", "Get-Input");
        // Print out all filenames as an option.
        int posCnter = 1;
        for (int arrLp = 1; arrLp < fileNames.length; arrLp++)
            for (int arrLp2 = 0; arrLp2 < fileNames[arrLp].length; arrLp2++)
            {
                System.out.printf("%-2d - %s\n", posCnter, fileNames[arrLp][arrLp2]);
                allowedInputs.put(Integer.toString(posCnter), fileNames[arrLp][arrLp2]);
                posCnter++;
            }
        
        String tempInputArr[] = new String[allowedInputs.size()];
        posCnter = 0;
        for (String key : allowedInputs.keySet())
            tempInputArr[posCnter++] = key;
        
        // Get the user selection
        String tempUserInput = getStrInput("Select Option:\n", tempInputArr, 2);
        
        switch(tempUserInput)
        {
            case "0" -> {
                boolean getUserInput = true;
                do {
                    // Get the filename from the user
                    tempUserInput = getStrInput("Please input the filename without the file extension:\n>> ", null, -1);
                    if (SAIL2023.findFileLineCount(dir +"TestFiles/" +tempUserInput +".txt") != -1)
                    {
                        currFileName = tempUserInput;
                        System.out.printf("Exiting set file name with '%s' as the new selected file name...\n", tempUserInput);
                        getUserInput = false;
                    }
                        // Exit if the user doesn't want to enter a filename
                    else
                    {
                        if (tempUserInput.contains("."))
                            System.out.printf("The filename entered '%s' mustn't have a file extension.\n", tempUserInput);
                        else
                            System.out.printf("The filename entered '%s' wasn't found.\n", tempUserInput);
                            
                        if (getCharInput("\nDo you want to try again? [y : n]: ", "yn") == 'n')
                        {
                            System.out.printf("Exiting set file name...\n");
                            getUserInput = false;
                        }
                    }

                } while (getUserInput);
                
            }
            default -> {
                if (allowedInputs.containsKey(tempUserInput)) {
                    currFileName = allowedInputs.get(tempUserInput);
                    System.out.printf("Exiting set file name with '%s' as the new selected file name...\n", currFileName);
                }
                else 
                    System.out.printf("Error: The input '%s' wasn't found in the set filename section.\n", tempUserInput);
            }
        }
    }
    
    //--------------------------------------------------------------------------
    // Get variable methods.
    
    public boolean getExitStatus()
    {
        return exitStatus;
    }
    
    //--------------------------------------------------------------------------
    // Other functions
    
    private void printFormatted(String inStr, int inLength, char inFillChar)
    {
        for (int lp1 = 0; lp1 < inLength; lp1++)
            if (inStr != null && lp1 < inStr.length())
                System.out.print(inStr.charAt(lp1));
            else
                System.out.print(inFillChar);
    }
    
    private String StrFormatted(String inStr, int inLength, char inFillChar)
    {
        String outStr = "";
        for (int lp1 = 0; lp1 < inLength; lp1++)
            if (inStr != null && lp1 < inStr.length())
                outStr += (inStr.charAt(lp1));
            else
                outStr += (inFillChar);
        return outStr;
    }
    
    private void printFormatted(String inStr, int inLength, char inFillChar, 
            char inAlignment)
    {
        if (inAlignment == 'L' || inAlignment == 'l')
            for (int lp1 = 0; lp1 < inLength; lp1++)
                if (inStr != null && lp1 >= inLength -inStr.length() ) 
                    //lp1 < inStr.length())
                    System.out.print(inStr.charAt(lp1 
                            -(inLength -inStr.length()) ));
                else
                    System.out.print(inFillChar);
        else if (inAlignment == 'R' || inAlignment == 'r')
            for (int lp1 = 0; lp1 < inLength; lp1++)
                if (inStr != null && lp1 < inStr.length())
                    System.out.print(inStr.charAt(lp1));
                else
                    System.out.print(inFillChar);
    }
    
    public void printTitleBox(String inTitle, int length)
    {
        int spacing = length -inTitle.length(), spacingHalf = spacing /2;
        if (spacing < 0)
            return;
        
        System.out.println(" " +StrFormatted("", length, '_') +" ");
        System.out.println("|" +StrFormatted("", spacingHalf, ' ')
                +inTitle +StrFormatted("", spacing -spacingHalf, ' ') +"|");
        System.out.print("|" +StrFormatted("", length, '_') +"|");
        System.out.println(StrFormatted("", length, '_'));
    }
}
