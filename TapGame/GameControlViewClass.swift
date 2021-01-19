//
//  GameControlViewClass.swift
//  TapGame
//
//  Created by Vyacheslav on 1/18/21.
//  Copyright © 2021 Vyacheslav. All rights reserved.
//

import UIKit

@IBDesignable
class GameControlViewClass: UIView {
    
    
    @IBInspectable var gameTimeLeft: Double = 7 {
        didSet{
            updateUI()
        }
    }
    
    @IBInspectable var isGameActive: Bool = false {
        didSet{
            updateUI()
        }
    }
    
    @IBInspectable var gameDuration: Double {
        get {
            return stepper.value
        }
        
        set {
            stepper.value = newValue
            updateUI()
        }
    }
    
    var startStopHandler: (() -> Void)?
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var stepper: UIStepper!
    
    @IBOutlet weak var actionButton: UIButton!
    
    
    @IBAction func stepperChanged(_ sender: UIStepper) {
        updateUI()
    }
    
    @IBAction func actionButtonTapped(_ sender: UIButton) {
        startStopHandler?()
    }
    
    
    private func loadViewFromXib() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        
        let nib = UINib(nibName: "GameControlView", bundle: bundle)
        
        return nib.instantiate(withOwner: self, options: nil).first! as! UIView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private func setupViews() {
        let xibView = loadViewFromXib()
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, . flexibleHeight]
        self.addSubview(xibView)
    }
    
    
    func updateUI(){
        stepper.isEnabled = !isGameActive
        if isGameActive {
            actionButton.setTitle("Stop", for: .normal)
            timeLabel.text = "Time: \(Int(gameTimeLeft)) seconds"
        } else {
            actionButton.setTitle("Start", for: .normal)
            timeLabel.text = "Time: \(Int(stepper.value)) seconds"
        }
    }
    
    
}
