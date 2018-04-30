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
    
    @IBOutlet weak var circleTimerView: UIView!
    @IBOutlet weak var circleTimerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var clockView: AnalogClockView!
    @IBOutlet weak var smallClockView: AnalogClockView!
    @IBOutlet weak var dateInWatchLabel: UILabel!
    
    @IBOutlet weak var digitalTimerView: UIView!
    @IBOutlet weak var digitalTimerHourLabel: UILabel!
    @IBOutlet weak var digitalTimerMinLabel: UILabel!
    @IBOutlet weak var digitalTimerHeightConstraint: NSLayoutConstraint!

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateLabelHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var weatherStackView: UIStackView!
    @IBOutlet var dailyViews: [DailyCollectionViewCell]!

    @IBOutlet weak var cityNameLabel: UILabel!
    
    fileprivate let disposeBag = DisposeBag()
    var viewModel: MainViewModel? {
        didSet {
            setupViewModelBinds()
        }
    }

    private enum Constants {
        static let digitalTimerHeight = 120
        static let circleTimerHeight = 200
        static let dateLabelHeight = 30
        static let weatherCollectionWidth = 70
        static let weatherCollectionHeight = 70
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = MainViewModel(APIClient())

        NotificationCenter.default.addObserver(self, selector: #selector(triggleTimer), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let bgColor = SettingsViewModel.sharedInstance.getBackground() {
            self.view.backgroundColor = UIColor().hexStringToUIColor(hex: bgColor)
        }

        if let watchfaceIndex = SettingsViewModel.sharedInstance.getWatchFace(), watchfaceIndex == 0 {
            circleTimerHeightConstraint.constant = CGFloat(Constants.circleTimerHeight)
            digitalTimerHeightConstraint.constant = CGFloat(0)
            circleTimerView.isHidden = false
            dateLabelHeightConstraint.constant = CGFloat(0)
        } else {
            digitalTimerHeightConstraint.constant = CGFloat(Constants.digitalTimerHeight)
            circleTimerHeightConstraint.constant = CGFloat(0)
            circleTimerView.isHidden = true

            if let isShowDate = SettingsViewModel.sharedInstance.getShowDate() {
                dateLabelHeightConstraint.constant = CGFloat(isShowDate ? Constants.dateLabelHeight : 0)
            }
        }
        if let isShowWeather = SettingsViewModel.sharedInstance.getShowWeather() {
            weatherStackView.isHidden = !isShowWeather
        }
        
        if let isShow5DaysWeather = SettingsViewModel.sharedInstance.getShow5DaysWeather() {
            if isShow5DaysWeather, let data = viewModel?.mutipleDaysData.value {
                viewModel?.dailyData.value = data
                dailyViews.forEach({ view in
                    view.isHidden = false
                })
            } else if !isShow5DaysWeather, let data = viewModel?.singleDaysData.value {
                viewModel?.dailyData.value = data
                dailyViews.enumerated().forEach({ (index, view) in
                    view.isHidden = !(index == 0)
                })
            }
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
                self.dateInWatchLabel.attributedText = attributedString

                self.dateLabel.text = date.dayOfWeek(SettingsViewModel.sharedInstance.getDateFormat())
                self.clockView.setTimeToDate(date, false)
                self.smallClockView.setTimeToDate(date, false)
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
        
        // MARK: bind daily data with daysWeatherCollectionView
        viewModel?.dailyData.asObservable()
            .subscribe(onNext: { data in
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
                self.showAlert(errorMessage)
            }, onError: nil, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
    }
    
    // MARK: Actions
    
    fileprivate func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc
    fileprivate func triggleTimer() {
        viewModel?.currentDate.value = Date()
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
