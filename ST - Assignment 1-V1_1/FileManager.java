import java.io.FileReader;
import java.util.Scanner;
import java.io.IOException;

/**
 * Write a description of class FileManager here.
 *
 * @author (your name)
 * @version (a version number or a date)
 */
public class FileManager
{
    
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
                // Check to make sure that the file line has content.
                if (tempStr.length() != 0)
                    fileRawLines[whileLpCounter++] = tempStr;
                
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
                // Check to make sure that the file line has content.
                if (tempStr.length() != 0)
                    fileLength++;
            }
            inFile.close();
        }
        catch (IOException ex1)
        {
            System.out.println("File IO Error - File not found:"+inFileDirectory);
            return -1;
        }
        return fileLength;
    }
}
