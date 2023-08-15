# This is just an example to get you started. A typical binary package
# import iterutils

import sequtils
import strutils
import os

proc diff*(fileName1: string, fileName2: string): string =

  var file1: string
  var file2: string
  var output: string = ""

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

  ## Function to remove the carriage return character from strings
  proc removeCR(str: string): string =
    var newStr = str
    newStr.removeSuffix('\r')
    return newStr

  var lines1: seq[string] = file1.split('\n').map(removeCR) ## Splits file string into a seq via newline character \n and removes \r 
  var lines2: seq[string] = file2.split('\n').map(removeCR) ## Splits file string into a seq via newline character \n and removes \r


  var unchecked1: seq[string] = @[]
  var unchecked2: seq[string] = @[]
  # echo lines1
  # echo lines2
  # var numLines = max(lines1.len, lines2.len) ## Finds the file with the longest number of lines
  echo()
  var lineIndex2 = 0
  for x in 0..lines1.len - 1:
    var line1 = lines1[x]
    line1.removeSuffix('\r')
    if lineIndex2 == lines2.len:
      if line1 in unchecked2:
        echo "\"", line1, "\"\n"
        unchecked2.del(unchecked2.find(line1))
        output = output & "_"
      else:
        echo "DIFF (Removed Line):"
        echo "- \"", line1, "\"\n"
        output = output & "-"

    while lineIndex2 != lines2.len:
      var line2 = lines2[lineIndex2]
      line2.removeSuffix('\r')
      ## If the lines are the same then print just that line and compare with next line1
      if line1 == line2 :
        echo "\"", line1, "\"\n"
        lineIndex2 += 1
        output = output & "_"
        break
      elif line1 != line2:
        if line1 in lines2[lineIndex2..lines2.len-1]:
          unchecked1.add(line1)
          if line2 in unchecked1:
            echo "\"", line2, "\"\n"
            output = output & "_"
          else:
            echo "DIFF (Added New Line):"
            echo "+ \"", line2, "\"\n"
            output = output & "+"
          lineIndex2 += 1
          break

        if line1 in unchecked2:
          echo "\"", line1, "\"\n"
          unchecked2.del(unchecked2.find(line1))
          # lineIndex2 += 1
          output = output & "_"
          break
        
        if line2 in lines1[x..lines1.len-1]: ## here
          unchecked2.add(line2)
          echo "DIFF (Removed Line):"
          echo "- \"", line1, "\"\n"
          lineIndex2 += 1
          output = output & "-"
          break
        else:
          echo "DIFF (Changed Line):"
          echo "  \"", line1, "\" to"
          echo "  \"", line2, "\"\n"
          lineIndex2 += 1
          output = output & "x"
          break

  while lineIndex2 != lines2.len:
    var line2 = lines2[lineIndex2]
    line2.removeSuffix('\r')

    if line2 in unchecked1:
      echo "\"", line2, "\"\n"
      unchecked1.del(unchecked1.find(line2))
      output = output & "_"
    else:
      echo "DIFF (Added New Line):"
      echo "+ \"", line2, "\"\n"
      output = output & "+"
    lineIndex2 += 1

  return output


when isMainModule:
  echo()
  if paramCount() == 3:
    if paramStr(1) == "diff":
      let result = diff(paramStr(2), paramStr(3))
      echo result
