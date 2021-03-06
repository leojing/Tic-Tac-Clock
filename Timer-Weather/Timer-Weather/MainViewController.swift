//
//  MainViewController.swift
//  Timer-Weather
//
//  Created by JINGLUO on 19/3/18.
//  Copyright © 2018 JINGLUO. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import HGCircularSlider

class MainViewController: BaseViewController {
    
    @IBOutlet weak var flipClockView: FlipClockView!

    @IBOutlet weak var circleTimerView: UIView!
    
    @IBOutlet weak var clockViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var clockView: AnalogClockView!
    @IBOutlet weak var smallClockView: AnalogClockView!
    @IBOutlet weak var dateInWatchLabel: UILabel!
    
    @IBOutlet weak var digitalTimerView: UIView!
    @IBOutlet weak var digitalTimerHourLabel: UILabel!
    @IBOutlet weak var digitalTimerMinLabel: UILabel!
    @IBOutlet weak var digitalTimerHeightConstraint: NSLayoutConstraint!

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var dateLabelHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var weatherStackView: UIStackView!
    @IBOutlet var dailyViews: [DailyCollectionViewCell]!

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var spinnerView: UIActivityIndicatorView!
    @IBOutlet weak var refreshButton: UIButton!

    @IBOutlet weak var countDownTimerView: UIView!
    @IBOutlet weak var guideView: UIView!
    
    fileprivate let disposeBag = DisposeBag()
    var viewModel: MainViewModel? {
        didSet {
            setupViewModelBinds()
        }
    }
    fileprivate let apiService = APIClient()
    fileprivate var timer = Timer()
    
    fileprivate var isPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
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
        
        viewModel = MainViewModel(apiService)

        navigationController?.interactivePopGestureRecognizer?.delegate = self

        NotificationCenter.default.addObserver(self, selector: #selector(triggleTimer), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
        
        adjustFontByDevice(isPad)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        refreshAction(nil)
        rotateDevice()
        
        timer = Timer.scheduledTimer(withTimeInterval: 2*60*60, repeats: true) { _ in
            self.refreshAction(nil)
        }
        
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
        updateWeather()
        
        let isShowLocation = Preferences.sharedInstance.getShowLocation()
        cityNameLabel.isHidden = !isShowLocation
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        rotateDevice()
    }
    
    private func rotateDevice() {
        if isPad { return }
        
        if UIDevice.current.orientation.isLandscape {
            clockViewTopConstraint.constant = -70
        } else {
            clockViewTopConstraint.constant = 30
        }
        view.layoutIfNeeded()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        timer.invalidate()
    }
    
    // MARK: UI update
    fileprivate func updateWatchFace() {
        
        let watchfaceIndex = Preferences.sharedInstance.getWatchFace()
        if watchfaceIndex >= 8 {
            let height = isPad ? Constants.dateLabelHeightForPad : Constants.dateLabelHeightForPhone
            dateLabelHeightConstraint.constant = CGFloat(Preferences.sharedInstance.getShowDate() ? height : 0)
        } else {
            dateLabelHeightConstraint.constant = CGFloat(0)
        }
        
        if watchfaceIndex == 8 {
            digitalTimerHeightConstraint.constant = CGFloat(isPad ? Constants.digitalTimerHeightForPad : Constants.digitalTimerHeightForPhone)
            circleTimerView.isHidden = true
            flipClockView.isHidden = true
            digitalTimerView.isHidden = false
            dateLabelTopConstraint.constant = 20
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AllowRotation"), object: nil)
        } else {
            digitalTimerView.isHidden = true
            if watchfaceIndex == 9 {
                flipClockView.isHidden = false
                circleTimerView.isHidden = true
                dateLabelTopConstraint.constant = 230
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NotAllowRotation"), object: nil)
            } else {
                circleTimerView.isHidden = false
                flipClockView.isHidden = true
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AllowRotation"), object: nil)
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
    
    fileprivate func updateWeather() {
        let isShowWeather = Preferences.sharedInstance.getShowWeather()
        weatherStackView.isHidden = !isShowWeather
        
        let isShow5DaysWeather = Preferences.sharedInstance.getShow5DaysWeather()
        if let data = viewModel?.mutipleDaysData.value {
            if isShow5DaysWeather {
                viewModel?.dailyData.value = data
                dailyViews.forEach({ view in
                    view.isHidden = false
                })
            } else {
                viewModel?.dailyData.value = data
                dailyViews.enumerated().forEach({ (index, view) in
                    view.isHidden = !(index == 0)
                })
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
    fileprivate func setupViewModelBinds() {
        
        viewModel?.currentDigitalTime.asObservable()
            .subscribe(onNext: { timer in
                var index = timer.index(timer.startIndex, offsetBy: 2)
                self.digitalTimerHourLabel.text = String(timer.prefix(upTo: index))
                index = timer.index(timer.endIndex, offsetBy: -2)
                self.digitalTimerMinLabel.text = ":\(String(timer.suffix(from: index)))"
            }, onError: nil, onCompleted: nil, onDisposed: nil)
        .disposed(by: disposeBag)
        
        viewModel?.currentDate.asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { date in
                let attributedString = NSMutableAttributedString(string: (date.dayOfWeekShort()?.uppercased())!)
                attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.orange, range: NSRange(location: 4, length: 2))
                let watchfaceIndex = Preferences.sharedInstance.getWatchFace()
                if watchfaceIndex < 5 {
                    attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: 3))
                } else {
                    attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: 3))
                }
                self.dateInWatchLabel.attributedText = attributedString

                self.dateLabel.text = date.dayOfWeek(Preferences.sharedInstance.getDateFormat())

                self.clockView.setTimeToDate(date, false)
                self.smallClockView.setTimeToDate(date, false)
                
                self.flipClockView.setTimeToDate(date, false)
            }, onError: nil, onCompleted: nil, onDisposed: nil)
        .disposed(by: disposeBag)
        
        viewModel?.cityName.asObservable()
        .bind(to: self.cityNameLabel.rx.text)
        .disposed(by: disposeBag)
        
        // MARK: bind Top info view and background theme color by currently weather data
        viewModel?.weather.asObservable()
            .filter{$0 != nil}
            .subscribe(onNext: { w in
                NSLog("Weather info is \(String(describing: w?.currently?.summary))")
            }, onError: { error in
                print(error.localizedDescription)
            }, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
        
        // MARK: bind spinner view
        viewModel?.isLoading.asObservable()
            .subscribe(onNext: { loading in
                DispatchQueue.main.async {
                    if loading {
                        self.weatherStackView.isHidden = true
                        self.refreshButton.isHidden = true
                    }
                    loading ? self.spinnerView.startAnimating() : self.spinnerView.stopAnimating()
                }
            }, onError: nil, onCompleted: nil, onDisposed: nil)
        .disposed(by: disposeBag)
        
        // MARK: bind daily data with daysWeatherCollectionView
        viewModel?.dailyData.asObservable()
            .filter { $0.count > 0 }
            .subscribe(onNext: { data in
                DispatchQueue.main.async {
                    self.weatherStackView.isHidden = false
                    self.refreshButton.isHidden = true
                }
                data.enumerated().forEach({ (index, detail) in
                    let dailyView = self.dailyViews[index]
                    dailyView.configureCell(detail)
                })
            }, onError: nil, onCompleted: nil, onDisposed: nil)
        .disposed(by: disposeBag)
        
       // MARK: show error message
        viewModel?.alertMessage.asObservable()
            .filter { $0.count > 0 }
            .subscribe(onNext: { errorMessage in
                DispatchQueue.main.async {
                    self.weatherStackView.isHidden = true
                    self.refreshButton.isHidden = false
                }
            }, onError: nil, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
    }
    
    // MARK: Actions
    
    @IBAction func swipeGestureAction(_ sender: Any?) {
        // Switch off Count down feature
        return
        
        if !guideView.isHidden {
            guideViewTapped(nil)
        }

        countDownTimerView.isHidden = !countDownTimerView.isHidden
        countDownTimerView.isHidden ? NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AllowRotation"), object: nil)
            : NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NotAllowRotation"), object: nil)

    }
    
    fileprivate func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func refreshAction(_ sender: Any?) {
        viewModel?.setupLocationManager()
        refreshButton.isHidden = true
    }
    
    @IBAction func shareAction(_ sender: Any?) {
        let appURL = URL(string: "https://itunes.apple.com/us/app/tic-tac-clock/id1312810639?mt=8&ign-mpt=uo%3D2")!
        let vc = UIActivityViewController(activityItems: [appURL], applicationActivities: [])
        vc.popoverPresentationController?.sourceView = view
        present(vc, animated: true)
    }
    
    @objc
    fileprivate func triggleTimer() {
        viewModel?.currentDate.value = Date()
        refreshAction(nil)
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
