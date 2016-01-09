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
        column.append(BoardCell(coordinate: Coordinate(x, y), revealed: false, value: value))
      }
      newGrid.append(column)
    }
    self.grid = newGrid

    for y in 0..<height {
      for x in 0..<width where newGrid[x][y].value == CellValue.Bomb {
        self.enumerateNeighbours(Coordinate(x, y), operation: { (var cell) in
          cell.incrementNeighbourCount()
          return cell
        })
      }
    }
  }

  func cellAt(coordinate: Coordinate) -> BoardCell {
    assert(coordinate.x >= 0 && coordinate.x < self.width,
      "x parameter must be within range of board")
    assert(coordinate.y >= 0 && coordinate.y < self.height,
      "y parameter must be within range of board")

    return self.grid[coordinate.x][coordinate.y]
  }

  func accessNeighbours(coordinate: Coordinate, operation: (BoardCell) -> Void) {
    for y in (coordinate.y - 1)...(coordinate.y + 1) where y >= 0 && y < self.height {
      for x in (coordinate.x - 1)...(coordinate.x + 1) where x >= 0 && x < self.width {
        if !(x == coordinate.x && y == coordinate.y) {
          operation(self.cellAt(Coordinate(x, y)))
        }
      }
    }
  }

  mutating func enumerateNeighbours(coordinate: Coordinate, operation: (BoardCell) -> BoardCell) {
    for y in (coordinate.y - 1)...(coordinate.y + 1) where y >= 0 && y < self.height {
      for x in (coordinate.x - 1)...(coordinate.x + 1) where x >= 0 && x < self.width {
        if !(x == coordinate.x && y == coordinate.y) {
          let cell = operation(self.cellAt(Coordinate(x, y)))
          self.setCell(cell, coordinate: Coordinate(x, y))
        }
      }
    }
  }

  mutating func setCell(cell: BoardCell, coordinate: Coordinate) {
    self.grid[coordinate.x][coordinate.y] = cell
  }

  func revealedPrintToConsole() {
    for y in (0..<height).reverse() {
      for x in 0..<width {
        let cell = self.grid[x][y]
        switch cell.value {
        case .Bomb:
          print("* ", terminator: "")
        case let .Empty(neighbours):
          if neighbours == 0 {
            if cell.revealed {
              print("  ", terminator: "")
            }
            else {
              print(". ", terminator: "")
            }
          }
          else {
            print("\(neighbours) ", terminator: "")
          }
        }
      }
      print("")
    }
  }

  func hiddenPrintToConsole() {
    for y in (0..<height).reverse() {
      for x in 0..<width {
        let cell = self.grid[x][y]
        if cell.revealed {
          switch cell.value {
          case let .Empty(neighbours):
            if neighbours > 0 {
              print("\(neighbours) ", terminator: "")
            }
            else {
              print("  ", terminator: "")
            }
          case .Bomb:
            print("* ", terminator: "")
          }
        }
        else {
          print(". ", terminator: "")
        }
      }
      print("")
    }
  }
}
