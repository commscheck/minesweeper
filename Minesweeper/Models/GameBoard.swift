//
//  GameBoard.swift
//  Minesweeper
//
//  Created by Benjamin Lea on 13/12/2015.
//  Copyright © 2015 Benjamin Lea. All rights reserved.
//

import Foundation

struct GameBoard {
  let width: Int
  let height: Int
  let bombs: Int
  var grid: [[BoardCell]]

  init(width: Int = 10, height: Int = 10, bombs: Int = 10) {
    assert(width > 0, "Width must be at least 1")
    assert(height > 0, "Height must be at least 1")
    assert(bombs < (width * height), "Too many bombs")

    self.width = width
    self.height = height
    self.bombs = bombs

    let cellCount = width * height
    var bombsLeft = bombs
    var bombArray = [Bool](count: cellCount, repeatedValue: false)
    while bombsLeft > 0 {
      let index = Int(arc4random_uniform(UInt32(cellCount)))
      if bombArray[index] == false {
        bombArray[index] = true
        bombsLeft--
      }
    }

    var newGrid: [[BoardCell]] = []
    for x in 0..<width {
      var column = [BoardCell]()
      for y in 0..<height {
        let cellNumber = x + (y * width)
        let value: CellValue
        if bombArray[cellNumber] == true {
          value = CellValue.Bomb
        }
        else {
          value = CellValue.Empty(neighbours: 0)
        }
        column.append(BoardCell(revealed: false, value: value))
      }
      newGrid.append(column)
    }

    for y in 0..<height {
      for x in 0..<width where newGrid[x][y].value == CellValue.Bomb {
        for neighbourY in (y - 1)...(y + 1) where neighbourY >= 0 && neighbourY < height {
          for neighbourX in (x - 1)...(x + 1) where neighbourX >= 0 && neighbourX < width {
            if !(x == neighbourX && y == neighbourY) {
              switch newGrid[neighbourX][neighbourY].value {
              case let .Empty(neighbours):
                newGrid[neighbourX][neighbourY].value = .Empty(neighbours: neighbours + 1)
              default:
                break
              }
            }
          }
        }
      }
    }
    self.grid = newGrid
  }

  func printToConsole() {
    for y in (0..<height).reverse() {
      for x in 0..<width {
        switch self.grid[x][y].value {
        case .Bomb:
          print("* ", terminator: "")
        case let .Empty(neighbours):
          switch neighbours {
          case 0:
            print(". ", terminator: "")
          default:
            print("\(neighbours) ", terminator: "")
          }
        }
      }
      print("")
    }
  }
}
