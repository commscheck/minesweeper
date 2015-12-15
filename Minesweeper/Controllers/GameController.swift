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
    assert(location.x >= 0 && location.x < board.width,
      "x parameter must be within range of board")
    assert(location.y >= 0 && location.y < board.height,
      "y parameter must be within range of board")

    board.grid[location.x][location.y].revealed = true
  }
}
