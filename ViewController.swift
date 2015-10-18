//
//  ViewController.swift
//  moveNuNu
//
//  Created by dev on 9/28/15.
//  Copyright © 2015 ciccio boles. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    var currentValue: Int = 0
    var targetValue:Int = 0
    var score = 0
    var round = 0
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
        updateLabels()
        let thumbImageNormal = UIImage(named: "nunuslider4")
        slider.setThumbImage(thumbImageNormal, forState: .Normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func startNewRound() {
        round += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
    }
    
    func startNewGame() {
        score = 0
        round = 0
        startNewRound()
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
    @IBAction func startOver() {
        startNewGame()
        updateLabels()
        
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name:
            kCAMediaTimingFunctionEaseOut)
        view.layer.addAnimation(transition, forKey: nil)
        
        
    }
    
    @IBAction func showAlert() {
        let difference = abs(targetValue - currentValue)
        let points = 100 - difference
      //score = score + points
        let title: String
        if difference == 0 { title = "Perfect!"
        } else if difference < 5 {
        title = "You almost had it!"
        } else if difference < 10 {
        title = "Pretty good!"
        } else {
        title = "Not even close..."
        }
        score += points
        let message = "You scored \(points) points"
        let alert = UIAlertController(title: title,
            message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default,
            handler: { action in
            //self.startNewRound() c/o to prevent rounds skiping
            self.updateLabels()})
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
        startNewRound()
        //updateLabels() //c/o to prevent the taget value from changing during play
    
    }
    
    func sliderMoved(slider: UISlider) {
        currentValue = lroundf(slider.value)
    }
}
