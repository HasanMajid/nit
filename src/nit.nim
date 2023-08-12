# This is just an example to get you started. A typical binary package
# import iterutils

# import sequtils
import strutils
import os

proc diff*(fileName1: string, fileName2: string) =

  var file1: string
  var file2: string

  try:
    file1 = readFile(fileName1)
  except IOError:
    echo "Error! Cannot read file: ", fileName1
    return

  try:
    file2 = readFile(fileName2)
  except IOError:
    echo "Error! Cannot read file: ", fileName2
    return

  # echo file[file.len-1]

  let lines1: seq[string] = file1.split('\n') ## Splits file string into a seq via newline character \n
  let lines2: seq[string] = file2.split('\n') ## Splits file string into a seq via newline character \n

  echo lines1
  echo lines2 
  var numLines = max(lines1.len, lines2.len) ## Finds the file with the longest number of lines
  echo()  

  ## Looping through each line for each file and comparing them
  for i in 0..numLines-1:
    var line1 = lines1[i]
    var line2 = lines2[i]
    line1.removeSuffix('\r')
    line2.removeSuffix('\r')

    ## Prints one line if both lines are the same
    if line1 == line2:
      echo "\"", $i, ". ", line1, "\"\n"
    ## Prints both lines if both lines are different
    if line1 != line2:
      echo "DIFF:"
      echo "\"", $i, ". ", line1, "\"\n"
      echo "\"", $i, ". ", line2, "\"\n"
    echo()

when isMainModule:
  echo()
  if paramCount() == 3:
    if paramStr(1) == "diff":
      diff(paramStr(2), paramStr(3))






  ## can't loop through 3 seqs at once, only 2
  # for (line1, line2, z) in items(zip(lines1, lines2, lineNums)):
  #   if line1 == line2:
  #     echo line1, line2
  #   if line1 != line2:
  #     echo "DIFF:\n", line1, "\n", line2
  #   echo()
  
  # var out1 = ""
  # var out2 = ""
  # for (line1, line2) in zip(file, file2):
  #   if line1 != line2:
  #     out1 = out1 & line1
  #     out2 = out2 & line2

  # echo out1
  # echo out2



      


