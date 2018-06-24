//
//  SettingsViewModel.swift
//  Timer-Weather
//
//  Created by JINGLUO on 11/4/18.
//  Copyright © 2018 JINGLUO. All rights reserved.
//

import Foundation

enum FlipClockNumber: String {
    case firstNumber = "firstNumber"
    case secondNumber = "secondNumber"
    case thirdNumber = "thirdNumber"
    case forthNumber = "forthNumber"
}

class Preferences: NSObject {
    
    enum PreferenceOption: String {
        case showWeather = "showWeather"
        case show5DaysWeather = "show5DaysWeather"
        case showLocation = "showLocation"
        case showDate = "showDate"
        case disableIdleTimer = "disableIdleTimer"
        case dateFormat = "dateFormat"
        case watchFace = "watchFace"
        case background = "background"
        
        case isShowGuideView = "isShowGuideView"
    }
    
    static let sharedInstance = Preferences()
    private let userDefaults = UserDefaults.standard
    
    override init() {
        super.init()
    }
    
    func resetDefaults() {
        let dictionary = userDefaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            userDefaults.removeObject(forKey: key)
        }
    }
    
    func removeObject(forKey key: String) {
        userDefaults.removeObject(forKey: key)
    }
    
    func removeFlipNumbers() {
        Preferences.sharedInstance.removeObject(forKey: FlipClockNumber.firstNumber.rawValue)
        Preferences.sharedInstance.removeObject(forKey: FlipClockNumber.secondNumber.rawValue)
        Preferences.sharedInstance.removeObject(forKey: FlipClockNumber.thirdNumber.rawValue)
        Preferences.sharedInstance.removeObject(forKey: FlipClockNumber.forthNumber.rawValue)
    }
    
    // MARK: set & get for Show Weather data
    func setShowWeather(_ isShow: Bool?) {
        userDefaults.setValue(isShow, forKey: PreferenceOption.showWeather.rawValue)
    }
    
    func getShowWeather() -> Bool? {
        return userDefaults.value(forKey: PreferenceOption.showWeather.rawValue) as? Bool
    }
    
    // MARK: set & get for Show 5 days weather data
    func setShow5DaysWeather(_ isShow: Bool?) {
        userDefaults.setValue(isShow, forKey: PreferenceOption.show5DaysWeather.rawValue)
    }
    
    func getShow5DaysWeather() -> Bool? {
        return userDefaults.value(forKey: PreferenceOption.show5DaysWeather.rawValue) as? Bool
    }

    // MARK: set & get for Show location data
    func setShowLocation(_ isShow: Bool?) {
        userDefaults.setValue(isShow, forKey: PreferenceOption.showLocation.rawValue)
    }
    
    func getShowLocation() -> Bool? {
        return userDefaults.value(forKey: PreferenceOption.showLocation.rawValue) as? Bool
    }

    // MARK: set & get for Show date data
    func setShowDate(_ isShow: Bool?) {
        userDefaults.setValue(isShow, forKey: PreferenceOption.showDate.rawValue)
    }
    
    func getShowDate() -> Bool? {
        return userDefaults.value(forKey: PreferenceOption.showDate.rawValue) as? Bool
    }
    
    // MARK: set & get for date format data
    func setDateFormat(_ format: String?) {
        userDefaults.setValue(format, forKey: PreferenceOption.dateFormat.rawValue)
    }
    
    func getDateFormat() -> String? {
        return userDefaults.value(forKey: PreferenceOption.dateFormat.rawValue) as? String
    }
    
    // MARK: set & get for disable IdleTimerdata
    func setDisabelIdleTimer(_ enable: Bool?) {
        userDefaults.setValue(enable, forKey: PreferenceOption.disableIdleTimer.rawValue)
    }
    
    func getDisabelIdleTimer() -> Bool? {
        return userDefaults.value(forKey: PreferenceOption.disableIdleTimer.rawValue) as? Bool
    }

    // MARK: set & get for watch face data
    func setWatchFace(_ index: Int?) {
        userDefaults.setValue(index, forKey: PreferenceOption.watchFace.rawValue)
    }
    
    func getWatchFace() -> Int? {
        return userDefaults.value(forKey: PreferenceOption.watchFace.rawValue) as? Int
    }
    
    // MARK: set & get for background
    func setBackground(_ color: String?) {
        userDefaults.setValue(color, forKey: PreferenceOption.background.rawValue)
    }
    
    func getBackground() -> String? {
        return userDefaults.value(forKey: PreferenceOption.background.rawValue) as? String
    }
    
    // MARK: set & get for is show guide view
    func setIsShowGuideView(_ isShow: Bool?) {
        userDefaults.setValue(isShow, forKey: PreferenceOption.isShowGuideView.rawValue)
    }
    
    func getIsShowGuideView() -> Bool? {
        return userDefaults.value(forKey: PreferenceOption.isShowGuideView.rawValue) as? Bool
    }
    
    // MARK: set & get for FlipClock first number
    func setFlipNumber(_ value: String?, key: FlipClockNumber) {
        userDefaults.setValue(value, forKey: key.rawValue)
    }
    
    func getFlipNumber(key: FlipClockNumber) -> String? {
        return userDefaults.value(forKey: key.rawValue) as? String
    }
}
