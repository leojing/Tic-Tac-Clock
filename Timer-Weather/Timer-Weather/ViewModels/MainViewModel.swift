//
//  MainViewModel.swift
//  Timer-Weather
//
//  Created by JINGLUO on 20/3/18.
//  Copyright © 2018 JINGLUO. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift

class MainViewModel: NSObject {
    
    let disposeBag = DisposeBag()
    
    private var locationManager: CLLocationManager?
    fileprivate var currentLocation: CLLocation?
    fileprivate var apiservice: APIService?
    
    var weather = Variable<Weather?>(nil)
    var dailyData = Variable<[WeatherDetail]>([])
    var cityName = Variable<String>("")
    var alertMessage = Variable<String>("")
    
    init(_ apiService: APIService) {
        super.init()
        
        apiservice = apiService
        setupLocationManager()
        bindDailyData()
    }
    
    fileprivate func setupLocationManager() {
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
    
    fileprivate func fetchWeatherInfo(_ apiService: APIService) {
        apiService.fetchWeatherInfo(APIConfig.weather(((currentLocation?.coordinate.latitude)!, (currentLocation?.coordinate.longitude)!)))
            .subscribe(onNext: { status in
                switch status {
                case .success(let weather):
                    self.weather.value = weather as? Weather
                    
                case .fail(let error):
                    let errorMessage = error.errorDescription ?? "Faild to load weather data"
                    self.alertMessage.value = errorMessage
                }
            }, onError: nil, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
    }
    
    fileprivate func fetchCityName(_ locationService: LocationService) {
        locationService.fetchCity { city in
            self.cityName.value = city
        }
    }
    
    fileprivate func bindDailyData() {
        weather.asObservable()
            .subscribe(onNext: { w in
                if let weatherData = w?.daily?.data {
                    self.dailyData.value = weatherData
                }
            }, onError: nil, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
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
