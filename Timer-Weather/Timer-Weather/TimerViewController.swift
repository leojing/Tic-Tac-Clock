//
//  TimerViewController.swift
//  Timer-Weather
//
//  Created by JINGLUO on 10/6/18.
//  Copyright © 2018 JINGLUO. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox

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
    
    var objPlayer: AVAudioPlayer?

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
        
        circleProgressBar.progress = countDown * 60
        circleProgressBar.fullProgressNumber = countDown * 60
        view.addSubview(circleProgressBar)
        
        minusButton.setTitle("-\(minusUnit)'", for: .normal)
        addButton.setTitle("+\(addUnit)'", for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        circleProgressBar.center = CGPoint(x: view.center.x, y: view.center.y+50)
        setUpItemsColors()
    }
    
    fileprivate func setUpItemsColors() {
        var circleProgressColor: UIColor = .clear
        var progressColor: UIColor = .clear
        var buttonColor: UIColor = .clear
        let bgColor = Preferences.sharedInstance.getBackground()
        circleProgressColor = UIColor().hexStringToUIColor(hex: bgColor, r: 10, g: 0, b: 0, alpha: 1.0)
        progressColor = UIColor().hexStringToUIColor(hex: bgColor, r: 10, g: 20, b: 0, alpha: 1.0)
        buttonColor = UIColor().hexStringToUIColor(hex: bgColor, r: 10, g: 0, b: 0, alpha: 1.0)
        
        minusButton.backgroundColor = buttonColor
        addButton.backgroundColor = buttonColor
        
        circleProgressBar.circleBackgroundColor = circleProgressColor
        circleProgressBar.trackerColor = circleProgressColor
        circleProgressBar.progressColor = progressColor
        circleProgressBar.pulsingColor = progressColor
        
        selectionButtons.forEach { button in
            button.backgroundColor = buttonColor
        }
    }
    
    // MARK: Actions
    
    @objc fileprivate func startTimer() {
        selectionView.isHidden = true
        var cd = countDown * 60
        enableItems(false)
        circleProgressBar.animatePulsatingLayer()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.circleProgressBar.progress = cd
            if cd == -1 {
                self.timer.invalidate()
                self.timer = Timer()
                self.playAudioFile()
                self.circleProgressBar.progress = self.countDown * 60
                self.enableItems(true)
            }
            if cd == self.countDown * 60 {
                self.circleProgressBar.removeAnimatePulsatingLayer()
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
            button.setTitle("\(values[button.tag])'", for: .normal)
        }
    }
    
    @IBAction func selectionAction(_ sender: Any) {
        let button = sender as! UIButton
        let values = selectionType.selectionValues()
        let symbol = selectionType.symbol()
        let selectedValue = values[button.tag]
        let title = "\(symbol)\(selectedValue)'"
        switch selectionType {
        case .timer:
            countDown = selectedValue
            circleProgressBar.progress = countDown * 60
            circleProgressBar.fullProgressNumber = countDown * 60
            
        case .minusButton:
            minusUnit = selectedValue
            minusButton.setTitle(title, for: .normal)
            
        case .addButton:
            addUnit = selectedValue
            addButton.setTitle(title, for: .normal)
        }
        
        longPressGesture.isEnabled = true
        selectionView.isHidden = true
    }

    @IBAction func minusAction(_ sender: Any) {
        selectionView.isHidden = true
        countDown = (countDown - minusUnit) < 0 ? 0 : (countDown - minusUnit)
        circleProgressBar.fullProgressNumber = countDown * 60
        circleProgressBar.progress = countDown * 60
    }
    
    @IBAction func addAction(_ sender: Any) {
        selectionView.isHidden = true
        countDown += addUnit
        circleProgressBar.fullProgressNumber = countDown * 60
        circleProgressBar.progress = countDown * 60
    }
    
    @IBAction func tapOnEmptyViewAction(_ sender: Any) {
        selectionView.isHidden = true
        objPlayer?.stop()
    }
    
    fileprivate func playAudioFile() {
        //震动
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)

        //音效
        guard let url = Bundle.main.url(forResource: "soundName", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            objPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
        
            guard let aPlayer = objPlayer else { return }
            aPlayer.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
