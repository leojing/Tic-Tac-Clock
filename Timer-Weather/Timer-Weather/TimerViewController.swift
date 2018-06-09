//
//  TimerViewController.swift
//  Timer-Weather
//
//  Created by JINGLUO on 10/6/18.
//  Copyright © 2018 JINGLUO. All rights reserved.
//

import UIKit

class TimerViewController: BaseViewController {
    
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var addButton: UIButton!

    let circleProgressBar = CircleProgressBar(frame: CGRect(x: 0, y: 0, width: 80, height: 80))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        circleProgressBar.progress = 5
        circleProgressBar.fullProgressNumber = 5
        view.addSubview(circleProgressBar)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        circleProgressBar.center = CGPoint(x: view.center.x, y: view.center.y-20)
        setUpItemsColors()
    }
    
    fileprivate func setUpItemsColors() {
        var circleProgressColor: UIColor = .clear
        var progressColor: UIColor = .clear
        var buttonColor: UIColor = .clear
        if let bgColor = Preferences.sharedInstance.getBackground() {
            circleProgressColor = UIColor().hexStringToUIColor(hex: bgColor, r: 10, g: 0, b: 0, alpha: 1.0)
            progressColor = UIColor().hexStringToUIColor(hex: bgColor, r: 10, g: 20, b: 0, alpha: 1.0)
            buttonColor = UIColor().hexStringToUIColor(hex: bgColor, r: 10, g: 0, b: 0, alpha: 1.0)
        }
        
        minusButton.backgroundColor = buttonColor
        addButton.backgroundColor = buttonColor
        
        circleProgressBar.circleBackgroundColor = circleProgressColor
        circleProgressBar.trackerColor = circleProgressColor
        circleProgressBar.progressColor = progressColor
    }
}
