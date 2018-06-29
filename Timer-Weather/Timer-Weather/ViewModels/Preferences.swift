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
    
    func getShowWeather() -> Bool {
        guard let isShow = userDefaults.value(forKey: PreferenceOption.showWeather.rawValue) as? Bool else {
            userDefaults.setValue(true, forKey: PreferenceOption.showWeather.rawValue)
            return true
        }
        return isShow
    }
    
    // MARK: set & get for Show 5 days weather data
    func setShow5DaysWeather(_ isShow: Bool?) {
        userDefaults.setValue(isShow, forKey: PreferenceOption.show5DaysWeather.rawValue)
    }
    
    func getShow5DaysWeather() -> Bool {
        guard let isShow = userDefaults.value(forKey: PreferenceOption.show5DaysWeather.rawValue) as? Bool else {
            userDefaults.setValue(false, forKey: PreferenceOption.show5DaysWeather.rawValue)
            return false
        }
        return isShow
    }

    // MARK: set & get for Show location data
    func setShowLocation(_ isShow: Bool?) {
        userDefaults.setValue(isShow, forKey: PreferenceOption.showLocation.rawValue)
    }
    
    func getShowLocation() -> Bool {
        guard let isShow = userDefaults.value(forKey: PreferenceOption.showLocation.rawValue) as? Bool else {
            userDefaults.setValue(true, forKey: PreferenceOption.showLocation.rawValue)
            return true
        }
        return isShow
    }

    // MARK: set & get for Show date data
    func setShowDate(_ isShow: Bool?) {
        userDefaults.setValue(isShow, forKey: PreferenceOption.showDate.rawValue)
    }
    
    func getShowDate() -> Bool {
        guard let isShow = userDefaults.value(forKey: PreferenceOption.showDate.rawValue) as? Bool else {
            userDefaults.setValue(true, forKey: PreferenceOption.showDate.rawValue)
            return true
        }
        return isShow
    }
    
    // MARK: set & get for date format data
    func setDateFormat(_ format: String?) {
        userDefaults.setValue(format, forKey: PreferenceOption.dateFormat.rawValue)
    }
    
    func getDateFormat() -> String {
        guard let dateFormat = userDefaults.value(forKey: PreferenceOption.dateFormat.rawValue) as? String else {
            userDefaults.setValue(("YYYY/MM/dd"), forKey: PreferenceOption.dateFormat.rawValue)
            return "YYYY/MM/dd"
        }
        return dateFormat
    }
    
    // MARK: set & get for disable IdleTimerdata
    func setDisabelIdleTimer(_ enable: Bool?) {
        userDefaults.setValue(enable, forKey: PreferenceOption.disableIdleTimer.rawValue)
    }
    
    func getDisabelIdleTimer() -> Bool {
        guard let disableIdleTimer = userDefaults.value(forKey: PreferenceOption.disableIdleTimer.rawValue) as? Bool else {
            userDefaults.setValue(false, forKey: PreferenceOption.disableIdleTimer.rawValue)
            return false
        }
        return disableIdleTimer
    }

    // MARK: set & get for watch face data
    func setWatchFace(_ index: Int?) {
        userDefaults.setValue(index, forKey: PreferenceOption.watchFace.rawValue)
    }
    
    func getWatchFace() -> Int {
        guard let watchFace = userDefaults.value(forKey: PreferenceOption.watchFace.rawValue) as? Int else {
            userDefaults.setValue(0, forKey: PreferenceOption.watchFace.rawValue)
            return 0
        }
        return watchFace
    }
    
    // MARK: set & get for background
    func setBackground(_ color: String?) {
        userDefaults.setValue(color, forKey: PreferenceOption.background.rawValue)
    }
    
    func getBackground() -> String {
        guard let bgColor = userDefaults.value(forKey: PreferenceOption.background.rawValue) as? String else {
            userDefaults.setValue("#c96167", forKey: PreferenceOption.background.rawValue)
            return "#c96167"
        }
        return bgColor
    }
    
    // MARK: set & get for is show guide view
    func setIsShowGuideView(_ isShow: Bool?) {
        userDefaults.setValue(isShow, forKey: PreferenceOption.isShowGuideView.rawValue)
    }
    
    func getIsShowGuideView() -> Bool {
        guard let isShow = userDefaults.value(forKey: PreferenceOption.isShowGuideView.rawValue) as? Bool else {
            userDefaults.setValue(false, forKey: PreferenceOption.isShowGuideView.rawValue)
            return false
        }
        return isShow
    }
    
    // MARK: set & get for FlipClock first number
    func setFlipNumber(_ value: String?, key: FlipClockNumber) {
        userDefaults.setValue(value, forKey: key.rawValue)
    }
    
    func getFlipNumber(key: FlipClockNumber) -> String? {
        return userDefaults.value(forKey: key.rawValue) as? String
    }
}
