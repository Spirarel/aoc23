include aoc

discard """
parse input
  - strip "game"
  - extract to struct: 
    - game number
    - array of tuples for each row
filter not any component greater than thres
sum game numbers
"""

# Game 1: 1 blue; 4 green, 5 blue; 11 red, 3 blue, 11 green; 1 red, 10 green, 4 blue; 17 red, 12 green, 7 blue; 3 blue, 19 green, 15 red
type
  Game = object
    num: Positive
    draws: seq[Draw]
  Draw = tuple
    r,g,b: Natural

proc parse(lines: openArray[string]): seq[Game] =
  var games: array[100, Game]
  for i,game in lines:
    let draws = game[7..^1].split(";")
    for draw in draws:
      for color in draw.split(","):
        color.strip(false)
        let (_, count, color) = color.scanTuple("$i $w")

        



      let a = draw.scanTuple("$i $w")
      echo a

proc part1(): string =
  let input = "input/2.in".readFile.strip(false)
  let lines = input.splitLines
  parse(lines)

if isMainModule:
  discard part1()
  