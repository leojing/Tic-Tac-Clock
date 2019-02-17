//
//  MainViewModel.swift
//  Timer-Weather
//
//  Created by JINGLUO on 20/3/18.
//  Copyright © 2018 JINGLUO. All rights reserved.
//

import Foundation
import CoreLocation

class MainViewModel: NSObject {
    
    private var locationManager: CLLocationManager?
    private var currentLocation: CLLocation?
    private var apiservice: APIService?
    private var timer: Timer?
    
    var weather: Weather? {
        didSet {
            weatherDidUpdate?(weather)
        }
    }
    
    var dailyData: [WeatherDetail]? {
        didSet {
            dailyDataDidUpdate?(dailyData)
        }
    }
    
    var singleDaysData: [WeatherDetail]? {
        didSet {
            singleDaysDataDidUpdate?(singleDaysData)
        }
    }

    var mutipleDaysData: [WeatherDetail]? {
        didSet {
            mutipleDaysDataDidUpdate?(mutipleDaysData)
        }
    }
    
    var cityName: String? {
        didSet {
            cityNameDidUpdate?(cityName)
        }
    }
    
    var alertMessage: String? {
        didSet {
            showAlert?(alertMessage)
        }
    }
    
    var isLoading: Bool? {
        didSet {
            isLoadingDidUpdate?(isLoading)
        }
    }
    
    var currentDate: Date? {
        didSet {
            currentDateDidUpdate?(currentDate ?? Date())
        }
    }
    
    var isPad: Bool {
        return false
    }
    
    var weatherDidUpdate: ((_ weather: Weather?) -> Void)?
    var dailyDataDidUpdate: ((_ dailyData: [WeatherDetail]?) -> Void)?
    var singleDaysDataDidUpdate: ((_ singleDaysData: [WeatherDetail]?) -> Void)?
    var mutipleDaysDataDidUpdate: ((_ mutipleDaysData: [WeatherDetail]?) -> Void)?
    var cityNameDidUpdate: ((_ city: String?) -> Void)?
    var showAlert: ((_ message: String?) -> Void)?
    var isLoadingDidUpdate: ((_ isLoading: Bool?) -> Void)?
    var currentDateDidUpdate: ((_ currentDate: Date) -> Void)?
    
    init(_ apiService: APIService? = APIClient()) {
        super.init()
        
        apiservice = apiService
        setupLocationManager()
        bindDailyData()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            self.currentDate = Date()
        })
    }
    
    func setupLocationManager() {
        locationManager = CLLocationManager()
        guard let locationManager = locationManager else {
            return
        }
        
        if CLLocationManager.authorizationStatus() == .notDetermined || CLLocationManager.authorizationStatus() == .denied {
            locationManager.requestWhenInUseAuthorization()
        }
        
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.distanceFilter = 1000
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    func fetchWeatherInfo(_ apiService: APIService) {
        isLoading = true
        singleDaysData = []
        mutipleDaysData = []
        if let lat = currentLocation?.coordinate.latitude, let lng = currentLocation?.coordinate.longitude {
            apiService.fetchWeatherInfo(APIConfig.weather((lat, lng))) { status in
                self.isLoading = false
                switch status {
                case .success(let weather):
                    self.weather = weather as? Weather
                    
                case .fail(let error):
                    let errorMessage = error.errorDescription ?? "Faild to load weather data"
                    self.alertMessage = errorMessage
                }
            }
        } else {
            isLoading = false
            self.alertMessage = "Can not find location"
        }
    }
    
    fileprivate func fetchCityName(_ locationService: LocationService) {
        locationService.fetchCity { city in
            self.cityName = city
        }
    }
    
    fileprivate func bindDailyData() {
        if let weatherData = weather?.daily?.data, weatherData.count > 0 {
            self.singleDaysData = Array(weatherData.prefix(1))
            self.mutipleDaysData = Array(weatherData.prefix(5))
            let isShow5DaysWeather = Preferences.sharedInstance.getShow5DaysWeather()
            if isShow5DaysWeather {
                self.dailyData = self.mutipleDaysData
            } else {
                self.dailyData = [self.singleDaysData?.first, nil, nil, nil, nil] as? [WeatherDetail]
            }
        } else {
            self.alertMessage = "Empty data"
        }
    }
}


// MARK: - CLLocationManagerDelegate

extension MainViewModel: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        
        locationManager?.stopUpdatingLocation()
        
        currentLocation = location
        fetchCityName(LocationService((location.coordinate.latitude, location.coordinate.longitude)))
        if let apiService = apiservice {
            fetchWeatherInfo(apiService)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        NSLog(error.localizedDescription)
    }
}
