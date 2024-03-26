import java.io.FileReader;
import java.io.IOException;
import java.util.Hashtable;
import java.util.Scanner;

/**
 *
 * @author Joshua Astron
 */
public class Interpreter {
    
    public Hashtable<String, Integer> variables = new Hashtable<String, Integer>();
    
    public String codeLines[] = null;
    
    boolean runProgram = false;
    String errorMessage = null;
    boolean debugMode = false;
    
    String silentWaitWord = null;
    // This keeps track of if the while loop is in loop mode or just silently skipping.
    int silentState = -1;
    int silentJumpBackPos = -1;
    
    public String[] loadFile(String inFileDirectory)
    {
        Scanner inFile;
        FileReader fileReader1;
        String fileRawLines[];
        int fileLength = findFileLineCount(inFileDirectory);
        // Check to see if their was an error in finding the file line count, 
        // and if so then return null because it will cause an error later on in the code.
        if (fileLength == -1)
            return null;
        
        // System.out.printf("File length = %d%n", fileLength); // for testing
        fileRawLines = new String[fileLength];
        int whileLpCounter = 0;
        // Read the lines from the file.
        try
        {
            fileReader1 = new FileReader(inFileDirectory);
            inFile = new Scanner (fileReader1);

            String tempStr = "";
            while (inFile.hasNextLine())
            {
                tempStr = inFile.nextLine();
                fileRawLines[whileLpCounter++] = tempStr;
//                // Check to make sure that the file line has content and that the skip line character isn't there.
//                if (tempStr.length() != 0 && tempStr.charAt(0) != '/')
//                    fileRawLines[whileLpCounter++] = tempStr;
                
                // System.out.printf("tempStr: %s%n", tempStr); // Testing
            }
            
            inFile.close();
        }
        catch (IOException ex1)
        {
            System.out.println("File IO Error - File not found:"+inFileDirectory);
            return null;
        }
        
        return fileRawLines;
    }
    
    public int findFileLineCount(String inFileDirectory)
    {
        Scanner inFile;
        FileReader fileReader1;
        String fileRawLines[];
        int fileLength = 0;

        // Find the amount of lines in the file.
        try
        {
            fileReader1 = new FileReader(inFileDirectory);
            inFile = new Scanner (fileReader1);  
            String tempStr = "";
            while (inFile.hasNextLine()) {
                tempStr = inFile.nextLine();
                fileLength++;
//                // Check to make sure that the file line has content and that the skip line character isn't there.
//                if (tempStr.length() != 0 && tempStr.charAt(0) != '/')
//                    fileLength++;
            }
            inFile.close();
        }
        catch (IOException ex1)
        {
            System.out.println("File IO Error - File not found: '"+inFileDirectory +"'");
            return -1;
        }
        return fileLength;
    }
    
    public void runCode()
    {
        runProgram = true;
        errorMessage = null;
        silentWaitWord = null;
        silentJumpBackPos = -1;
        String tempSplitStr;
        silentState = -1;
        
        // Removes all tab lines
        for (int preLp = 0; preLp < codeLines.length; preLp++)
            codeLines[preLp] = codeLines[preLp].replace("\t", "");
        
        int lp1 = 0;
        do
        {
            // Used to print out the code line content.
            if (debugMode)
                System.out.printf("Ex -> %d: %s\n", lp1, codeLines[lp1]);
            
            // Used to check if the current line command word isn't one of the non-use words.
            tempSplitStr = codeLines[lp1].split(" ")[0];
            if ((silentWaitWord == null || silentJumpBackPos > -1)
                    && !tempSplitStr.equals("endif") && !tempSplitStr.equals("endwhile"))
                // Runs a function that checks what statement the line is and run it following it's condition.
                runCodeFunction(codeLines[lp1]);
            
            // Important to run after the runCodeFunction!
            if (silentWaitWord != null)
            {
//                // Used in debug to make sure that the silentWaitWord has been set.
//                if (debugMode)
//                    System.out.println("after $: " +silentWaitWord);
                if (silentWaitWord.equals("endwhile") && silentJumpBackPos == -1
                        && silentState == 1)
                    silentJumpBackPos = lp1;
                
                if (tempSplitStr.equals(silentWaitWord)) {
                    silentWaitWord = null;
                    if (silentJumpBackPos > -1) {
                        lp1 = silentJumpBackPos -1;
                        if (debugMode)
                            System.out.println("endwhile lp: " +lp1);
                        silentJumpBackPos = -1;
                        silentState = -1;
                    }
                }
            }
            
            if (!runProgram)
            {
                if (errorMessage != null)
                System.out.printf("An error on line %d: \"%s\",\nhad an error \"%s\".\n", 
                        lp1 +1, codeLines[lp1], errorMessage);
                
                break;
            }
            lp1++;
        } while(lp1 < codeLines.length);
    }
    
    private void runCodeFunction(String inCodeLine)
    {
        switch(inCodeLine.split(" ")[0].toLowerCase())
        {
            case "set" -> statementSet(inCodeLine);
            case "add" -> statementAddOrSubtract(inCodeLine, '+');
            case "subtract" -> statementAddOrSubtract(inCodeLine, '-');
            case "print" -> statementPrinting(inCodeLine, '\0');
            case "println" -> statementPrinting(inCodeLine, '\n');
            case "multiply" -> statementMultOrDiv(inCodeLine, '*');
            case "divide" -> statementMultOrDiv(inCodeLine, '/');
            case "if" -> statementConitional(inCodeLine, 'i');
            case "while" -> statementConitional(inCodeLine, 'w');
            case "end" -> runProgram = false;
            default -> {
                errorMessage = "Unknown command word '" +inCodeLine.split(" ")[0] +"'";
                runProgram = false;
            }
        }
    }
    
    private void statementSet(String inLine)
    {
        String codeLineTokens[] = inLine.split(" ");
        if (codeLineTokens.length == 4) {
            if (codeLineTokens[2].equals("to")) {
                // Check to see if the variable name exists.
                if (!variables.containsKey(codeLineTokens[1]) )
                    if (isValidVariableName(codeLineTokens[1]))
                        if (stringType(codeLineTokens[3]) == 0)
                        {
                            variables.put(codeLineTokens[1], Integer.parseInt(codeLineTokens[3]));
                            if (debugMode)
                                System.out.println(variables.get(codeLineTokens[1]));
                        }
                        else 
                        {
                            if (variables.containsKey(codeLineTokens[3]) )
                                variables.put(codeLineTokens[1], variables.get(codeLineTokens[3]));
                            else {
                                errorMessage = "The variable '" +codeLineTokens[3] +"' doesn't exist";
                                runProgram = false;
                            }
                        }
                    else {
                        errorMessage = "The variable '" +codeLineTokens[1] +"' didn't follow conventions";
                        runProgram = false;
                    }
                // In the case that no variable was found.
                else {
                    if (isValidVariableName(codeLineTokens[1]))
                        if (stringType(codeLineTokens[3]) == 0)
                        {
                            variables.replace(codeLineTokens[1], Integer.parseInt(codeLineTokens[3]));
                            if (debugMode)
                                System.out.println(variables.get(codeLineTokens[1]));
                        }
                        else 
                        {
                            if (variables.containsKey(codeLineTokens[3]) )
                                variables.replace(codeLineTokens[1], variables.get(codeLineTokens[3]));
                            else {
                                errorMessage = "The variable '" +codeLineTokens[3] +"' doesn't exist";
                                runProgram = false;
                            }
                        }
                    else {
                        errorMessage = "The variable '" +codeLineTokens[1] +"' didn't follow conventions";
                        runProgram = false;
                    }
                }

            } else {
                errorMessage = "Incorrect word '" +codeLineTokens[2] +"' must be 'to'";
                runProgram = false;
            }

        } else {
            errorMessage = "The line '" +inLine +"' "
                    +((codeLineTokens.length < 4) ? "is missing something" : "contains an incorrect word");
            runProgram = false;
        }
    }
    
    private void statementAddOrSubtract(String inLine, char operationType)
    {
        String codeLineTokens[] = inLine.split(" ");
        if (codeLineTokens.length == 4) {
            if ((operationType == '+' && codeLineTokens[2].equals("to")) ||
                (operationType == '-' && codeLineTokens[2].equals("from")) ) {
                // Check to see if the variable name exists.
                if (variables.containsKey(codeLineTokens[3]) )
                    if (stringType(codeLineTokens[1]) == 0)
                        {
                            int varValue = variables.get(codeLineTokens[3]) 
                                    +Integer.parseInt(codeLineTokens[1]) 
                                    *((operationType == '+') ? 1 : -1);
                            variables.put(codeLineTokens[3], varValue);
                            if (debugMode)
                                System.out.println(variables.get(codeLineTokens[3]));
                        }
                    else 
                    {
                        if (variables.containsKey(codeLineTokens[1]) )
                        {
                            int varValue = variables.get(codeLineTokens[3]) 
                                    +variables.get(codeLineTokens[1]) 
                                    *((operationType == '+') ? 1 : -1);
                            variables.put(codeLineTokens[3], varValue);
                            if (debugMode)
                                System.out.println(variables.get(codeLineTokens[3]));
                        }
                        else {
                            errorMessage = "The variable '" +codeLineTokens[1] +"' doesn't exist";
                            runProgram = false;
                        }
                    }
                // In the case that no variable was found.
                else {
                    errorMessage = "The variable '" +codeLineTokens[3] +"' doesn't exists";
                    runProgram = false;
                }

            } else {
                errorMessage = "Incorrect word '" +codeLineTokens[2]
                        +"' must be " +((operationType == '+') ? "'to'" : "'from'");
                runProgram = false;
            }

        } else {
            errorMessage = "The line '" +inLine +"' "
                    +((codeLineTokens.length < 4) ? "is missing something" : "contains an incorrect word");
            runProgram = false;
        }
    }
    
    private void statementPrinting(String inLine, char operationType)
    {
        String codeLineTokens[] = inLine.split(" ");
        if (debugMode)
            operationType = '\n';
//        if (codeLineTokens.length == 2) {
            int strStartPos = inLine.indexOf("'"), 
                strEndPos = inLine.indexOf("'", strStartPos +1);
            if (strStartPos != -1 && strEndPos != -1 && strStartPos != strEndPos) {
                System.out.print(inLine.substring(strStartPos +1, strEndPos) +operationType);
            } 
            else
            {
                // Check if the clear all command was given.
                if (codeLineTokens[1].equals("cls"))
                    System.out.print("\f"); // Clear the screen command.
                // Check if the second string value is an integer.
                else if (stringType(codeLineTokens[1]) == 0)
                    System.out.printf("%s%c", codeLineTokens[1], operationType);
                // Check to see if the variable name exists.
                else if (variables.containsKey(codeLineTokens[1]) )
                    System.out.printf("%d%c", variables.get(codeLineTokens[1]), operationType);
                // In the case that no variable was found.
                else
                {
                    errorMessage = "nonexistent variable to "
                            +((operationType == '\n') ? "println " : "print ")
                            +codeLineTokens[1];
                    runProgram = false;
                }
            }
//        } 
//        else {
//            errorMessage = "The line '" +inLine +"' "
//                    +((codeLineTokens.length < 2) ? "is missing something" : "contains an incorrect word");
//            runProgram = false;
//        }
    }
    
    private void statementMultOrDiv(String inLine, char operationType)
    {
        String codeLineTokens[] = inLine.split(" ");
        // Make sure the amount of tokens are correct to the statement
        if (codeLineTokens.length == 4) {
            // Make sure the correct word is used for the opperator
            if ((operationType == '*' && codeLineTokens[2].equals("by")) ||
                (operationType == '/' && codeLineTokens[2].equals("by")) ) {
                // Check to see if the variable name exists.
                if (variables.containsKey(codeLineTokens[1]) )
                    if (stringType(codeLineTokens[3]) == 0)
                    {
                        int varValue = variables.get(codeLineTokens[1]) 
                                *Integer.parseInt(codeLineTokens[3]);
                        // If in the case that the function is division.
                        if (operationType == '/')
                            varValue = variables.get(codeLineTokens[1]) 
                                /Integer.parseInt(codeLineTokens[3]);
                        variables.put(codeLineTokens[1], varValue);
                        if (debugMode)
                            System.out.println(varValue);
                    }
                    else 
                    {
                        if (variables.containsKey(codeLineTokens[3]) )
                        {
                            int varValue = variables.get(codeLineTokens[1]) 
                                    *variables.get(codeLineTokens[3]);
                            // If in the case that the function is division.
                            if (operationType == '/')
                                varValue = variables.get(codeLineTokens[1]) 
                                    /variables.get(codeLineTokens[3]);
                            variables.put(codeLineTokens[1], varValue);
                            if (debugMode)
                                System.out.println(varValue);
                        }
                        else {
                            errorMessage = "The variable '" +codeLineTokens[3] +"' doesn't exist";
                            runProgram = false;
                        }
                    }
                // In the case that no variable was found.
                else {
                    errorMessage = "The variable '" +codeLineTokens[1] +"' doesn't exists";
                    runProgram = false;
                }

            } else {
                errorMessage = "Incorrect word '" +codeLineTokens[2]
                        +"' must be " +((operationType == '*') ? "'by'" : "'into'");
                runProgram = false;
            }

        } else {
            errorMessage = "The line '" +inLine +"' "
                    +((codeLineTokens.length < 4) ? "is missing something" : "contains an incorrect word");
            runProgram = false;
        }
    }
    
    private void statementConitional(String inLine, char operationType)
    {
        String codeLineTokens[] = inLine.split(" ");
        // Make sure the amount of tokens are correct to the statement
        if (codeLineTokens.length == 5) {
            // Make sure the correct word is used for the opperator
            if ((operationType == 'i' && codeLineTokens[4].equals("then")) ||
                (operationType == 'w' && codeLineTokens[4].equals("do")) ) {
                if (debugMode)
                    System.out.printf("operType: %c\n", operationType);
                
                // Check if both variables are valid
                int ifVal1 = 0, ifVal2 = 0;
                if (stringType(codeLineTokens[1]) == 0)
                    ifVal1 = Integer.parseInt(codeLineTokens[1]);
                else 
                {
                    if (variables.containsKey(codeLineTokens[1]) )
                    {
                        ifVal1 = variables.get(codeLineTokens[1]);
                    }
                    else {
                        errorMessage = "The variable '" +codeLineTokens[1] +"' doesn't exist";
                        runProgram = false;
                        return;
                    }
                }
                if (stringType(codeLineTokens[3]) == 0)
                    ifVal2 = Integer.parseInt(codeLineTokens[3]);
                else 
                {
                    if (variables.containsKey(codeLineTokens[3]) )
                    {
                        ifVal2 = variables.get(codeLineTokens[3]);
                    }
                    else {
                        errorMessage = "The variable '" +codeLineTokens[3] +"' doesn't exist";
                        runProgram = false;
                        return;
                    }
                }
                
                // Check to make sure the operator is of a vailid selection.
                int operatorCode = isValidOperator(codeLineTokens[2]);
                if (operatorCode != -1)
                {
                    // Was used to check the logic of the if statement I made.
//                    if (debugMode)
//                    {
//                        System.out.printf("%d %s ? %s\n", operatorCode, ifVal1, ifVal2);
//                        
//                        System.out.printf("%d %s < %s = %b\n", operatorCode, 
//                                ifVal1, ifVal2, (operatorCode == 0 && !(ifVal1 < ifVal2)) );
//                        System.out.printf("%d %s > %s = %b\n", operatorCode, 
//                                ifVal1, ifVal2, (operatorCode == 1 && !(ifVal1 > ifVal2)) );
//                        System.out.printf("%d %s == %s = %b\n", operatorCode, 
//                                ifVal1, ifVal2, (operatorCode == 2 && !(ifVal1 == ifVal2)) );
//                        
//                        System.out.printf("%d %s < %s = %b\n", operatorCode, 
//                                ifVal1, ifVal2, (operatorCode == 0 && (ifVal1 < ifVal2)) );
//                        System.out.printf("%d %s > %s = %b\n", operatorCode, 
//                                ifVal1, ifVal2, (operatorCode == 1 && (ifVal1 > ifVal2)) );
//                        System.out.printf("%d %s == %s = %b\n", operatorCode, 
//                                ifVal1, ifVal2, (operatorCode == 2 && (ifVal1 == ifVal2)) );
//                        
//                        System.out.printf("%d %s ? %s @= %b\n", operatorCode, 
//                                ifVal1, ifVal2, ((operatorCode == 0 && !(ifVal1 < ifVal2)) || 
//                                (operatorCode == 1 && !(ifVal1 > ifVal2)) || 
//                                (operatorCode == 2 && !(ifVal1 == ifVal2)) ) );
//                        System.out.printf("%d %s ? %s @= %b\n", operatorCode, 
//                                ifVal1, ifVal2, ((operatorCode == 0 && (ifVal1 < ifVal2)) || 
//                                    (operatorCode == 1 && (ifVal1 > ifVal2)) || 
//                                    (operatorCode == 2 && (ifVal1 == ifVal2)) ) );
//                    }
                        
                    // For if loops
                    if (operationType == 'i' && ((operatorCode == 0 && !(ifVal1 < ifVal2)) || 
                            (operatorCode == 1 && !(ifVal1 > ifVal2)) || 
                            (operatorCode == 2 && !(ifVal1 == ifVal2)) ))
                        silentWaitWord = "endif";
                    // For while loops
                    else if (operationType == 'w' && ((operatorCode == 0 && (ifVal1 < ifVal2)) || 
                            (operatorCode == 1 && (ifVal1 > ifVal2)) || 
                            (operatorCode == 2 && (ifVal1 == ifVal2)) ))
                    {
                        silentWaitWord = "endwhile";
                        silentState = 1;
                    }
                    else if (operationType == 'w')
                        silentWaitWord = "endwhile";
                    
//                    if (debugMode)
//                        System.out.println("before $: " +silentWaitWord);
                }
                else {
                    errorMessage = "Invalid operator for the if statement '" +codeLineTokens[2] +"' ";
                    runProgram = false;
                }

            } else {
                errorMessage = "Incorrect word '" +codeLineTokens[2]
                        +"' must be " +((operationType == 'i') ? "'then'" : "'do'");
                runProgram = false;
            }

        } else {
            errorMessage = "The line '" +inLine +"' "
                    +((codeLineTokens.length < 5) ? "is missing something" : "contains an incorrect word");
            runProgram = false;
        }
    }
    
    public void saveCodeLines(String inCodeLines[])
    {
        codeLines = inCodeLines;
    }
    
    public void addCodeLine(String inCodeLine)
    {
        int arrSz = 1;
        if (codeLines != null)
            arrSz = codeLines.length +1;
        
        // Create a new array with size increased by 1
        String[] tempTransferArr = new String[arrSz];
        
        if (codeLines != null)
        {
            // Copy the elements from the original array to the new array
            for (int i = 0; i < arrSz -1; i++) {
                tempTransferArr[i] = codeLines[i];
            }
            // Add the new item to the end of the new array
            tempTransferArr[tempTransferArr.length - 1] = inCodeLine;
        } 
        else
        {
            codeLines = new String[arrSz];
            tempTransferArr[0] = inCodeLine;
        }
        
        // Transfer the new array to the old one.
        codeLines = tempTransferArr;
    }
    
//    public void addCodeLine(String inCodeLine, int inArrPos)
//    {
//        if (inArrPos > codeLines.length)
//            return;
//        
//        // Create a new array with size increased by 1
//        String[] tempTransferArr = new String[codeLines.length + 1];
//        int adjustArrPos = 0;
//        // Copy the elements from the original array to the new array
//        for (int lp = 0; lp < tempTransferArr.length; lp++) {
//            if (lp != inArrPos)
//                tempTransferArr[lp +adjustArrPos] = codeLines[lp];
//            else
//            {
//                tempTransferArr[lp] = inCodeLine;
//                adjustArrPos = 1;
//            }
//        }
//        
//        // Transfer the new array to the old one.
//        codeLines = tempTransferArr;
//    }
    
    public int ReformatCodeLines()
    {
        int numOfNormLines = 0;
        // This is used to record all the good codeLines of the file.
        int codeLineTrackerArr[] = new int[codeLines.length];

        // Get the amount of commented and normal lines were loaded in
        // from the file.
        for (int lpCnter = 0; lpCnter < codeLines.length; lpCnter++)
            // Check to make sure that the file line has content and that the skip line character isn't there.
            if (codeLines[lpCnter].length() != 0 && 
                    codeLines[lpCnter].charAt(0) != '/')
            {
                codeLineTrackerArr[numOfNormLines] = lpCnter;
                numOfNormLines++;
            }
        
        String chkCodeLines[] = new String[numOfNormLines];
        // Setup the codeline string array with the input file lines.
        for (int lp1 = 0; lp1 < numOfNormLines; lp1++)
            chkCodeLines[lp1] = codeLines[codeLineTrackerArr[lp1]];
        
        codeLines = chkCodeLines;
        
        return numOfNormLines;
    }
    
    public void listCode()
    {
        int cnter = 1;
        for (String codeLine : codeLines)
            System.out.printf("%-3d: %s\n", cnter++, codeLine);
    }
    
    //-----------------------------------------------------------------------------------------
    // Other custom methods.
    
    public int stringType(String inStr)
    {
        int outStrType = -1; // Null
        boolean pointValueFound = false, numberBefore = false;
        for (int lp1 = 0; lp1 < inStr.length(); lp1++)
        {
            if (((inStr.charAt(lp1) >= 48 && inStr.charAt(lp1) <= 57) || inStr.charAt(lp1) == 45) && outStrType <= 0) // int
            {
                outStrType = 0; // int return value
                numberBefore = true;
            }
            else if (numberBefore && ((inStr.charAt(lp1) >= 48 && inStr.charAt(lp1) <= 57) || inStr.charAt(lp1) == 46) && outStrType <= 1 ) // float
            {
                outStrType = 1; // Float return value
                if (inStr.charAt(lp1) == 46 && !pointValueFound)
                    pointValueFound = true;
                else
                    outStrType = 2; // String return value
            }
            else // String
                outStrType = 2; // String return value
            
        }
        return outStrType;
    }
    
    String[] SplitByChar(String inString, char inChar)
    {
        String[] outStringArr = new String[CharacterCheck(inString, inChar) +1];
        int stringCutArrIndex = 0;
        if (inString.length() > 0)
        {
            for (int lp0 = 0; lp0 < outStringArr.length; lp0++)
                outStringArr[lp0] = "";
            for (int lp1 = 0; lp1 < inString.length(); lp1++)
                if (inString.charAt(lp1) == inChar)
                    stringCutArrIndex++;
                else
                    outStringArr[stringCutArrIndex] += inString.charAt(lp1);
        }
        return outStringArr;
    }

    String[] SplitByChar(String inString, char inChar, char inExclusionChar)
    {
        // System.out.printf(">> We are finding the char '%c' and check for the char '%c'.%n", inChar, inExclusionChar); // Testing
        int charsFound = CharacterCheck(inString, inChar, inExclusionChar);
        int stringCutArrIndex = 0;
        // This checks to see if any on the inChars were found
        // If so then make sure to create the array size to the char found amount plus 1 to account for the split,
        // However if no chars are found just return the input string.
        String[] outStringArr;
        if (charsFound == 0)
        {
            outStringArr = new String[1];
            outStringArr[0] = inString;
        } else
            outStringArr = new String[charsFound +1];
        
        if (inString.length() > 0)
        {
            for (int lp0 = 0; lp0 < outStringArr.length; lp0++)
                outStringArr[lp0] = "";
            for (int lp1 = 0; lp1 < inString.length(); lp1++)
                if (inString.charAt(lp1) == inChar)
                    if (lp1 == 0 || inString.charAt(lp1 -1) != inExclusionChar)
                    {
                        // if (lp1 > 0)
                            // System.out.printf("'%c'%n", inString.charAt(lp1 -1)); // Testing
                        stringCutArrIndex++;
                    }
                    else if (outStringArr[stringCutArrIndex].length() == 1)
                    {
                        outStringArr[stringCutArrIndex] = "";
                        outStringArr[stringCutArrIndex] += inString.charAt(lp1);
                    }
                    else
                    {
                        outStringArr[stringCutArrIndex] = outStringArr[stringCutArrIndex].substring(0, outStringArr[stringCutArrIndex].length() -2);
                        // System.out.printf("'%s'%n", outStringArr[stringCutArrIndex]); // Testing
                        outStringArr[stringCutArrIndex] += inString.charAt(lp1);
                    }
                else
                    outStringArr[stringCutArrIndex] += inString.charAt(lp1);
        }
        return outStringArr;
    }
    
    int CharacterCheck(String inString, char inChar)
    {
        int charCnt = 0;
        if (inString.length() > 0)
            for (int lp1 = 0; lp1 < inString.length(); lp1++)
                if (inString.charAt(lp1) == inChar)
                    charCnt++;
        return charCnt;
    }
    
    int CharacterCheck(String inString, char inChar, char inExclusionChar)
    {
        int charCnt = 0;
        if (inString.length() > 0)
            for (int lp1 = 0; lp1 < inString.length(); lp1++)
                if (inString.charAt(lp1) == inChar)
                {
                    if (lp1 > 0 && inString.charAt(lp1 -1) != inExclusionChar)
                        charCnt++;
                }
        return charCnt;
    }
    
    public boolean isValidVariableName(String inVarName) {
        if (inVarName.length() > 10) {
            return false;
        }
        char firstChar = inVarName.charAt(0);
        if (firstChar < 'a' || firstChar > 'z') {
            return false;
        }
        for (int i = 1; i < inVarName.length(); i++) {
            char c = inVarName.charAt(i);
            if ((c < 'a' || c > 'z') && (c < '0' || c > '9')) {
                return false;
            }
        }
        return true;
    }
    
    
    public int isValidOperator(String inVarName) {
        int outOperatorCode = -1;
        switch(inVarName)
        {
            case "<" -> outOperatorCode = 0;
            case ">" -> outOperatorCode = 1;
            case "==" -> outOperatorCode = 2;
        }
        return outOperatorCode;
    }
    
    
} // End of Interpreter class
