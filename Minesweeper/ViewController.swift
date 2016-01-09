//
//  ViewController.swift
//  Minesweeper
//
//  Created by Benjamin Lea on 13/12/2015.
//  Copyright © 2015 Benjamin Lea. All rights reserved.
//

import UIKit

class ViewController: UIViewController, GameControllerDelegate {
  @IBOutlet var xStepper: UIStepper!
  @IBOutlet var yStepper: UIStepper!
  @IBOutlet var xLabel: UILabel!
  @IBOutlet var yLabel: UILabel!

  let game: GameController

  required convenience init?(coder aDecoder: NSCoder) {
    self.init(aDecoder)
  }

  init?(_ coder: NSCoder? = nil) {
    game = GameController(width: 30, height: 20, bombs: 40)

    if let coder = coder {
      super.init(coder: coder)
    }
    else {
      super.init(nibName: nil, bundle:nil)
    }
    game.delegate = self
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    game.board.revealedPrintToConsole()
    game.board.hiddenPrintToConsole()

    self.xStepper.minimumValue = 1
    self.xStepper.maximumValue = Double(game.board.width)
    self.yStepper.minimumValue = 1
    self.yStepper.maximumValue = Double(game.board.height)
  }

  @IBAction func xStepperChanged(sender: UIStepper) {
    self.xLabel.text = "X: \(self.xStepper.value)"
  }

  @IBAction func yStepperChanged(sender: UIStepper) {
    self.yLabel.text = "Y: \(self.yStepper.value)"
  }
  
  @IBAction func revealButtonTapped(sender: UIButton) {
    game.revealCellAt(Coordinate(Int(xStepper.value - 1), Int(yStepper.value - 1)))
    game.board.hiddenPrintToConsole()
  }

  func cellRevealedAt(location: Coordinate) {
    usleep(30000)
    game.board.hiddenPrintToConsole()
  }

  func gameOverOccurred() {

  }
}

