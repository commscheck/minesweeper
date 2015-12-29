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

  init(width: Int, height: Int) {
    board = GameBoard(width: width, height: height)
  }

  func revealCellAt(location: Coordinate) {
    if var cell: BoardCell = self.board.cellAt(location) {
      cell.revealed = true
      self.board.setCell(cell, coordinate: location)

      switch cell.value {
      case .Empty(neighbours: 0):
        break
      default:
        break
      }
    }
  }
}
