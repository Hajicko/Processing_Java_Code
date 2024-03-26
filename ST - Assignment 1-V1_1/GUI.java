
import java.time.LocalTime; // import the LocalTime class
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.*;
import java.lang.Math;
import java.text.SimpleDateFormat;

/**
 * This class holds all of the methods and variables to maintain a console GUI.
 *
 * @author (Joshua Astron, u3242675)
 * @version (V1, 16 Mar 2023)
 */
public class GUI
{
    // instance variables - replace the example below with your own
    private boolean exitStatus = false;
    
    File file;
    FileReader fileReader;
    Scanner scannerReader;    
    
    final String dir = new File("").getAbsolutePath() +"/Files/";
    final String[] fileNames = {"ConsoleMenuWord.txt"};
    
    boolean correctFileTypeInput = false;
    String fileTypeInput = "";
    private FileManager fileManager1;
    
    private DataManager dataManager1;
    private String consoleMenuLines[][];
    private String userInput;
    private ArrayList<ArrayList<String>> loadedInData;
    private String flatsFileData[][];
    private String metersFileData[][];
    
    private final int COLUMN_SPACING[] = {4, 40, 10};
    private final String ALLOWED_INPUTS = "EFMCASO50123";
    private final Double ELECTRICITY_RATE = 0.205;// The electricity rate is 0.205 $/Kwh (20.5 cents a kwh)

    /**
     * Constructor for objects of class GUI
     */
    public GUI()
    {
        // Clear the console.
        System.out.print("\f");
        
        // initialise instance variables
        exitStatus = false;
        
        fileManager1 = new FileManager();
        dataManager1 = new DataManager();
        
        loadedInData = new ArrayList<ArrayList<String>>();
        // Make sure to use FileReader instead of file due to you needing to load in multiple
        // files.
        // try {
            // fileReader = new FileReader(dir +fileNames[0]);
        // } catch (FileNotFoundException ex1)
        // {
            // System.out.println("File \"" +fileNames[0] +"\" not found.");
        // }
        scannerReader = new Scanner(System.in);
        
        consoleMenuLines = loadConsoleMenu();
        
        // System.out.printf("Cat  == Arm returns %d%n", NumericalChk("Cat", "Arm") ); // Testing
        // System.out.printf("Cat  == Army returns %d%n", NumericalChk("Cat", "Army") ); // Testing
        // System.out.printf("Army == Cat returns %d%n", NumericalChk("Army", "Cat") ); // Testing
        // System.out.printf("Dog  == Zebra returns %d%n", NumericalChk("Dog", "Zebra") ); // Testing
        // System.out.printf("m111  == Zebra returns %d%n", NumericalChk("m111", "Zebra") ); // Testing
        // System.out.printf("Zebra  == m111 returns %d%n", NumericalChk("Zebra", "m111") ); // Testing
        // System.out.printf("m333 == m111 returns %d%n", NumericalChk("m333", "m111") ); // Testing
        // System.out.printf("m111 == m333 returns %d%n", NumericalChk("m111", "m333") ); // Testing
        // System.out.printf("1 == 3 returns %d%n", NumericalChk("1", "3") ); // Testing
        // System.out.printf("3 == 1 returns %d%n", NumericalChk("3", "1") ); // Testing
        // System.out.printf("11 == 33 returns %d%n", NumericalChk("11", "33") ); // Testing
        // System.out.printf("33 == 11 returns %d%n", NumericalChk("33", "11") ); // Testing
    }

    public void run()
    {
        //consoleGUI();
        //userInput = getUserInput(ALLOWED_INPUTS);
        if (userInput == "F")
            userInput = "m"; //m
        else if (userInput == "m")
            userInput = "a"; // e
        // else if (userInput == "m")
            // userInput = "c"; // e
        // else if (userInput == "c")
        else if (userInput == "a")
            userInput = "S";
        else if (userInput == "S")
            userInput = "P";
        else if (userInput == "P")
            userInput = "O";
        else if (userInput == "O")
            userInput = "5";
        else if (userInput == "5")
            userInput = "e";
        else if (userInput == null || userInput == "")
            userInput = "F";
        
        consoleGUI(); // Only for testing
        
        
        
             if (userInput.toUpperCase().charAt(0) == 'E')
            exitStatus = true;
        else if (userInput.toUpperCase().charAt(0) == 'F')
            ReadFlats("Dev1_Flat"); // prod_Flat test_Flat Dev1_Flat
        else if (userInput.toUpperCase().charAt(0) == 'M')
            ReadMeters("Dev1_Meter"); // prod_Meter test_Meter Dev1_Meter
        else if (userInput.toUpperCase().charAt(0) == 'C')
            ComputeBCBillForOneFlat(true);
        else if (userInput.toUpperCase().charAt(0) == 'A')
            ComputeBCBillForAllFlats();
        else if (userInput.toUpperCase().charAt(0) == 'S')
            SortProblem();
        else if (userInput.toUpperCase().charAt(0) == 'P')
            ProveMeterFileSortAndFind();
        else if (userInput.toUpperCase().charAt(0) == 'O')
        {
            // Check that the data files have been loaded before printing to the console that the function is running.
            if (flatsFileData != null && metersFileData != null)
                System.out.printf("Compute adjusted bill for one Block of flats.%n");
            SearchAndComputationProblem(ComputeBCBillForOneFlat(false), true);
        }
        else if (userInput.toUpperCase().charAt(0) == '5')
            ComputeBillsAndSummariseAllFlats();
            
    }
    
    private void consoleGUI()
    {
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
        
    // private String getUserInput(String inAllowedInputs, String[] ErrorText, int inputAllowedLength) {
        // String userInputStr = null;
        // boolean correctFileTypeInput = false;
        // do
        // {
            // userInputStr = "";
            // userInputStr = scannerReader.nextLine().trim();
            // if (inputAllowedLength == -1 || userInputStr.length() <= inputAllowedLength) // -1 for inputAllowedLength turns off the length requirement.
            // {
                // correctFileTypeInput = true;
                // if (inAllowedInputs != "")
                    // for (int lp1 = 0; lp1 < userInputStr.length(); lp1++)
                    // {
                        // if (userInputStr != null && userInputStr != "")
                            // for (int lp2 = 0; lp2 < inAllowedInputs.length(); lp2++)
                                // if (userInputStr.toUpperCase().charAt(lp1) != inAllowedInputs.charAt(lp2))
                                    // correctFileTypeInput = false;
                    // }
                
                // if (ErrorText.length > 1 && !correctFileTypeInput)
                    // System.out.printf(ErrorText[1]);
                // else
                    // System.out.printf("The input you have entered '%s' is an invalid input, please try again.%n", userInputStr);

            // }
            // else
                // if (ErrorText.length > 0)
                    // System.out.printf(ErrorText[0]);
                // else
                    // System.out.printf("Your input '%s' is too long, please try again.%n", userInputStr);
        // } while (!correctFileTypeInput);
        
        // return userInputStr;
    // }
    
    private String[][] loadConsoleMenu()
    {
        String fileRawLines[] = fileManager1.loadFile(dir +fileNames[0]);
        
        String outputLines[][] = new String[fileRawLines.length][3];
        
        for (int lp1 = 0; lp1 < fileRawLines.length; lp1++)
        {
            // System.out.printf("%nNew line: %n");
            if (dataManager1.CharacterCheck(fileRawLines[lp1], ',') != 0)
            {
                String tempArr[] = dataManager1.SplitByChar(fileRawLines[lp1], ',', '\\');
                // System.out.printf("The length of the array %d.%n", tempArr.length); // Testing
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
    
    //-----------------------------------------------------------------------------------------
    // GUI Functions
    
    private void ReadFlats(String inDataFileName)
    {
        String tempFlatsRawDataArr[]  = fileManager1.loadFile(dir +"Data_Files/" +inDataFileName +".txt");
        if ((tempFlatsRawDataArr != null) && (tempFlatsRawDataArr.length > 0) )
        {
            flatsFileData  = new String[tempFlatsRawDataArr.length][];
            System.out.println("Reading flat file Data_Files\\" +inDataFileName +".txt");//test_Flat //prod_Flat
            // Split the flats lines
            for (int lp1 = 0; lp1 < flatsFileData.length; lp1++)
            {
                // Check to see if the end of the raw meters string has a comma, and if so then remove it.
                if (tempFlatsRawDataArr[lp1].length() > 1 && tempFlatsRawDataArr[lp1].charAt(tempFlatsRawDataArr[lp1].length() -1) == ',')
                        tempFlatsRawDataArr[lp1] = tempFlatsRawDataArr[lp1].substring(0, tempFlatsRawDataArr[lp1].length() -1);
                
                flatsFileData[lp1] = dataManager1.SplitByChar(tempFlatsRawDataArr[lp1], ',');
            }
            
            //flatsFileData = dataManager1.CustomSort1(flatsFileData, 4, 0); // This has to be done later on.
            
            int numOfFlats = 0, numOfMeters = 0, sumOfFlatsCurrentReadings = 0;
            for (int lp1 = 0; lp1 < flatsFileData.length; lp1++)
            {
                for (int lp2 = 0; lp2 < flatsFileData[lp1].length; lp2++)
                {
                     if (lp2 >= 7)
                         numOfMeters++;
                     
                    printFormatted(flatsFileData[lp1][lp2], 8, ' '); System.out.print(" ");
                }
                System.out.println();
                
                numOfFlats++;
                sumOfFlatsCurrentReadings += Integer.parseInt(flatsFileData[lp1][3]);
            }
            
            System.out.printf("Number of Flats  Read in is: %s%n", numOfFlats);
            System.out.printf("Number of Meters Read in is: %s%n", numOfMeters); // 16738395
            System.out.printf("Total sum (checksum) of all current meters readings is: %.7fE7%n", (double)(sumOfFlatsCurrentReadings /Math.pow(10, 7)) );
            System.out.printf("Total sum (checksum) of all current flats  readings is: %d%n", sumOfFlatsCurrentReadings);
            
        }
    }
    
    private void ReadMeters(String inDataFileName)
    {
        String tempMetersRawDataArr[] = fileManager1.loadFile(dir +"Data_Files/" +inDataFileName +".txt");
        if (tempMetersRawDataArr != null && tempMetersRawDataArr.length > 0)
        {
            metersFileData = new String[tempMetersRawDataArr.length][];
            System.out.println("Reading meter file Data_Files\\" +inDataFileName +".txt");//prod_Meter //test_Meter
            
            // Split the meters lines
            for (int lp1 = 0; lp1 < tempMetersRawDataArr.length; lp1++)
            {
                // Check to see if the end of the raw meters string has a comma, and if so then remove it.
                if (tempMetersRawDataArr[lp1].length() > 1 && tempMetersRawDataArr[lp1].charAt(tempMetersRawDataArr[lp1].length() -1) == ',')
                        tempMetersRawDataArr[lp1] = tempMetersRawDataArr[lp1].substring(0, tempMetersRawDataArr[lp1].length() -2);
                
                metersFileData[lp1] = dataManager1.SplitByChar(tempMetersRawDataArr[lp1], ',');
            }
            
            //metersFileData = dataManager1.CustomSort1(metersFileData, 5, 0); // This has to be done later on.
            
            int numOfMeters = 0, sumOfMetersCurrentReadings = 0;
            for (int lp1 = 0; lp1 < metersFileData.length; lp1++)
            {
                // for (int lp2 = 0; lp2 < metersFileData[lp1].length; lp2++)
                // {
                    // // if (metersFileData)
                    // printFormatted(metersFileData[lp1][lp2], 8, ' '); System.out.print(" ");
                // }
                // System.out.println();
                
                numOfMeters++;
                sumOfMetersCurrentReadings += Integer.parseInt(metersFileData[lp1][5]);
            }
            
            System.out.printf("Number of Meters Read in is: %s%n", numOfMeters);
            System.out.printf("Total sum (checksum) of all current meters readings is: %.7fE7%n", (sumOfMetersCurrentReadings /Math.pow(10, 7)) );
            System.out.printf("Total sum (checksum) of all current meters readings is: %d%n", sumOfMetersCurrentReadings);
        }
    }
    
    private String[] ComputeBCBillForOneFlat(boolean CommentsOn)
    {
        if (flatsFileData != null)
        {
            if (CommentsOn)
                System.out.printf("Compute bill for one Block of flats.%n");
            
            String consoleInput = null;
            boolean continueSearch = true;
            int streetNum = -1;
            String streetName = null;
            String dataPointArr[][];
            String dataPoint1[] = null;
            // Keep getting the users input until a correct address is inputted.
            do
            {
                System.out.printf("Enter street Number: ");
                consoleInput = scannerReader.nextLine().trim();
                System.out.printf("%n");
                if (dataManager1.stringType(consoleInput) == 0)
                    streetNum = Integer.parseInt(consoleInput);
                
                // Check to make sure that the street number has been defined, if not then the input wasn't a number.
                if (streetNum != -1)
                {
                    System.out.printf("Enter street Name  : ");
                    streetName = scannerReader.nextLine().trim();
                    System.out.printf("%n");
                    
                    dataPointArr = dataManager1.findDataPoint(flatsFileData, 0, streetName);
                    if (dataPointArr != null)
                        for (int lp1 = 0; lp1 < dataPointArr.length; lp1++)
                        {
                            //System.out.printf("%n%d> datapoint%s ?= streetNum[%d]", lp1, dataPointArr[lp1][1], streetNum); // Testing
                            if (Integer.parseInt(dataPointArr[lp1][1]) == streetNum)
                                dataPoint1 = dataPointArr[lp1];
                        }
                    else
                    {
                        System.out.printf("Unable to find the address '%s %s', would you like to continue searching? %n[Y : N]: ", streetNum, streetName);
                        consoleInput = scannerReader.nextLine().trim();
                        if (consoleInput.length() > 0 && consoleInput.toUpperCase().charAt(0) == 'N')
                            continueSearch = false;
                        System.out.printf("%n");
                    }
                } 
                else
                {
                    System.out.printf("The input '%s' most be an integer number only, please re-enter the street number.%n", consoleInput);
                }
            } while (continueSearch && dataPoint1 == null);
            // System.out.printf("The character you have entered '%c' isn't one of the options listed above, please try again.%nSelect Option:%n", userInputStr.charAt(0));
            // System.out.printf("Your input '%s' is too long, a valid input is only 1 character in length like 'E', please try again.%nSelect Option:%n", userInputStr);

            if (continueSearch)
            {
                int usage = (Integer.parseInt(dataPoint1[3]) -Integer.parseInt(dataPoint1[5]));
                Double billUsage = usage *ELECTRICITY_RATE;
                
                printFormatted("", 41, '='); System.out.printf("%n");
                System.out.printf("Showing Bill for %d %s%n", streetNum, streetName);
                printFormatted("", 41, '='); System.out.printf("%n");
                printFormatted("Current  meter reading", 22, ' '); System.out.printf(" %s %s%n", dataPoint1[3], dataPoint1[4]);
                printFormatted("Previous meter reading", 22, ' '); System.out.printf(" %s %s%n", dataPoint1[5], dataPoint1[6]);
                printFormatted("Usage", 22, ' '); System.out.printf(" %6d%n", usage);
                printFormatted("Rate", 22, ' '); System.out.printf(" %s %7.3f/kwh%n", "      ", ELECTRICITY_RATE);
                printFormatted("Bill-Usage", 22, ' '); System.out.printf(" %s %6.2f%n", "     $", billUsage);
                if (CommentsOn)
                    printFormatted("", 41, '-'); System.out.printf("%n");
            }
            
            return dataPoint1;
        }
        else // flats date file not loaded in.
        {
            System.out.printf("The flats file hasn't been loaded in. In the Select Options menu select 'f' to load all the data before calling this function.");
            return null;
        }
    }
    
    private void ComputeBCBillForAllFlats()
    {
        if (flatsFileData != null)
        {
            System.out.printf("Compute bill for all Blocks of flats.%n");
            
            Double totalBillUsage = 0.0;
            int recordsProcessed = 0;
            for (int lp1 = 0; lp1 < flatsFileData.length; lp1++)
            {
                totalBillUsage += (Integer.parseInt(flatsFileData[lp1][3]) -Integer.parseInt(flatsFileData[lp1][5])) *ELECTRICITY_RATE;
                recordsProcessed++;
            }
            
            printFormatted("", 33, '='); System.out.printf("%n");
            System.out.printf("Total for All Flats%n");
            printFormatted("", 33, '='); System.out.printf("%n");
            printFormatted("Total", 17, ' '); System.out.printf(": %,14.2f%n", totalBillUsage);
            printFormatted("Records Processed", 17, ' '); System.out.printf(": %14d%n", recordsProcessed);
            printFormatted("", 33, '-'); System.out.printf("%n");
        }
        else // flats date file not loaded in.
        {
            System.out.printf("The flats file hasn't been loaded in. In the Select Options menu select 'f' to load all the data before calling this function.");
        }
    }
    
    private void SortProblem()
    {
        // Make sure that the meters file is loaded in and that there is at least 10 meters loaded in.
        if (metersFileData != null && metersFileData.length > 10)
        {
            printFormatted("", 77, '='); System.out.printf("%n");
            System.out.printf("Before Sort: %n");
            printFormatted("", 77, '='); System.out.printf("%n");
            String tempArr1[];
            Date date1 = new Date();
            SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
            int arrayPos[] = {0, 9, metersFileData.length -1};
            for (int d_lp1 = 0; d_lp1 < 3; d_lp1++)
            {
                try
                {
                    date1 = formatter.parse(metersFileData[d_lp1][6]);
                }
                catch (java.text.ParseException pe)
                {
                    pe.printStackTrace();
                }     
                
                System.out.printf("%s [%2s] %-10s %-10s %-7s %-6s %s%n", (d_lp1 < 2) ? "Check" : "Last ", (d_lp1 < 2) ? Integer.toString(arrayPos[d_lp1]) : "  ", 
                                  metersFileData[arrayPos[d_lp1]][1], metersFileData[arrayPos[d_lp1]][2], 
                                  metersFileData[arrayPos[d_lp1]][4], metersFileData[d_lp1][5], date1);
            }
            printFormatted("", 77, '='); System.out.printf("%n");
            System.out.printf("After Sort: %n");
            printFormatted("", 77, '='); System.out.printf("%n");
            metersFileData = dataManager1.CustomSort1(metersFileData, 4, 0); // This has to be done later on.
            for (int d_lp1 = 0; d_lp1 < 3; d_lp1++)
            {
                // tempArr1 = dataManager1.SplitByChar(metersFileData[arrayPos[d_lp1]][6], '/');
                // date1 = new Date(Integer.parseInt(tempArr1[2]), Integer.parseInt(tempArr1[1]), Integer.parseInt(tempArr1[0]), 0, 0, 0 );
                try
                {
                    date1 = formatter.parse(metersFileData[d_lp1][6]);
                }
                catch (java.text.ParseException pe)
                {
                    pe.printStackTrace();
                }   
                
                System.out.printf("%s [%2s] %-10s %-10s %-7s %-6s %s%n", (d_lp1 < 2) ? "Check" : "Last ", (d_lp1 < 2) ? Integer.toString(arrayPos[d_lp1]) : "  ", 
                                  metersFileData[arrayPos[d_lp1]][1], metersFileData[arrayPos[d_lp1]][2], 
                                  metersFileData[arrayPos[d_lp1]][4], metersFileData[d_lp1][5], date1);
                // %1$tA, %1$tB %1$td %1$tT %1$tz %1$tY
            }
            printFormatted("", 77, '-'); System.out.printf("%n");
        
            for (int lp1 = 0; lp1 < flatsFileData.length; lp1++)
            {
                try
                {
                    date1 = formatter.parse(metersFileData[lp1][6]);
                }
                catch (java.text.ParseException pe)
                {
                    pe.printStackTrace();
                }   
                
                System.out.printf("%s [%4s] %-10s %-10s %-7s %-6s %s%n", (lp1 < flatsFileData.length -1) ? "Check" : "Last ", lp1, 
                                  metersFileData[lp1][1], metersFileData[lp1][2], 
                                  metersFileData[lp1][4], metersFileData[lp1][5], date1);
            }
        }
        else // flats date file not loaded in.
        {
            System.out.printf("The meters file hasn't been loaded in. In the Select Options menu select 'f' to load all the data before calling this function.");
        }
    }
    
    private void ProveMeterFileSortAndFind()
    {
        if (metersFileData != null)
        {
            printFormatted("", 40, '='); System.out.printf("%n");
            System.out.printf("Prove meter file sort and find%n");
            printFormatted("", 40, '='); System.out.printf("%n");
            
            long start, end, diff;
            int searchPosResults[] = new int[1];
            metersFileData = dataManager1.CustomSort1(metersFileData, 4, 0); // This has to be done later on.
            
            start = System.currentTimeMillis();
            for (int lp1 = 0; lp1 < 10000; lp1++)
            {
                searchPosResults[0] = -1;
                searchPosResults[0] = dataManager1.binaryFindDataPoint(metersFileData, 4, "m163987"); // all from test_meter.txt
                if (lp1 == 0 && searchPosResults[0] != -1)
                        System.out.printf("Search 1 result %d: %d%n", 0, searchPosResults[0]);
                searchPosResults[0] = dataManager1.binaryFindDataPoint(metersFileData, 4, "m163966");
                if (lp1 == 0 && searchPosResults[0] != -1)
                    System.out.printf("Search 2 result %d: %d%n", 0, searchPosResults[0]);
                searchPosResults[0] = dataManager1.binaryFindDataPoint(metersFileData, 4, "m163973");
                if (lp1 == 0 && searchPosResults[0] != -1)
                    System.out.printf("Search 3 result %d: %d%n", 0, searchPosResults[0]);
                
            }
            end = System.currentTimeMillis();
            diff = end - start;
            System.out.printf("Find Sequential: %d milliseconds.%n", diff);
            printFormatted("", 40, '-'); System.out.printf("%n");
        
            start = System.currentTimeMillis();
            for (int lp1 = 0; lp1 < 10000; lp1++)
            {
                searchPosResults[0] = -1;
                searchPosResults[0] = dataManager1.binaryFindDataPoint(metersFileData, 4, "m163987"); // all from test_meter.txt
                if (lp1 == 0 && searchPosResults[0] != -1)
                        System.out.printf("Search 1 result %d: %d%n", 0, searchPosResults[0]);
                searchPosResults[0] = dataManager1.binaryFindDataPoint(metersFileData, 4, "m163966");
                if (lp1 == 0 && searchPosResults[0] != -1)
                    System.out.printf("Search 2 result %d: %d%n", 0, searchPosResults[0]);
                searchPosResults[0] = dataManager1.binaryFindDataPoint(metersFileData, 4, "m163973");
                if (lp1 == 0 && searchPosResults[0] != -1)
                    System.out.printf("Search 3 result %d: %d%n", 0, searchPosResults[0]);
                
            }
            end = System.currentTimeMillis();
            diff = end - start;
            System.out.printf("Find Binary    : %d milliseconds.%n", diff);
            printFormatted("", 40, '-'); System.out.printf("%n");
        }
        else // meters data file not loaded in.
        {
            System.out.printf("The meters file hasn't been loaded in. In the Select Options menu select 'f' to load all the data before calling this function.");
        }
    }
        
    private String[] SearchAndComputationProblem(String[] inDataRow, boolean ConsoleOutput)
    {
        if (metersFileData != null && flatsFileData != null)
        {            
            if (inDataRow != null)
            {
                int usage = (Integer.parseInt(inDataRow[3]) -Integer.parseInt(inDataRow[5]));
                Double unitBillUsage = usage *ELECTRICITY_RATE;
                
                String columnNames[] = {"Tenant", "meter", "curr", "prev", "usage", "pcnt%", "$base", "$adj", "$total"};
                // Stores the spacing between each columnName.
                int spacingOfTable[] = {25, 7, 6, 6, 6, 7, 10, 7, 6};
                if (ConsoleOutput)
                {
                    printFormatted("", 90, '='); System.out.printf("%n");
                    for (int t_lp1 = 0; t_lp1 < 9; t_lp1++)
                        System.out.printf("%s ", returnStrFormatted(columnNames[t_lp1], spacingOfTable[t_lp1], ' ', 'L') );
                    System.out.printf("%n");
                    printFormatted("", 90, '='); System.out.printf("%n");
                }
                
                int tenantArrPos = -1, tenantCount = inDataRow.length -7, tenantUsage = -1;
                int baseCost, adjustmentCost, costTotal;
                Double percentUsageOfOverBill = 0d, tenantAdjCostPcnt = 0d, tenantBillFinal = 0d;
                Double tenantBill = 0d, totalBillDiff = 0d, totalTenantBill = 0d;
                // Used to access the right columns of the metersFile string array.
                int accessMetersFilePos[] = {0, 1, 2, 4, 5, 7};
                // System.out.printf("The number of tenants found: %d%n", (dataPoint1.length -7) ); // Testing
                for (int lp1 = 0; lp1 < tenantCount; lp1++)
                {
                    tenantArrPos = dataManager1.binaryFindDataPoint(metersFileData, 4, inDataRow[lp1 +7]);
                    if (tenantArrPos != -1)
                    {
                        tenantUsage = Integer.parseInt(metersFileData[tenantArrPos][accessMetersFilePos[4]]) -Integer.parseInt(metersFileData[tenantArrPos][accessMetersFilePos[5]]);
                        totalTenantBill += tenantUsage *ELECTRICITY_RATE;
                    }
                    else
                    {
                        tenantCount = 0;
                        break;
                    }
                }
                
                // Calculate the bill for the tenants.
                 // totalTenantBill = RoundAvoid(totalTenantBill, 2);
                 // unitBillUsage = RoundAvoid(unitBillUsage, 2);
                totalBillDiff = unitBillUsage -totalTenantBill;
                 tenantAdjCostPcnt = totalBillDiff /totalTenantBill; //RoundAvoid(totalBillDiff /totalTenantBill, 2);
                if (tenantAdjCostPcnt < 0)
                    tenantAdjCostPcnt = 0d;
                
                Double tempAddUpTenantBill = 0d;
                // Print out all the tenants and their information to the console sheet.
                for (int lp1 = 0; lp1 < tenantCount; lp1++) // The -6 is to remove all the flat information length and just return the amount of tenant meters.
                {
                    tenantArrPos = dataManager1.binaryFindDataPoint(metersFileData, 4, inDataRow[lp1 +7]);
                    // System.out.printf("%d: tenantArrPos=%d so the result was %s ", lp1, tenantArrPos, dataPoint1[lp1 +7]); // Testing
                    if (tenantArrPos != -1 && ConsoleOutput)
                    {
                        // System.out.printf("%s ", 
                        // returnStrFormatted((metersFileData[tenantArrPos][0] +" " +metersFileData[tenantArrPos][1] +" "
                                          // +metersFileData[tenantArrPos][2]), spacingOfTable[0], ' ', 'R') );
                        System.out.printf("%s ", returnStrFormatted(metersFileData[tenantArrPos][0], 4, ' ', 'L') );
                        System.out.printf("%s ", returnStrFormatted(metersFileData[tenantArrPos][1], 9, ' ', 'L') );
                        System.out.printf("%s ", returnStrFormatted(metersFileData[tenantArrPos][2], 10, ' ', 'L') );
                        
                        for (int m_lp1 = 3; m_lp1 < 6; m_lp1++)
                            System.out.printf("%s ", returnStrFormatted(metersFileData[tenantArrPos][accessMetersFilePos[m_lp1]], spacingOfTable[m_lp1 -2], ' ', 'L'));
                    }
                    // System.out.printf("%n");
                    /// Calculating the output variables
                    tenantUsage = Integer.parseInt(metersFileData[tenantArrPos][accessMetersFilePos[4]]) -Integer.parseInt(metersFileData[tenantArrPos][accessMetersFilePos[5]]);
                    tenantBill = tenantUsage *ELECTRICITY_RATE;
                    percentUsageOfOverBill = (tenantBill /totalTenantBill) *100d;//((tenantUsage +0d) /usage) *100d;
                    
                    tempAddUpTenantBill = tenantBill;
                    if (tenantAdjCostPcnt != 0)
                        tempAddUpTenantBill = tenantBill +(tenantBill *tenantAdjCostPcnt);
                    
                    tenantBillFinal += tempAddUpTenantBill;
                        
                    if (ConsoleOutput)
                    {
                        System.out.printf("%-5d %6.2f%%", tenantUsage, percentUsageOfOverBill );
                        System.out.printf(" $%-9.2f $%-6.2f $%-5.2f%n", 
                                            tenantBill, tenantBill *(tenantAdjCostPcnt), tempAddUpTenantBill );
                    }
                }
                
                if (ConsoleOutput)
                {
                    // Print out the results of the tenant and the address meter cost with the difference.
                    printFormatted("", 90, '-'); System.out.printf("%n");
                    System.out.printf("Total Tenant bills (metered)%12.2f%n", totalTenantBill);
                    System.out.printf("Total Tenant bills Diff     %12.2f%n", totalBillDiff);
                    System.out.printf("Total Tenant bills Adjusted %12.2f%n", tenantBillFinal); // (tenantAdjCostPcnt == 0)? totalTenantBill : unitBillUsage
                    printFormatted("", 40, '-'); System.out.printf("%n");
                }
                tenantAdjCostPcnt = ((tenantAdjCostPcnt == 0)? 0d : totalBillDiff);
                String outputArr[] = {
                    Double.toString(unitBillUsage), 
                    Double.toString(tenantAdjCostPcnt), 
                    Double.toString(totalBillDiff), 
                    Double.toString(tenantBillFinal)
                };
                return outputArr;
            }
        }
        else if (flatsFileData != null) // flats data file not loaded in.
            System.out.printf("The meters file hasn't been loaded in. In the Select Options menu select 'f' to load all the data before calling this function.");
        else if (metersFileData != null) // meters data file not loaded in.
            System.out.printf("The meters file hasn't been loaded in. In the Select Options menu select 'f' to load all the data before calling this function.");
        
        return null;
    }
    
    private void ComputeBillsAndSummariseAllFlats()
    {
        if (flatsFileData != null)
        {     
            
            printFormatted("", 90, '='); System.out.printf("%n");
            System.out.printf("%-26.26s %16.16s %15.15s %10.10s %15.15s%n", "Flat Address", "BC Bill", "Difference", "DiffAdj", "Tenant Bill");
            printFormatted("", 90, '='); System.out.printf("%n");
            String rowCalcData[] = null;
            Double sumTotalOfAllColumns[] = new Double[4];
            for (int lp0 = 0; lp0 < 4; lp0++)
                sumTotalOfAllColumns[lp0] = 0d;
            for (int lp1 = 0; lp1 < flatsFileData.length; lp1++)
            {
                rowCalcData = SearchAndComputationProblem(flatsFileData[lp1], false);
                
                // Print flat data
                System.out.printf("%5.5s %20.20s", flatsFileData[lp1][1], flatsFileData[lp1][0]);
                if (rowCalcData != null)
                {
                    System.out.printf("%16.2f$ ", Double.parseDouble(rowCalcData[0]));
                    System.out.printf("%12.2f$ ", Double.parseDouble(rowCalcData[1]));
                    System.out.printf("%12.2f$ ", Double.parseDouble(rowCalcData[2]));
                    System.out.printf("%13.2f$ ", Double.parseDouble(rowCalcData[3]));
                    for (int lp2 = 0; lp2 < 4; lp2++)
                        sumTotalOfAllColumns[lp2] += Double.parseDouble(rowCalcData[lp2]);
                }
                System.out.printf("%n");
            }
            printFormatted("", 90, '-'); System.out.printf("%n");
            System.out.printf("%42.2f$ ", sumTotalOfAllColumns[0]);
            System.out.printf("%12.2f$ ", sumTotalOfAllColumns[1]);
            System.out.printf("%12.2f$ ", sumTotalOfAllColumns[2]);
            System.out.printf("%13.2f$%n", sumTotalOfAllColumns[3]);
            printFormatted("", 90, '-'); System.out.printf("%n");
        }
        else if (flatsFileData != null) // flats data file not loaded in.
            System.out.printf("The meters file hasn't been loaded in. In the Select Options menu select 'f' to load all the data before calling this function.");
    }
    
    
    //-----------------------------------------------------------------------------------------
    // Get variable methods.
    
    public boolean getExitStatus()
    {
        return exitStatus;
    }
    
    //-----------------------------------------------------------------------------------------
    // Other custom methods.

    // Used from https://www.baeldung.com/java-round-decimal-number
    public double RoundAvoid(double value, int places) 
    {
        double scale = Math.pow(10, places);
        return Math.round(value * scale) / scale;
    }
    
    private void printFormatted(String inStr, int inLength, char inFillChar)
    {
        for (int lp1 = 0; lp1 < inLength; lp1++)
            if (inStr != null && lp1 < inStr.length())
                System.out.print(inStr.charAt(lp1));
            else
                System.out.print(inFillChar);
    }
    
    private void printFormatted(String inStr, int inLength, char inFillChar, char inAlignment)
    {
        if (inAlignment == 'L' || inAlignment == 'l')
            for (int lp1 = 0; lp1 < inLength; lp1++)
                if (inStr != null && lp1 >= inLength -inStr.length() ) //lp1 < inStr.length())
                    System.out.print(inStr.charAt(lp1 -(inLength -inStr.length()) ));
                else
                    System.out.print(inFillChar);
        else if (inAlignment == 'R' || inAlignment == 'r')
            for (int lp1 = 0; lp1 < inLength; lp1++)
                if (inStr != null && lp1 < inStr.length())
                    System.out.print(inStr.charAt(lp1));
                else
                    System.out.print(inFillChar);
    }
    
    private String returnStrFormatted(String inStr, int inLength, char inFillChar, char inAlignment)
    {
        String outStr = "";
        if (inAlignment == 'R' || inAlignment == 'r')
            for (int lp1 = 0; lp1 < inLength; lp1++)
                if (inStr != null && lp1 >= inLength -inStr.length() ) //lp1 < inStr.length())
                    outStr += inStr.charAt(lp1 -(inLength -inStr.length()) );
                else
                    outStr += inFillChar;
        else if (inAlignment == 'L' || inAlignment == 'l')
            for (int lp1 = 0; lp1 < inLength; lp1++)
                if (inStr != null && lp1 < inStr.length())
                    outStr += inStr.charAt(lp1);
                else
                    outStr += inFillChar;
        return outStr;
    }
}
