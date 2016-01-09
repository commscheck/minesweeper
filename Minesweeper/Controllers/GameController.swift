//
//  GameController.swift
//  Minesweeper
//
//  Created by Benjamin Lea on 13/12/2015.
//  Copyright © 2015 Benjamin Lea. All rights reserved.
//

import Foundation

class GameController {
  var board: GameBoard
  var delegate: GameControllerDelegate?

  init(width: Int, height: Int, bombs: Int) {
    board = GameBoard(width: width, height: height, bombs: bombs)
  }

  func revealCellAt(location: Coordinate) {
    if var cell: BoardCell = board.cellAt(location) {
      if cell.revealed == true {
        return
      }
      cell.revealed = true
      board.setCell(cell, coordinate: location)

      delegate?.cellRevealedAt(location)

      switch cell.value {
      case .Empty(neighbours: 0):
        board.accessNeighbours(location, operation: { (cell) in
          self.revealCellAt(cell.coordinate)
        })
      case .Bomb:
        delegate?.gameOverOccurred()
      default:
        break
      }
    }
  }

  func revealNeighbours(location: Coordinate) {
    let x = location.x
    let y = location.y
    if x > 0 {
      revealCellAt(Coordinate(x - 1, y))
    }
    if y > 0 {
      revealCellAt(Coordinate(x, y - 1))
    }
    if x < board.width - 1 {
      revealCellAt(Coordinate(x + 1, y))
    }
    if y < board.height - 1 {
      revealCellAt(Coordinate(x, y + 1))
    }
  }
}
