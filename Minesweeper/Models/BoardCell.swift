//
//  BoardCell.swift
//  Minesweeper
//
//  Created by Benjamin Lea on 13/12/2015.
//  Copyright © 2015 Benjamin Lea. All rights reserved.
//

import Foundation

enum CellValue: Equatable {
  case Bomb
  case Empty(neighbours: UInt)
}

func ==(a: CellValue, b: CellValue) -> Bool {
  switch (a, b) {
  case (.Bomb, .Bomb): return true
  case (.Empty(let a), .Empty(let b)) where a == b: return true
  default: return false
  }
}

struct BoardCell {
  var revealed = false
  var value: CellValue

  mutating func incrementNeighbourCount() {
    switch self.value {
    case let .Empty(neighbours):
      self.value = .Empty(neighbours: neighbours + 1)
    default:
      break
    }
  }
}
