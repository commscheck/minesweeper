//
//  GameBoard.swift
//  Minesweeper
//
//  Created by Benjamin Lea on 13/12/2015.
//  Copyright © 2015 Benjamin Lea. All rights reserved.
//

import Foundation

struct GameBoard {
  let width: UInt
  let height: UInt
  let grid: [[BoardCell]]

  init(width: UInt = 10, height: UInt = 10) {
    self.width = width
    self.height = height

    var newGrid: [[BoardCell]] = []
    for _ in 0..<width {
      var column = [BoardCell]()
      for _ in 0..<height {
        column.append(BoardCell())
      }
      newGrid.append(column)
    }
    self.grid = newGrid
  }
}
