//
//  MainViewController.swift
//  Timer-Weather
//
//  Created by JINGLUO on 19/3/18.
//  Copyright © 2018 JINGLUO. All rights reserved.
//

import UIKit
import HGCircularSlider

class MainViewController: BaseViewController {
    
    @IBOutlet private weak var flipClockContainer: UIView!
    @IBOutlet private weak var circleTimerView: UIView!
    
    @IBOutlet private weak var clockViewTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var clockView: AnalogClockView!
    @IBOutlet private weak var smallClockView: AnalogClockView!
    @IBOutlet private weak var dateInWatchLabel: UILabel!
    
    @IBOutlet private weak var digitalTimerView: UIView!
    @IBOutlet private weak var digitalTimerHourLabel: UILabel!
    @IBOutlet private weak var digitalTimerMinLabel: UILabel!
    @IBOutlet private weak var digitalTimerHeightConstraint: NSLayoutConstraint!

    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var dateLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var dateLabelHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var weatherLocationView: UIView!

    @IBOutlet private weak var countDownTimerContainer: UIView!
    @IBOutlet private weak var guideView: UIView!
    
    var viewModel: MainViewModel = MainViewModel() {
        didSet {
            setupViewModel()
        }
    }
    
    private enum Constants {
        static let digitalTimerHeightForPhone = 120
        static let digitalTimerHeightForPad = 190
        static let circleTimerHeight = 200
        static let dateLabelHeightForPhone = 30
        static let dateLabelHeightForPad = 40
        static let weatherCollectionWidth = 70
        static let weatherCollectionHeight = 70
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "RotateDevice"), object: nil, userInfo: ["isLandscape": UIDevice.current.orientation.isLandscape])

        navigationController?.interactivePopGestureRecognizer?.delegate = self

        NotificationCenter.default.addObserver(self, selector: #selector(triggleTimer), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        adjustFontByDevice(viewModel.isPad)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        rotateDevice()
        
        let isShowGuiderView = Preferences.sharedInstance.getIsShowGuideView()
        guideView.isHidden = !isShowGuiderView
        
        if Preferences.sharedInstance.getDisabelIdleTimer() {
            UIApplication.shared.isIdleTimerDisabled = Preferences.sharedInstance.getDisabelIdleTimer()
            Timer.scheduledTimer(withTimeInterval: 10, repeats: false) { _ in
                UIScreen.main.brightness = 0.5
            }
        }

        let bgColor = Preferences.sharedInstance.getBackground()
        self.view.backgroundColor = UIColor().hexStringToUIColor(hex: bgColor)

        updateWatchFace()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        rotateDevice()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func rotateDevice() {
        if viewModel.isPad { return }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "RotateDevice"), object: nil, userInfo: ["isLandscape": UIDevice.current.orientation.isLandscape])
        
        if UIDevice.current.orientation.isLandscape {
            clockViewTopConstraint.constant = -70
        } else {
            clockViewTopConstraint.constant = 30
        }
        view.layoutIfNeeded()
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "flipClock":
                if let vc = segue.destination as? FlipClockViewController {
                    vc.viewModel = viewModel
                }
                
            case "weatherLocation":
                if let vc = segue.destination as? WeatherLocationViewController {
                    vc.viewModel = viewModel
                }
                
            default:
                break
            }
        }
    }
    
    // MARK: UI update
    fileprivate func updateWatchFace() {
        
        let watchfaceIndex = Preferences.sharedInstance.getWatchFace()
        if watchfaceIndex >= 8 {
            let height = viewModel.isPad ? Constants.dateLabelHeightForPad : Constants.dateLabelHeightForPhone
            dateLabelHeightConstraint.constant = CGFloat(Preferences.sharedInstance.getShowDate() ? height : 0)
        } else {
            dateLabelHeightConstraint.constant = CGFloat(0)
        }
        
        if watchfaceIndex == 8 {
            digitalTimerHeightConstraint.constant = CGFloat(viewModel.isPad ? Constants.digitalTimerHeightForPad : Constants.digitalTimerHeightForPhone)
            circleTimerView.isHidden = true
            flipClockContainer.isHidden = true
            digitalTimerView.isHidden = false
            dateLabelTopConstraint.constant = 20
        } else {
            digitalTimerView.isHidden = true
            if watchfaceIndex == 9 {
                flipClockContainer.isHidden = false
                circleTimerView.isHidden = true
                dateLabelTopConstraint.constant = 280
            } else {
                circleTimerView.isHidden = false
                flipClockContainer.isHidden = true
            }
            let watchFaces = SelectionType.getContentList(.watchFace)
            let watchfaceIndex = Preferences.sharedInstance.getWatchFace()
            clockView.backgroundImageView.image = UIImage(named: watchFaces()![watchfaceIndex]!)
            if watchfaceIndex > 4  && watchfaceIndex < 8 {
                clockView.smallialImageView?.image = UIImage(named: "upper-dial-light")
                smallClockView.smallialImageView?.image = UIImage(named: "bottom-dial-light")
                smallClockView.secondHand.image = UIImage(named: "bottom-dial-second-light")
            } else {
                clockView.smallialImageView?.image = UIImage(named: "upper-dial")
                smallClockView.smallialImageView?.image = UIImage(named: "bottom-dial")
                smallClockView.secondHand.image = UIImage(named: "bottom-dial-second")
            }
        }
    }
    
    
    fileprivate func adjustFontByDevice(_ isPad: Bool) {
        if isPad {
            digitalTimerMinLabel.font = UIFont(name: "Courier New", size: 110)
            digitalTimerHourLabel.font = UIFont(name: "Courier New", size: 110)
            dateLabel.font = UIFont.systemFont(ofSize: 30, weight: .light)
        } else {
            digitalTimerMinLabel.font = UIFont(name: "Courier New", size: 64)
            digitalTimerHourLabel.font = UIFont(name: "Courier New", size: 64)
            dateLabel.font = UIFont.systemFont(ofSize: 20, weight: .light)
        }
    }

    // MARK: Bind ViewModel
    fileprivate func setupViewModel() {
        
        viewModel.currentDigitalTimeDidUpdate = { timer in
            DispatchQueue.main.async {
                var index = timer.index(timer.startIndex, offsetBy: 2)
                self.digitalTimerHourLabel.text = String(timer.prefix(upTo: index))
                index = timer.index(timer.endIndex, offsetBy: -2)
                self.digitalTimerMinLabel.text = ":\(String(timer.suffix(from: index)))"
            }
        }
        
        viewModel.currentDateDidUpdate = { date in
            DispatchQueue.main.async {
                let attributedString = NSMutableAttributedString(string: (date.dayOfWeekShort()?.uppercased())!)
                attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.orange, range: NSRange(location: 4, length: 2))
                let watchfaceIndex = Preferences.sharedInstance.getWatchFace()
                if watchfaceIndex < 5 {
                    attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: 3))
                } else {
                    attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: 3))
                }
                self.dateInWatchLabel.attributedText = attributedString
                
                self.dateLabel.text = date.dayOfWeek(Preferences.sharedInstance.getDateFormat())
                
                self.clockView.setTimeToDate(date, false)
                self.smallClockView.setTimeToDate(date, false)
            }
        }

        viewModel.showAlert = { message in
            let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
            alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    // MARK: Actions
    
    @IBAction func swipeGestureAction(_ sender: Any?) {
        // Switch off Count down feature
        return
        
        if !guideView.isHidden {
            guideViewTapped(nil)
        }

        countDownTimerContainer.isHidden = !countDownTimerContainer.isHidden
        countDownTimerContainer.isHidden ? NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AllowRotation"), object: nil)
            : NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NotAllowRotation"), object: nil)
    }
    
    @IBAction func shareAction(_ sender: Any?) {
        let appURL = URL(string: "https://itunes.apple.com/us/app/tic-tac-clock/id1312810639?mt=8&ign-mpt=uo%3D2")!
        let vc = UIActivityViewController(activityItems: [appURL], applicationActivities: [])
        vc.popoverPresentationController?.sourceView = view
        present(vc, animated: true)
    }
    
    @objc
    fileprivate func triggleTimer() {
        viewModel.currentDate = Date()
    }
    
    @IBAction func guideViewTapped(_ sender: Any?) {
        Preferences.sharedInstance.setIsShowGuideView(false)
        guideView.isHidden = true
    }
}

// MARK: - Utilis

extension MainViewController {
    
    fileprivate func getHourDigital(_ date: String) -> CGFloat {
        let offset2Index = date.index(date.startIndex, offsetBy: 2)
        let subStringToHour = String(date[..<offset2Index])
        return CGFloat(Double(subStringToHour) ?? 0)
    }
    
    fileprivate func getMinDigital(_ date: String) -> CGFloat {
        let startIndex = date.index(date.startIndex, offsetBy: 3)
        let offset2Index = date.index(startIndex, offsetBy: 2)
        let subStringToMin = String(date[startIndex..<offset2Index])
        return CGFloat(Double(subStringToMin) ?? 0)
    }
}

extension MainViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
