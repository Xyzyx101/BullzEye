//
//  ViewController.swift
//  BullzEye
//
//  Created by Andrew Perrault on 2015-06-02.
//  Copyright (c) 2015 Andrew Perrault. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var currentValue: Int = 0
    var targetValue: Int = 0
    var score: Int = 0
    var round: Int = 0
    @IBOutlet weak var slider:UISlider!
    @IBOutlet weak var targetLabel:UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleSlider()
        sliderMoved(slider)
        startNewGame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startNewGame() {
        score = 0
        round = 0
        startNewRound()
    }
    
    func startNewRound() {
        do {
            targetValue = 5 + Int(arc4random_uniform(91))
        } while targetValue == 50
        currentValue = 50
        slider.value = Float(currentValue)
        round++
        updateLables()
    }
    
    @IBAction func showAlert() {
        let difference = abs(currentValue - targetValue)
        var points = 100 - difference
        let title: String!
        if difference == 0 {
            title = "Pefect! : "
            points += 100
        } else if difference < 7 {
            title = "You almost had it it :"
            points += 50
        } else if difference < 15 {
            title = "Meh : "
        } else if difference < 30 {
            title = "You suck at this game : "
            points = 0
        } else {
            title = "WTF! Are you drunk? : "
            points -= 1000
        }
        score += points
        let message = "The value of the slider is: \(currentValue)"
                    + "\nThe target value is: \(targetValue)"
                    + "\nThe difference is \(difference)"
        let alert = UIAlertController(
            title: title + String(points)
            , message: message
            , preferredStyle: .Alert
        )
        let action = UIAlertAction(
            title: "Ok"
            , style: .Default
            , handler: { action in self.startNewRound()}
        
        )
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func sliderMoved(slider: UISlider) {
        currentValue = lroundf(slider.value)
    }
    
    @IBAction func startOver() {
        startNewGame()
    }
    
    func updateLables() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
    func styleSlider() {
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, forState: .Normal)
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, forState: .Highlighted)
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        if let trackLeftImage = UIImage(named: "SliderTrackLeft") {
            let trackLeftResizable =
            trackLeftImage.resizableImageWithCapInsets(insets)
            slider.setMinimumTrackImage(trackLeftResizable, forState: .Normal)
        }
        if let trackRightImage = UIImage(named: "SliderTrackRight") {
            let trackRightResizable = trackRightImage.resizableImageWithCapInsets(insets)
            slider.setMaximumTrackImage(trackRightResizable, forState: .Normal)
        }
    }
}

