import prelude
include prelude

const PAIRS = [ ("one","one1one"),("two","two2two"),("three","three3three"),("four","four4four"),("five","five5five"),("six","six6six"),("seven","seven7seven"),("eight","eight8eight"),("nine","nine9nine") ]

func fuseFirstAndLastNumber(line: string): int =
  var a, b: char
  for char in line:
    if char.isDigit:
      a = char
      break
  for i in countdown(line.high, line.low):
    if line[i].isDigit:
      b = line[i]
      break
  result = parseInt &"{a}{b}"

proc part1(input: string):int =
  for line in input.split("\n"):
    result += line.fuseFirstAndLastNumber

# Lame solution, but way easier than going with a trie
proc expandWords(line: var string): string =
  for (word, expansion) in PAIRS:
    line = replace(line, word, expansion)
  return line

proc part2(input: string): int =
  for line in input.split("\n"):
    var mutLine = line
    result += mutLine.expandWords.fuseFirstAndLastNumber

proc run() = 
  let input = "../input/input_01".readFile
  echo "Part One: ", part1(input)
  echo "Part Two: ", part2(input)

when isMainModule:
  run()