//
//  LogicPositioning.swift
//  WordSearch
//
//  Created by Yassir RAMDANI on 5/12/19.
//  Copyright © 2019 Yassir RAMDANI. All rights reserved.
//

import Foundation

enum Direction: CaseIterable {
    case horizontal, vertical, diagoRight, diagoLeft
}

class LogicPositioning {
    var freeCell: [Bool]
    let numLines: Int
    let numCollumns: Int
    let wordsList: [String]
    var wordsGrid: [String]
    var wordsListRanges = [String: (Int, Int)]()
    let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    var wordsFound = [String: (Int, Int)]()

    init(numLines: Int, numCollumns: Int, wordsList: [String]) {
        freeCell = [Bool](repeating: true, count: numLines * numCollumns)
        wordsGrid = [String](repeating: "", count: numLines * numCollumns)
        for i in 0 ..< numCollumns * numLines {
            wordsGrid[i] = String(letters[letters.index(letters.startIndex, offsetBy: Int.random(in: 0 ..< letters.count))])
        }

        self.numLines = numLines
        self.numCollumns = numCollumns
        self.wordsList = wordsList.shuffled()
        var skip = false
        for word in self.wordsList {
            skip = false
            for index in (0 ..< numLines * numCollumns).shuffled() {
                if skip { continue }
                for dir in Direction.allCases.shuffled() {
                    if skip { continue }
                    if doesFit(from: index, word: word, direction: dir) {
                        put(from: index, word: word, direction: dir)
                        skip = true
                    }
                }
            }
            if skip { continue }
            print("⚠️ Couldn't place:", word)
        }
    }

    fileprivate func indexToXY(index: Int) -> (Int, Int) {
        return (index % numCollumns, index / numCollumns)
    }

    func doesFit(from index: Int, word: String, direction: Direction) -> Bool {
        let (x, y) = indexToXY(index: index)
        for i in 0 ..< word.count {
            var computedX = x
            var computedY = y
            switch direction {
            case .horizontal:
                computedX = x + i
            case .vertical:
                computedY = y + i
            case .diagoRight:
                computedX = x + i
                computedY = y + i
            case .diagoLeft:
                computedX = x - i
                computedY = y + i
            }
            if computedX >= numCollumns || computedY >= numLines || computedX < 0 || computedY < 0 || !freeCell[computedX + computedY * numCollumns] {
                return false
            }
        }
        return true
    }

    func put(from index: Int, word: String, direction: Direction) {
        let (x, y) = indexToXY(index: index)
        for i in 0 ..< word.count {
            var computedX = x
            var computedY = y
            switch direction {
            case .horizontal:
                computedX = x + i
            case .vertical:
                computedY = y + i
            case .diagoRight:
                computedX = x + i
                computedY = y + i
            case .diagoLeft:
                computedX = x - i
                computedY = y + i
            }
            wordsListRanges[word] = (index, computedX + computedY * numLines)
            freeCell[computedX + computedY * numCollumns] = false
            wordsGrid[computedX + computedY * numLines] = String(word[word.index(word.startIndex, offsetBy: i)]).capitalized
        }
    }

    func isInRange(index: Int, start: Int, end: Int) -> Bool {
        if start == -1 || end == -1 { return false }
        let (x, y) = indexToXY(index: index)
        let (begX, begY) = indexToXY(index: min(start, end))
        let (endX, endY) = indexToXY(index: max(start, end))
        if x >= begX, x <= endX, y == begY, y == endY {
            return true
        }
        if y >= begY, y <= endY, x == begX, x == endX {
            return true
        }
        if y >= begY, y <= endY, x >= begX, x <= endX, x - begX == y - begY, endX - x == endY - y {
            return true
        }
        if y >= begY, y <= endY, x >= endX, x <= begX, x - begX == -(y - begY), endX - x == -(endY - y) {
            return true
        }
        return false
    }
}
