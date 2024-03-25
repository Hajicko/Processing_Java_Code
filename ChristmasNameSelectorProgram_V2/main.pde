
class main 
{
  String[] loadedNameList;
  int nextValidNameInList;
  boolean[] saveResultBool;
  String folderName;
  
  String[] namesSelectionInList;
  final String fileDirectory = "data/List.txt";
  
  GiftBox textGiftBox1;
  textBox textTextBx;
  textBox warningTxtBx;
  
  int stage, nameArrPos;
  
  boolean completed;
  boolean savedFrame;
  
  main() 
  {
    loadedNameList = loadStrings(fileDirectory);
    nextValidNameInList = 0;
    saveResultBool = new boolean[loadedNameList.length];
    for (int lp0 = 0; lp0 < loadedNameList.length; lp0++)
    {
      saveResultBool[lp0] = boolean(int(loadedNameList[lp0].split(" ")[1]) );
      println(saveResultBool[lp0] +" = " +loadedNameList[lp0].split(" ")[1]);
      loadedNameList[lp0] = loadedNameList[lp0].split(" ")[0];
    }
    
    namesSelectionInList = GenerateList(loadedNameList);
    
    stage = 0;
    nameArrPos = -1;
    completed = false;
    savedFrame = false;

    // Find the next valid name if the first name is skipped i.e. it is 1 in the list file
    if (saveResultBool[nextValidNameInList] == true)
      nextValidNameInList = findNextValidName(loadedNameList, saveResultBool, nameArrPos);
    
    textGiftBox1 = new GiftBox(new PVector(width /2, height /2), new PVector(0.5, 0.5), "The Gift of Love :)");
    
    color[] defaultCols = {color(240), color(230), color(220), color(180), color(10)};
    textFont(customFont);
    textTextBx = new textBox(loadedNameList[nextValidNameInList] +" press this to start.", new PVector(width /2, height -200), new PVector(width /50.0, height /100.0), 50, 0, defaultCols, -5);
    // nextValidNameInList = findNextValidName(loadedNameList, saveResultBool, nameArrPos);
    
    color[] defaultCols2 = {color(240, 180, 180), color(230, 180, 180), color(220, 180, 180), color(180, 180, 180), color(10, 10, 10)};
    warningTxtBx = new textBox(loadedNameList[nameArrPos +1] +" be careful not to say who you are secret santa for.", new PVector(width /2, height -100), new PVector(width /100.0, height /200.0), 30, 0, defaultCols2, -5);
    
    //PlaySound(2);
    
    //delay(1750);
    
    //PlaySound(1); 
  }
  
  void run() 
  {
    background(250);
    
    //if (stage == 0)
    //{
      
    //  fill(180);
    //  stroke(10);
    //  textSize(50);
    //  textAlign(CENTER);
    //  rect(width -10 -textWidth("Next is " +loadedNameList[nameArrPos +1]) -50, height -10 -50 -50, 10 +textWidth("Next is " +loadedNameList[nameArrPos +1]), 60);
    //  fill(10);
    //  text("Next is " +loadedNameList[nameArrPos +1], width -5 -textWidth("Next is " +loadedNameList[nameArrPos +1])/2 -50, height -10 -50);
      
    //}
    
    if (!completed)
    {
      if (nameArrPos > -1 && saveResultBool[nameArrPos])
      {
        textGiftBox1.stage = 2;
      }
      
      if (!completed && nameArrPos > -1)
        textGiftBox1.Run();
      
      if (textGiftBox1.stage == 2 || nameArrPos == -1)
      {
        textTextBx.Run();
        
        if (nameArrPos > -1 && !savedFrame) { //saveResultBool[nameArrPos]
          saveFrame("Saves/" +folderName +"/" +loadedNameList[nameArrPos] +"/Frame1.png");
          savedFrame = true;
        }
        
        if (textTextBx.pressed || (nameArrPos > -1 && saveResultBool[nameArrPos]))
          if (nameArrPos < namesSelectionInList.length -2)
          {
            nameArrPos++;
            textGiftBox1 = new GiftBox(new PVector(width /2, height /2), new PVector( (((width +height) /6) /378.3), (((width +height) /6) /378.3) ), "You will be " +namesSelectionInList[nameArrPos] +"'s secert santa.");// loadedNameList[nameArrPos] +" is secert santa for " +namesSelectionInList[nameArrPos] +"."
            
            // Find the next valid name
            nextValidNameInList = findNextValidName(loadedNameList, saveResultBool, nameArrPos);
            // In the case that -1 is returned then just get the next name even if they aren't here. 
            if (nextValidNameInList == -1)
              nextValidNameInList = nameArrPos +1;
              
            //println("nameArrPos: " +nameArrPos +", nextValidNameInList: " +nextValidNameInList +", " +loadedNameList[nextValidNameInList]);
            
            textTextBx.text = "Next is " +loadedNameList[(!saveResultBool[nameArrPos +1])? nameArrPos +1 : nextValidNameInList];
            textTextBx.Setup();
            textTextBx.pos = new PVector(width -50, height -50);
            textTextBx.pos.x -= textTextBx.sz.x /2;
            textTextBx.pos.y -= textTextBx.sz.y /2;
            
            warningTxtBx.text = loadedNameList[nameArrPos] +" be careful not to say who you are secret santa for.";
            warningTxtBx.Setup();
            
            savedFrame = false;
          }
          else if (nameArrPos < namesSelectionInList.length -1)
          {
            nameArrPos++;
            textGiftBox1 = new GiftBox(new PVector(width /2, height /2), new PVector( (((width +height) /6) /378.3), (((width +height) /6) /378.3) ), "You will be " +namesSelectionInList[nameArrPos] +"'s secert santa.");// loadedNameList[nameArrPos] +" is secert santa for " +namesSelectionInList[nameArrPos] +"."
            
            textTextBx.text = loadedNameList[nextValidNameInList] +" press this to end.";
            textTextBx.Setup();
            textTextBx.pos = new PVector(width /2, height -200);
            
            warningTxtBx.text = loadedNameList[nameArrPos] +" be careful not to say who you are secret santa for.";
            warningTxtBx.Setup();
            
            savedFrame = false;
          }
          else
          {
            textTextBx.text = "Secret Santa is underway! Have a merry christmas everyone.";
            textTextBx.Setup();
            textTextBx.pos = new PVector(width /2, height /2);
            
            warningTxtBx.text = "Everyone be careful not to say who you are secret santa for.";
            warningTxtBx.Setup();
            warningTxtBx.pos = new PVector(width /2, height /2 +100);
            
            completed = true;
            savedFrame = false;
          }
      }
    }
    else
    {
      textTextBx.Run();
      
      if (textTextBx.pressed)
        exit();
    }
      
    warningTxtBx.Run();
    
    
    //for (int lp0 = 0; lp0 < loadedNameList.length; lp0++)
    //{
    //  fill(0);
    //  textSize(30);
    //  text((loadedNameList[lp0] + ": " + namesSelectionInList[lp0]), width /2 -(textWidth(loadedNameList[lp0] + ": " + namesSelectionInList[lp0]) /2.0), height /2 -(loadedNameList.length /2.0) * 30 + (30 * lp0));
    //}
    
  }
  
  String[] GenerateList(String[] inputNameList)
  {
    ArrayList<String> convNameList = new ArrayList<String>();
    ArrayList<String> editedNameList = new ArrayList<String>();
    for (int slp0 = 0; slp0 < inputNameList.length; slp0++)
      convNameList.add(inputNameList[slp0]);
    
    
    String[] outputList = new String[inputNameList.length];
    ArrayList<String> subOutputList = new ArrayList<String>();
    
    int randomNameListArrId = -1;
    while (randomNameListArrId == -1 || !CheckListForUnique(inputNameList, outputList))
    {
      /// Resetup all the variables used in the loop.
      editedNameList.clear();
      for (String s : convNameList)
        editedNameList.add(s);
      
      /// Select a name from the name list at random to come up with a unique sequence.
      for (int lp0 = 0; lp0 < convNameList.size(); lp0++)
      {
        //print("{ ");
        /// Make sure the previous loop doesn't run into the current one by clearing it of all it's data.
        subOutputList.clear();
        /// Gets all the names left in the name list besides their own name.
        for (int lp1 = 0; lp1 < editedNameList.size(); lp1++)
        {
          if (convNameList.get(lp0) != editedNameList.get(lp1))
            subOutputList.add(editedNameList.get(lp1));
        }
        
        //print("[");
        //for (String tempS1 : editedNameList)
        //  print("'" + tempS1 + "' ");
        //print("], [");
        //for (String tempS2 : subOutputList)
        //  print("'" + tempS2 + "' ");
        //print("]");
        
        if (subOutputList.size() == 0)
          break;
        
        /// Get a random int that will select a name from the subOutputList later on.
        randomNameListArrId = round(random(0, subOutputList.size() -1));
        
        //print(" #" + randomNameListArrId + " ");
        
        /// Save the name selected from subOutputList into the outputList.
        outputList[lp0] = subOutputList.get(randomNameListArrId);
        
        for (int lp1 = 0; lp1 < editedNameList.size(); lp1++)
          if (editedNameList.get(lp1) == outputList[lp0])
            /// Remove the name from the edited arraylist, so it isn't selected again.
            editedNameList.remove(lp1);
        
        //print(outputList[lp0] + " }     |     ");
      
      }
      
      //println();
      //for (int lp0 = 0; lp0 < convNameList.size(); lp0++)
      //  print(inputNameList[lp0] +"[" +lp0 +"] ");
      
    }
    
    String[] saveToFileLines = new String[inputNameList.length +1];
      
    saveToFileLines[0] = "Date: " +day() +"-" +month() +"-" +year() +". Time: " +hour() +":" +minute() +"." +second();
    for (int lp0 = 1; lp0 < inputNameList.length +1; lp0++)
    {
      saveToFileLines[lp0] = inputNameList[lp0 -1] +TabSpacer(inputNameList[lp0 -1].length(), 16) +" -> " +outputList[lp0 -1];
    }
    folderName = ("Date_" +day() +"-" +month() +"-" +year() +"_Time_" +hour() +"-" +minute() +"-" +second());
    saveStrings("Saves/" +folderName +"/" +folderName +".txt", saveToFileLines);
    
    return outputList;
  }
  
  boolean CheckListForUnique(String[] inputNameList, String[] resultNameList)
  {
    
    //boolean nameFound = false;
    for (int lp0 = 0; lp0 < inputNameList.length; lp0++)
    {
      /// Check to see if the name selected
      if (inputNameList[lp0] == resultNameList[lp0] || resultNameList[lp0] == "" || resultNameList[lp0] == null)
        return false;
      
      ///// 
      //for (int lp1 = 0; lp1 < resultNameList.length; lp1++)
      //  if (inputNameList[lp0] == resultNameList[lp1])
      //    nameFound = true;
      
      //if (!nameFound)
      //  return false;
      
    }
      
    return true;
  }
  
  String TabSpacer(int textSz, int textMaxLength)
  {
    String outSpacing = "";
    int lpTextSz = textSz;
    for (int lp0 = 1; lp0 < floor(textMaxLength /8.0); lp0++)
      if (lpTextSz < textMaxLength -textSz)
      {
        outSpacing += "\t";
        lpTextSz += 8;
      }
    
    return outSpacing;
  }
  
  int findNextValidName(String[] names, boolean[] used, int currentIndex) {
    // Start searching for the next valid name from the next index
    int nextIndex = (currentIndex + 1) % names.length;
    while (nextIndex > currentIndex) {
        // Check if the name at nextIndex has not been used yet
        if (!used[nextIndex] && nextIndex < names.length) {
            // Return the next valid name found
            return nextIndex;
        }
        // Move to the next index
        nextIndex = (nextIndex + 1) % names.length;
    }

    // If all names have been used, return null or handle as needed
    return -1;
  }


  
}
