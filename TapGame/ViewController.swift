//
//  ViewController.swift
//  TapGame
//
//  Created by Vyacheslav on 1/16/21.
//  Copyright © 2021 Vyacheslav. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var gameFieldView: GameFieldView!
    
    
    @IBOutlet weak var gameControl: GameControlViewClass!
    
    func actionButtonTapped() {
        if gameControl.isGameActive {
            stopGame()
        } else {
            startGame()
        }
    }
    
    
    private var displayDuration: TimeInterval = 2
    
    private var gameTimer: Timer?
    
    private var timer: Timer?
    
    private var score = 0
    

    
    @IBOutlet weak var scoreLabel: UILabel!
    
    private func startGame(){
        score = 0
        repositionImageWithTimer()
        gameTimer?.invalidate()
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(gameTimerTick), userInfo: nil, repeats: true)
        
        gameControl.gameTimeLeft = gameControl.gameDuration
        gameControl.isGameActive = true
        updateUI()
    }
    
    private func stopGame(){
        gameControl.isGameActive = false
        updateUI()
        gameTimer?.invalidate()
        timer?.invalidate()
        scoreLabel.text = "Last score: \(score)"
    }
    
    func objectTapped() {
        guard gameControl.isGameActive else {
            return
        }
        
        repositionImageWithTimer()
        score += 1
    }
    
    func updateUI(){
        gameFieldView.isShapeHidden = !gameControl.isGameActive

    }
    
    @objc private func gameTimerTick() {
        gameControl.gameTimeLeft -= 1
        if gameControl.gameTimeLeft <= 0 {
            stopGame()
        } else {
            updateUI()
        }
    }
    
    @objc private func moveImage() {
        gameFieldView.randomizeShapes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameFieldView.layer.borderWidth = 1
        gameFieldView.layer.borderColor = UIColor.gray.cgColor
        gameFieldView.layer.cornerRadius = 5
        
        updateUI()
        gameFieldView.shapeHitHandler = { [weak self] in
            self?.objectTapped()
        }
        
        gameControl.startStopHandler = { [weak self] in
            self?.actionButtonTapped()

        }
        gameControl.gameDuration = 20
    }


    private func repositionImageWithTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: displayDuration, target: self, selector: #selector(moveImage), userInfo: nil, repeats: true)
        
        timer?.fire()
        
    }
}

