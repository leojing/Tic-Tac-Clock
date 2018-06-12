//
//  TimerViewController.swift
//  Timer-Weather
//
//  Created by JINGLUO on 10/6/18.
//  Copyright © 2018 JINGLUO. All rights reserved.
//

import UIKit

class TimerViewController: BaseViewController {
    fileprivate enum SelectionType {
        case timer
        case minusButton
        case addButton
        
        func symbol() -> String {
            switch self {
            case .timer:
                return ""
                
            case .minusButton:
                return "-"
            
            case .addButton:
                return "+"
            }
        }
        
        func selectionValues() -> [Int] {
            switch self {
            case .timer:
                return [5, 10, 20, 40, 60]
                
            case .minusButton, .addButton:
                return [1, 2, 5, 10, 15]
            }
        }
    }
    
    @IBOutlet weak var selectionView: UIView!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet var selectionButtons: [UIButton]!
    
    var timer = Timer()
    fileprivate var longPressGesture = UILongPressGestureRecognizer()
    fileprivate var tapGesture = UITapGestureRecognizer()
    
    fileprivate var selectionType = SelectionType.timer
    
    fileprivate var countDown = 5
    fileprivate var minusUnit = 5
    fileprivate var addUnit = 5
    fileprivate let circleProgressBar = CircleProgressBar(frame: CGRect(x: 0, y: 0, width: 80, height: 80))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(startTimer))
        circleProgressBar.addGestureRecognizer(tapGesture)
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(selectInitialCountDown))
        circleProgressBar.addGestureRecognizer(longPressGesture)
        
        circleProgressBar.progress = countDown
        circleProgressBar.fullProgressNumber = countDown
        view.addSubview(circleProgressBar)
        
        minusButton.setTitle("-\(minusUnit)", for: .normal)
        addButton.setTitle("+\(addUnit)", for: .normal)
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
        
        selectionButtons.forEach { button in
            button.backgroundColor = buttonColor
        }
    }
    
    // MARK: Actions
    
    @objc fileprivate func startTimer() {
        var cd = countDown
        enableItems(false)
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.circleProgressBar.progress = cd
            if cd == -1 {
                self.timer.invalidate()
                self.timer = Timer()
                self.circleProgressBar.progress = self.countDown
                self.enableItems(true)
            }
            cd -= 1
        }
    }
    
    private func enableItems(_ isEnable: Bool) {
        minusButton.isEnabled = isEnable
        addButton.isEnabled = isEnable
        tapGesture.isEnabled = isEnable
        longPressGesture.isEnabled = isEnable
    }
    
    @objc fileprivate func selectInitialCountDown() {
        longPressGesture.isEnabled = false
        selectionView.isHidden = false
        configureSelctionType(.timer)
    }
    
    @IBAction func minusButtonLongPressAction(_ sender: Any) {
        selectionView.isHidden = false
        configureSelctionType(.minusButton)
    }
    
    @IBAction func addButtonLongPressAction(_ sender: Any) {
        selectionView.isHidden = false
        configureSelctionType(.addButton)
    }
    
    private func configureSelctionType(_ type: SelectionType) {
        selectionType = type
        selectionButtons.forEach { button in
            let values = self.selectionType.selectionValues()
            let title = "\(self.selectionType.symbol())\(values[button.tag])"
            button.setTitle(title, for: .normal)
        }
    }
    
    @IBAction func selectionAction(_ sender: Any) {
        let button = sender as! UIButton
        let values = selectionType.selectionValues()
        let selectedValue = values[button.tag]
        switch selectionType {
        case .timer:
            countDown = selectedValue
            circleProgressBar.progress = countDown
            circleProgressBar.fullProgressNumber = countDown
            
        case .minusButton:
            minusUnit = selectedValue
            
        case .addButton:
            addUnit = selectedValue
        }
        
        selectionView.isHidden = true
    }

    @IBAction func minusAction(_ sender: Any) {
        countDown = (countDown - minusUnit) < 0 ? 0 : (countDown - minusUnit)
        circleProgressBar.fullProgressNumber = countDown
        circleProgressBar.progress = countDown
    }
    
    @IBAction func addAction(_ sender: Any) {
        countDown += addUnit
        circleProgressBar.fullProgressNumber = countDown
        circleProgressBar.progress = countDown
    }
    
}
