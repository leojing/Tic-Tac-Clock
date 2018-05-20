//
//  SettingsViewModel.swift
//  Timer-Weather
//
//  Created by JINGLUO on 11/4/18.
//  Copyright © 2018 JINGLUO. All rights reserved.
//

import Foundation

class Preferences: NSObject {
    
    enum PreferenceOptions: String {
        case showWeather = "showWeather"
        case show5DaysWeather = "show5DaysWeather"
        case showLocation = "showLocation"
        case showDate = "showDate"
        case disableIdleTimer = "disableIdleTimer"
        case dateFormat = "dateFormat"
        case watchFace = "watchFace"
        case background = "background"
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
    
    // MARK: set & get for Show Weather data
    func setShowWeather(_ isShow: Bool?) {
        userDefaults.setValue(isShow, forKey: PreferenceOptions.showWeather.rawValue)
    }
    
    func getShowWeather() -> Bool? {
        return userDefaults.value(forKey: PreferenceOptions.showWeather.rawValue) as? Bool
    }
    
    // MARK: set & get for Show 5 days weather data
    func setShow5DaysWeather(_ isShow: Bool?) {
        userDefaults.setValue(isShow, forKey: PreferenceOptions.show5DaysWeather.rawValue)
    }
    
    func getShow5DaysWeather() -> Bool? {
        return userDefaults.value(forKey: PreferenceOptions.show5DaysWeather.rawValue) as? Bool
    }

    // MARK: set & get for Show location data
    func setShowLocation(_ isShow: Bool?) {
        userDefaults.setValue(isShow, forKey: PreferenceOptions.showLocation.rawValue)
    }
    
    func getShowLocation() -> Bool? {
        return userDefaults.value(forKey: PreferenceOptions.showLocation.rawValue) as? Bool
    }

    // MARK: set & get for Show date data
    func setShowDate(_ isShow: Bool?) {
        userDefaults.setValue(isShow, forKey: PreferenceOptions.showDate.rawValue)
    }
    
    func getShowDate() -> Bool? {
        return userDefaults.value(forKey: PreferenceOptions.showDate.rawValue) as? Bool
    }
    
    // MARK: set & get for date format data
    func setDateFormat(_ format: String?) {
        userDefaults.setValue(format, forKey: PreferenceOptions.dateFormat.rawValue)
    }
    
    func getDateFormat() -> String? {
        return userDefaults.value(forKey: PreferenceOptions.dateFormat.rawValue) as? String
    }
    
    // MARK: set & get for disable IdleTimerdata
    func setDisabelIdleTimer(_ enable: Bool?) {
        userDefaults.setValue(enable, forKey: PreferenceOptions.disableIdleTimer.rawValue)
    }
    
    func getDisabelIdleTimer() -> Bool? {
        return userDefaults.value(forKey: PreferenceOptions.disableIdleTimer.rawValue) as? Bool
    }

    // MARK: set & get for watch face data
    func setWatchFace(_ index: Int?) {
        userDefaults.setValue(index, forKey: PreferenceOptions.watchFace.rawValue)
    }
    
    func getWatchFace() -> Int? {
        return userDefaults.value(forKey: PreferenceOptions.watchFace.rawValue) as? Int
    }
    
    // MARK: set & get for background
    func setBackground(_ color: String?) {
        userDefaults.setValue(color, forKey: PreferenceOptions.background.rawValue)
    }
    
    func getBackground() -> String? {
        return userDefaults.value(forKey: PreferenceOptions.background.rawValue) as? String
    }
}
