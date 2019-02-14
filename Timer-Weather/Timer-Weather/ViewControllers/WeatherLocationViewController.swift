//
//  WeatherLocationViewController.swift
//  Timer-Weather
//
//  Created by JINGLUO on 4/7/18.
//  Copyright © 2018 JINGLUO. All rights reserved.
//

import UIKit

class WeatherLocationViewController: BaseViewController {
    
    @IBOutlet weak var spinnerView: UIActivityIndicatorView?
    @IBOutlet weak var refreshButton: UIButton?
    @IBOutlet weak var weatherView: UIView?
    @IBOutlet weak var weatherStackView: UIStackView?
    @IBOutlet var dailyViews: [DailyWeatherView]?
    @IBOutlet weak var cityNameLabel: UILabel?

    var viewModel: MainViewModel = MainViewModel() {
        didSet {
            setupViewModelBinds()
        }
    }

    fileprivate var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(triggleTimer), name: UIApplication.didBecomeActiveNotification, object: nil)
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
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    fileprivate func updateWeather() {
        let isShowWeather = Preferences.sharedInstance.getShowWeather()
        weatherView?.isHidden = !isShowWeather
        
        let isShow5DaysWeather = Preferences.sharedInstance.getShow5DaysWeather()
        let data = viewModel.mutipleDaysData
        if isShow5DaysWeather {
            viewModel.dailyData = data
            dailyViews?.forEach({ view in
                view.isHidden = false
            })
        } else {
            viewModel.dailyData = data
            dailyViews?.enumerated().forEach({ (index, view) in
                view.isHidden = !(index == 0)
            })
        }
    }
    
    // MARK: Bind ViewModel
    fileprivate func setupViewModelBinds() {
        viewModel.cityNameDidUpdate = { city in
            self.cityNameLabel?.text = city ?? "Sydney"
        }
        
        viewModel.isLoadingDidUpdate = { isLoading in
            DispatchQueue.main.async {
                if let loading = isLoading {
                    if loading {
                        self.weatherView?.isHidden = true
                        self.refreshButton?.isHidden = true
                    }
                    loading ? self.spinnerView?.startAnimating() : self.spinnerView?.stopAnimating()
                }
            }
        }
        
        viewModel.dailyDataDidUpdate = { dailyData in
            if let dailyData = dailyData,
                dailyData.count > 0 {
                DispatchQueue.main.async {
                    self.weatherView?.isHidden = false
                    self.refreshButton?.isHidden = true
                }
                dailyData.enumerated().forEach({ (index, detail) in
                    if let dailyViews = self.dailyViews {
                        let dailyView = dailyViews[index]
//                        dailyView.configureCell(detail)
                    }
                })
            }
        }
        
        viewModel.showAlert = { message in
            if let count = message?.count,
                count > 0 {
                DispatchQueue.main.async {
                    self.weatherView?.isHidden = true
                    self.refreshButton?.isHidden = false
                }
            }
        }
    }
    
    @objc
    fileprivate func triggleTimer() {
        viewModel.currentDate = Date()
        refreshAction(nil)
    }
    
    @IBAction func refreshAction(_ sender: Any?) {
        viewModel.setupLocationManager()
        refreshButton?.isHidden = true
    }
}
