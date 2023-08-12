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
    var x = lines1[i]
    var y = lines2[i]
    x.removeSuffix('\r')
    y.removeSuffix('\r')

    if x == y:
      echo "\"", $i, ". ", x, "\"\n"
    if x != y:
      echo "DIFF:"
      echo "\"", $i, ". ", x, "\"\n"
      echo "\"", $i, ". ", y, "\"\n"
    echo()

when isMainModule:
  echo()
  if paramCount() == 3:
    if paramStr(1) == "diff":
      diff(paramStr(2), paramStr(3))






  ## can't loop through 3 seqs at once, only 2
  # for (x, y, z) in items(zip(lines1, lines2, lineNums)):
  #   if x == y:
  #     echo x, y
  #   if x != y:
  #     echo "DIFF:\n", x, "\n", y
  #   echo()
  
  # var out1 = ""
  # var out2 = ""
  # for (x, y) in zip(file, file2):
  #   if x != y:
  #     out1 = out1 & x
  #     out2 = out2 & y

  # echo out1
  # echo out2



      


