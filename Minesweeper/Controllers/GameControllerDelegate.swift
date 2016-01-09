//
//  GameControllerDelegate.swift
//  Minesweeper
//
//  Created by Benjamin Lea on 8/01/2016.
//  Copyright © 2016 Benjamin Lea. All rights reserved.
//

import Foundation

protocol GameControllerDelegate {
  func cellRevealedAt(location: Coordinate)
  func gameOverOccurred()
}