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
    
    @IBOutlet private weak var flipClockView: FlipClockView?
    
    @IBOutlet private weak var analogClockViewTopConstraint: NSLayoutConstraint?
    @IBOutlet private weak var analogClockView: AnalogClockView?
    
    @IBOutlet private weak var digitalClockView: DigitalClockView?
    @IBOutlet private weak var digitalClockHeightConstraint: NSLayoutConstraint?

    @IBOutlet private weak var dateLabel: UILabel?
    @IBOutlet private weak var dateLabelTopConstraint: NSLayoutConstraint?
    @IBOutlet private weak var dateLabelHeightConstraint: NSLayoutConstraint?
    
    @IBOutlet private weak var timerSettingView: TimerSettingView? {
        didSet {
            timerSettingView?.isHidden = true
        }
    }

    @IBOutlet private weak var weatherLocationView: WeatherLocationView?
    
    @IBOutlet private weak var guideView: UIView?
    
    var viewModel: MainViewModel? {
        didSet {
            setupViewModel()
        }
    }
    
    private enum Constants {
        static let digitalTimerHeightForPhone = 120
        static let digitalTimerHeightForPad = 190
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
        
        viewModel = MainViewModel()
        adjustFontByDevice(viewModel?.isPad ?? false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        rotateDevice()
        
        let isShowGuiderView = Preferences.sharedInstance.getIsShowGuideView()
        guideView?.isHidden = !isShowGuiderView
        
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
        if viewModel?.isPad ?? false { return }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "RotateDevice"), object: nil, userInfo: ["isLandscape": UIDevice.current.orientation.isLandscape])
        
        if UIDevice.current.orientation.isLandscape {
            analogClockViewTopConstraint?.constant = -70
        } else {
            analogClockViewTopConstraint?.constant = 30
        }
        view.layoutIfNeeded()
    }
    
    // MARK: UI update
    func updateWatchFace() {
        
        let watchfaceIndex = Preferences.sharedInstance.getWatchFace()
        if watchfaceIndex >= 8 {
            let height = (viewModel?.isPad ?? false) ? Constants.dateLabelHeightForPad : Constants.dateLabelHeightForPhone
            dateLabelHeightConstraint?.constant = CGFloat(Preferences.sharedInstance.getShowDate() ? height : 0)
        } else {
            dateLabelHeightConstraint?.constant = CGFloat(0)
        }
        
        if watchfaceIndex == 8 {
            digitalClockHeightConstraint?.constant = CGFloat((viewModel?.isPad ?? false) ? Constants.digitalTimerHeightForPad : Constants.digitalTimerHeightForPhone)
            analogClockView?.isHidden = true
            flipClockView?.isHidden = true
            digitalClockView?.isHidden = false
            dateLabelTopConstraint?.constant = 20
        } else {
            digitalClockView?.isHidden = true
            if watchfaceIndex == 9 {
                flipClockView?.isHidden = false
                analogClockView?.isHidden = true
                dateLabelTopConstraint?.constant = 280
            } else {
                analogClockView?.isHidden = false
                flipClockView?.isHidden = true
            }
            let watchFaces = SelectionType.getContentList(.watchFace)() ?? []
            analogClockView?.watchFace = watchFaces[watchfaceIndex]
            if watchfaceIndex > 4  && watchfaceIndex < 8 {
                analogClockView?.isDarkTheme = true
            } else {
                analogClockView?.isDarkTheme = false
            }
        }
    }
    
    
    fileprivate func adjustFontByDevice(_ isPad: Bool) {
        if isPad {
            dateLabel?.font = UIFont.systemFont(ofSize: 30, weight: .light)
        } else {
            dateLabel?.font = UIFont.systemFont(ofSize: 20, weight: .light)
        }
    }

    // MARK: Bind ViewModel
    fileprivate func setupViewModel() {
        
        viewModel?.currentDateDidUpdate = { date in
            DispatchQueue.main.async {
                self.digitalClockView?.setClockWithDate(date, animated: false)
                self.analogClockView?.setClockWithDate(date, animated: false)
                self.flipClockView?.setClockWithDate(date, animated: false)
            }
        }

        viewModel?.showAlert = { message in
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
        
//        if !guideView?.isHidden {
//            guideViewTapped(nil)
//        }
//
//        countDownTimerContainer?.isHidden = !countDownTimerContainer.isHidden
//        countDownTimerContainer?.isHidden ? NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AllowRotation"), object: nil)
//            : NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NotAllowRotation"), object: nil)
    }
    
    @IBAction func shareAction(_ sender: Any?) {
        let appURL = URL(string: "https://itunes.apple.com/us/app/tic-tac-clock/id1312810639?mt=8&ign-mpt=uo%3D2")!
        let vc = UIActivityViewController(activityItems: [appURL], applicationActivities: [])
        vc.popoverPresentationController?.sourceView = view
        present(vc, animated: true)
    }
    
    @objc
    fileprivate func triggleTimer() {
        viewModel?.currentDate = Date()
    }
    
    @IBAction func guideViewTapped(_ sender: Any?) {
        Preferences.sharedInstance.setIsShowGuideView(false)
        guideView?.isHidden = true
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
