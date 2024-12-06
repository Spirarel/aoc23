import std/[os, strutils, times, parseutils, hashes, tables, sets, sequtils, parseopt, strformat, math]
import re, macros, httpclient, net, algorithm, std/monotimes, strscans, deques, sugar, bitops

var SOLUTIONS*: Table[int, proc (x: string): Table[int, string]]

template day*(day: int, solution: untyped): untyped =
    ## Defines a solution function, if isMainModule, runs it.
    block:
        SOLUTIONS[day] = proc (input: string): Table[int, string] =
            var inputRaw{.inject.} = input
            var input {.inject.} = input.strip(false)
            var lines {.inject.} = input.splitLines
            var parts {.inject.}: OrderedTable[int, proc (): string]
            solution
            for k, v in parts:
                result[k] = $v()

    if isMainModule:
        run day

template part*(p: int, t: type, solution: untyped): untyped =
    ## Defines a part solution function.
    parts[p] = proc (): string =
        proc inner(): t =
            solution
        return $inner()
template part*(p: int, solution: untyped): untyped =
    ## Defines a part solution function.
    parts[p] = proc (): string =
        proc inner(): auto =
            solution
        return $inner()

proc getInput(day: int): string =
    ## Downloads an input for given day, saves it on disk and returns it,
    ## unless it's been downloaded before, in which case loads it from the disk.
    let filename = fmt"inputs/day{day}.in"
    if fileExists filename:
        return readFile filename
    echo fmt"Downloading input for day {day}."
    let ctx = newContext(caFile="aoc.cer")
    let client = newHttpClient(sslContext =ctx)
    client.headers["cookie"] = readFile "session"
    let input = client.get(fmt"https://adventofcode.com/2023/day/{day}/input")
    echo input.body()
    # filename.writeFile(input)
    # return input
    return ""

proc run*(day: int) =
    ## Runs given day solution on the corresponding input.
    let start = getMonoTime()
    let results = SOLUTIONS[day](getInput day)
    let finish = getMonoTime()
    echo "Day " & $day
    for k in results.keys.toSeq.sorted:
        echo fmt" Part {k}: {results[k]}"
    echo fmt" Time: {finish-start}"