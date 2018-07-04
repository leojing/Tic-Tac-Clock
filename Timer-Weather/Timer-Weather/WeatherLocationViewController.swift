//
//  WeatherLocationViewController.swift
//  Timer-Weather
//
//  Created by JINGLUO on 4/7/18.
//  Copyright © 2018 JINGLUO. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class WeatherLocationViewController: BaseViewController {
    
    @IBOutlet weak var spinnerView: UIActivityIndicatorView?
    @IBOutlet weak var refreshButton: UIButton?
    @IBOutlet weak var weatherView: UIView?
    @IBOutlet weak var weatherStackView: UIStackView?
    @IBOutlet var dailyViews: [DailyCollectionViewCell]?
    @IBOutlet weak var cityNameLabel: UILabel?

    fileprivate let disposeBag = DisposeBag()
    var viewModel: MainViewModel = MainViewModel() {
        didSet {
            setupViewModelBinds()
        }
    }

    fileprivate var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(triggleTimer), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        refreshAction(nil)
        updateWeather()
        
        timer = Timer.scheduledTimer(withTimeInterval: 2*60*60, repeats: true) { _ in
            self.refreshAction(nil)
        }

        let isShowLocation = Preferences.sharedInstance.getShowLocation()
        cityNameLabel?.isHidden = !isShowLocation
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        timer.invalidate()
    }
    
    fileprivate func updateWeather() {
        let isShowWeather = Preferences.sharedInstance.getShowWeather()
        weatherView?.isHidden = !isShowWeather
        
        let isShow5DaysWeather = Preferences.sharedInstance.getShow5DaysWeather()
        let data = viewModel.mutipleDaysData.value
        if isShow5DaysWeather {
            viewModel.dailyData.value = data
            dailyViews?.forEach({ view in
                view.isHidden = false
            })
        } else {
            viewModel.dailyData.value = data
            dailyViews?.enumerated().forEach({ (index, view) in
                view.isHidden = !(index == 0)
            })
        }
    }
    
    // MARK: Bind ViewModel
    fileprivate func setupViewModelBinds() {
        viewModel.cityName.asObservable()
            .subscribe(onNext: { name in
                self.cityNameLabel?.text = name
            }, onError: nil, onCompleted: nil, onDisposed: nil)
        .disposed(by: disposeBag)
        
        // MARK: bind spinner view
        viewModel.isLoading.asObservable()
            .subscribe(onNext: { loading in
                DispatchQueue.main.async {
                    if loading {
                        self.weatherView?.isHidden = true
                        self.refreshButton?.isHidden = true
                    }
                    loading ? self.spinnerView?.startAnimating() : self.spinnerView?.stopAnimating()
                }
            }, onError: nil, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
        
        // MARK: bind daily data with daysWeatherCollectionView
        viewModel.dailyData.asObservable()
            .filter { $0.count > 0 }
            .subscribe(onNext: { data in
                DispatchQueue.main.async {
                    self.weatherView?.isHidden = false
                    self.refreshButton?.isHidden = true
                }
                data.enumerated().forEach({ (index, detail) in
                    if let dailyViews = self.dailyViews {
                        let dailyView = dailyViews[index]
                        dailyView.configureCell(detail)
                    }
                })
            }, onError: nil, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
        
        // MARK: show error message
        viewModel.alertMessage.asObservable()
            .filter { $0.count > 0 }
            .subscribe(onNext: { errorMessage in
                DispatchQueue.main.async {
                    self.weatherView?.isHidden = true
                    self.refreshButton?.isHidden = false
                }
            }, onError: nil, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
    }
    
    @objc
    fileprivate func triggleTimer() {
        viewModel.currentDate.value = Date()
        refreshAction(nil)
    }
    
    @IBAction func refreshAction(_ sender: Any?) {
        viewModel.setupLocationManager()
        refreshButton?.isHidden = true
    }
}
