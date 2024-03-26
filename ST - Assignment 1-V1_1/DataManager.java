
/**
 * Write a description of class DataManager here.
 *
 * @author (your name)
 * @version (a version number or a date)
 */
public class DataManager
{
    
    public String[][] findDataPoint(String inRawArray[][], int inSearchColumn, String inSearchVal)
    {
        int foundMatchingDataPos[] = new int[inRawArray.length];
        int arrayIncrement = -1;
        
        //System.out.printf("%nThe size of the search array is %d.%n", inRawArray.length); // Testing
        for (int lp1 = 0; lp1 < inRawArray.length; lp1++)
        {
            
            //System.out.printf("%d > Array[%s] ?= inSeachVal[%s].%n", lp1, inRawArray[lp1][inSearchColumn], inSearchVal); // Testing
            if (inRawArray[lp1][inSearchColumn].compareTo(inSearchVal) == 0)
            {
                arrayIncrement++;
                foundMatchingDataPos[arrayIncrement] = lp1;
                //System.out.printf("Found positions of the search array %d.%n", lp1); // Testing
            }
        }
        
        //System.out.printf("The incremtent end value is %d.%n", arrayIncrement); // Testing
        if (arrayIncrement > -1)
        {
            String outputStrArr[][] = new String[arrayIncrement +1][];
            for (int lp1 = 0; lp1 < arrayIncrement +1; lp1++)
                outputStrArr[lp1] = inRawArray[foundMatchingDataPos[lp1]];
            return outputStrArr;
        }
        else 
        {
            //System.out.printf("No, columns were found with the inputs.%n"); // Testing
            return null;
        }
    }
    
    public int seqFindDataPoint(String inRawArray[][], int inSearchColumn, String inSearchVal)
    {
        //System.out.printf("%nThe size of the search array is %d.%n", inRawArray.length); // Testing
        for (int lp1 = 0; lp1 < inRawArray.length; lp1++)
        {
            
            //System.out.printf("%d > Array[%s] ?= inSeachVal[%s].%n", lp1, inRawArray[lp1][inSearchColumn], inSearchVal); // Testing
            if (inRawArray[lp1][inSearchColumn].compareTo(inSearchVal) == 0)
            {
                return lp1;
                //System.out.printf("Found positions of the search array %d.%n", lp1); // Testing
            }
        }
        return -1;
    }
    
    public int binaryFindDataPoint(String inRawArray[][], int inSearchColumn, String inSearchVal)
    {
        int mid = -1, low = 0, high = inRawArray.length -1, lpCnt = 0, cmp = 0;
        while (low <= high && lpCnt < inRawArray.length) 
        {
            mid = (low + high) / 2;
            cmp = inSearchVal.compareTo(inRawArray[mid][inSearchColumn]);
            
            if (cmp < 0)
                high = mid - 1;
            else if (cmp > 0)
                low = mid + 1;
            else
            {
                return mid;
            }
            lpCnt++;
        }
        return -1;
    }
    
    public int binaryFindDataPoint(int inRawArray[], int inSearchVal)
    {
        int mid = -1, low = 0, high = inRawArray.length, lpCnt = 0;
        while (low != high && lpCnt < inRawArray.length)
        {
           mid = (low +high) /2;
               if (inSearchVal == inRawArray[mid])
                   return inRawArray[mid];
               else if (inSearchVal > inRawArray[mid]) // x is on the right side
                   low = mid +1;
               else                  // x is on the left side
                   high = mid -1;
            lpCnt++;
        }
        return -1;
    }
    
    public String[][] CustomSort1(String inRawArray[][], int inColumnSort, int inSortType)
    {
        int minIndex; // index of smallest item in each pass
        int pass, j, columnSz = inRawArray.length;
        String tempArrPtr[];
        // sort array[0]..array[n-2], and array[n-1] is in place
        for (pass = 0; pass < columnSz -1; pass++) 
        {
            // System.out.printf("%d-", pass); // Testing
            // scan from index pass; set minIndex to pass
            minIndex = pass;
            // j scans the sublist array[pass+1]..array[n-1]
            for (j = pass +1; j < columnSz; j++) 
            {
                // System.out.printf("%d, ", j); // Testing
                // update minIndex if smaller element found
                if (inSortType == 0 && NumericalChk(inRawArray[j][inColumnSort], inRawArray[minIndex][inColumnSort]) == 0 ) 
                    minIndex = j;
                else if (inSortType == 1 && AlphabeticalChk(inRawArray[j][inColumnSort], inRawArray[minIndex][inColumnSort]) == 0) 
                {
                    minIndex = j;
                    // System.out.printf("'%d'", minIndex); // Testing
                }
            }
            
            // place smallest item in array[pass]
            if (minIndex != pass) 
            {
                tempArrPtr = inRawArray[pass];
                inRawArray[pass] = inRawArray[minIndex];
                inRawArray[minIndex] = tempArrPtr;
            }
            // System.out.println(); // Testing
        }
        // System.out.println(); // Testing
        
        return inRawArray;
    }
    
    public int AlphabeticalChk(String inStr1, String inComparisonStr)
    {
        if ((inStr1 != null && inComparisonStr != null) && (inStr1.length() > 0 && inComparisonStr.length() > 0) )
        {
            
            String editedInStr1 = inStr1.toLowerCase(), editedComStr = inComparisonStr.toLowerCase();    
            // Check to see if the text is the same.
            if (editedInStr1 == editedComStr)
                return 1; // They are on the same poisition on the alphabet.
            
            int lpCnt = (editedInStr1.length() > editedComStr.length() ) ? editedInStr1.length() : editedComStr.length(); // Get the size of the larger string
            int str1CharVal, str2CharVal, char1Type, char2Type;
            for (int lp1 = 0; lp1 < lpCnt; lp1++) 
            { //chk to make sure that the charAt isn't below the char 'a' and if so then but it at a value lowerthan anything else
                if (lp1 > editedInStr1.length() -1)
                    return 2; // inComparisonStr is higher up on the alphabet.
                else if (lp1 > editedComStr.length() -1)
                    return 0; // inStr1 is higher up on the alphabet.
                
                str1CharVal = (int)editedInStr1.charAt(lp1);
                str2CharVal = (int)editedComStr.charAt(lp1);
                char1Type = charType(str1CharVal);
                char2Type = charType(str2CharVal);
                // if (str1CharVal < 97 && str2CharVal < 97) // Check if the chars from both strings aren't less than the ASCii value of 'a'.
                    // break;//return (str1CharVal < str2CharVal) ? 0 : 2; // Go to the next char.
                // else if (str1CharVal < 97) return 2;
                // else if (str2CharVal < 97 || str1CharVal < str2CharVal)
                    // return 0; // inStr1 is higher up on the alphabet.
                // else
                    // return 2; // inComparisonStr is higher up on the alphabet.
                
                if (str1CharVal != str2CharVal) // Check to make sure then aren't the same
                {
                    if (char1Type == 1 && char2Type == 1 ) // Letters
                        return (str1CharVal < str2CharVal) ? 0 : 2;
                    else if (char1Type == 1) return 0; // input 1 is a Letter
                    else if (char2Type == 1) return 2; // input 2 is a Letter
                    // else // Letters & Special chars
                        // break;
                }
            }
            return 1;
        } 
        else if ((inStr1 != null && inComparisonStr == null) || (inStr1.length() > 0 && inComparisonStr.length() <= 0) )
            return 0; // inStr1 is higher up on the alphabet.
        else if ((inStr1 == null && inComparisonStr != null) || (inStr1.length() <= 0 && inComparisonStr.length() > 0) )
            return 2; // inComparisonStr is higher up on the alphabet.
        else if (inStr1 == null && inComparisonStr == null) return -2; // Both inputs were null;
        else return -1; // The inputted string was empty.
        
    }
    
    public int NumericalChk(String inStr1, String inComparisonStr)
    {
        if ((inStr1 != null && inComparisonStr != null) && (inStr1.length() > 0 && inComparisonStr.length() > 0) )
        {
            
            String editedInStr1 = inStr1.toLowerCase(), editedComStr = inComparisonStr.toLowerCase();    
            // Check to see if the text is the same.
            if (editedInStr1 == editedComStr)
                return 1; // They are on the same string.
            
            if (editedInStr1.length() != editedComStr.length() ) 
                return (editedInStr1.length() > editedComStr.length() ) ? 2 : 0;
                
            int lpCnt = (editedInStr1.length() > editedComStr.length() ) ? editedInStr1.length() : editedComStr.length(); // Get the size of the larger string
            int str1CharVal, str2CharVal;
            int char1Type, char2Type;
            for (int lp1 = 0; lp1 < lpCnt; lp1++) 
            { //chk to make sure that the charAt isn't below the char 'a' and if so then but it at a value lowerthan anything else
                str1CharVal = (int)editedInStr1.charAt(lp1);
                str2CharVal = (int)editedComStr.charAt(lp1);
                char1Type = charType(str1CharVal);
                char2Type = charType(str2CharVal);
                
                if (str1CharVal != str2CharVal) // Check to make sure then aren't the same
                {
                    if (char1Type == 0 && char2Type == 0 ) // Number
                        return (str1CharVal < str2CharVal) ? 0 : 2;
                    else if (char1Type == 0) return 0; // input 1 is a number
                    else if (char2Type == 0) return 2; // input 2 is a number
                    // else // Letters & Special chars
                        // break;
                }
            }
            return 1;
        } 
        else if ((inStr1 != null && inComparisonStr == null) || (inStr1.length() > 0 && inComparisonStr.length() <= 0) )
            return 0; // inStr1 is higher up on the alphabet.
        else if ((inStr1 == null && inComparisonStr != null) || (inStr1.length() <= 0 && inComparisonStr.length() > 0) )
            return 2; // inComparisonStr is higher up on the alphabet.
        else if (inStr1 == null && inComparisonStr == null) return -2; // Both inputs were null;
        else return -1; // The inputted string was empty.
        
    }
    
    
    //-----------------------------------------------------------------------------------------
    // Other custom methods.
    
    public int stringType(String inStr)
    {
        int outStrType = -1; // Null
        boolean pointValueFound = false, numberBefore = false;
        for (int lp1 = 0; lp1 < inStr.length(); lp1++)
        {
            if (inStr.charAt(lp1) >= 48 && inStr.charAt(lp1) <= 57 && outStrType <= 0) // int
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
    
    private int charType(int inCharVal)
    {
             if (inCharVal >= 48 && inCharVal <= 57) return 0; // Number
        else if (inCharVal >= 97 && inCharVal <= 122)return 1; // Letter 
        else if (inCharVal >= 65 && inCharVal <= 90) return 2; // Cap Letter 
        else                                             return 3; // Special
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
    
    private int StringIntCode(String inStr)
    {
        int outStrCode = -1;
        if (inStr != null)
        {
            String tempStrCode = "";
            for (int lp1 = 0; lp1 < inStr.length(); lp1++)
            {
                tempStrCode += inStr.charAt(lp1);
            }
            outStrCode = Integer.parseInt(tempStrCode); // Redefine the value
        }
        return outStrCode;
    }
}
