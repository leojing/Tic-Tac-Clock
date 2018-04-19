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

class MainViewController: UIViewController {
    
    @IBOutlet weak var circleTimerView: UIView!
    @IBOutlet weak var circleTimerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var clockView: AnalogClockView!
    @IBOutlet weak var smallClockView: AnalogClockView!
    @IBOutlet weak var dateInWatchLabel: UILabel!
    
    @IBOutlet weak var digitalTimerView: UIView!
    @IBOutlet weak var digitalTimerLabel: UILabel!
    @IBOutlet weak var digitalTimerHeightConstraint: NSLayoutConstraint!

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateLabelHeightConstraint: NSLayoutConstraint!

    @IBOutlet weak var daysWeatherCollectionView: UICollectionView!
    @IBOutlet weak var weatherCollectionHeightConstraint: NSLayoutConstraint!
    
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
        static let weatherCollectionHeight = 80
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        viewModel = MainViewModel(APIClient())
        
        NotificationCenter.default.addObserver(self, selector: #selector(triggleTimer), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let isShowDate = SettingsViewModel.sharedInstance.getShowDate() {
            digitalTimerHeightConstraint.constant = CGFloat(isShowDate ? Constants.digitalTimerHeight : 0)
            dateLabelHeightConstraint.constant = CGFloat(isShowDate ? Constants.dateLabelHeight : 0)
            
            circleTimerHeightConstraint.constant = CGFloat(!isShowDate ? Constants.circleTimerHeight : 0)
            circleTimerView.isHidden = isShowDate
        }
        
        if let isShowWeather = SettingsViewModel.sharedInstance.getShowWeather() {
            weatherCollectionHeightConstraint.constant = CGFloat(isShowWeather ? Constants.weatherCollectionHeight : 0)
        }
        
        if let isShow5DaysWeather = SettingsViewModel.sharedInstance.getShow5DaysWeather() {
            if isShow5DaysWeather, let data = viewModel?.mutipleDaysData.value {
                viewModel?.dailyData.value = data
            } else if !isShow5DaysWeather, let data = viewModel?.singleDaysData.value {
                viewModel?.dailyData.value = data
            }
        }
    }
    
    fileprivate func setupCollectionView() {
        if let layout = daysWeatherCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: daysWeatherCollectionView.frame.size.width/6, height: daysWeatherCollectionView.frame.size.height/2)
            layout.minimumLineSpacing = 1.0
        }
    }

    // MARK: Bind ViewModel
    fileprivate func setupViewModelBinds() {
        
        viewModel?.currentDigitalTime.asObservable()
        .bind(to: self.digitalTimerLabel.rx.text)
        .disposed(by: disposeBag)
        
        viewModel?.currentDate.asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { date in
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
            .bind(to: daysWeatherCollectionView.rx.items(cellIdentifier: DailyCollectionViewCell.reuseId(), cellType: DailyCollectionViewCell.self)) { (row, element, cell) in
                cell.layoutIfNeeded()
                cell.configureCell(element)
            }
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
