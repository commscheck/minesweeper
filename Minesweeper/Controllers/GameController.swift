//
//  GameController.swift
//  Minesweeper
//
//  Created by Benjamin Lea on 13/12/2015.
//  Copyright © 2015 Benjamin Lea. All rights reserved.
//

import Foundation

class GameController {
  let board: GameBoard

  init(width: UInt, height: UInt) {
    board = GameBoard(width: width, height: height)
  }
}