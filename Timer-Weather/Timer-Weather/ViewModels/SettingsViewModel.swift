//
//  SettingsViewModel.swift
//  Timer-Weather
//
//  Created by JINGLUO on 11/4/18.
//  Copyright © 2018 JINGLUO. All rights reserved.
//

import Foundation

class SettingsViewModel: NSObject {
    
    enum SettingOption: String {
        case showWeather = "showWeather"
        case show5DaysWeather = "show5DaysWeather"
        case showDate = "showDate"
        case dateFormat = "dateFormat"
        case watchFace = "watchFace"
        case background = "background"
    }
    
    static let sharedInstance = SettingsViewModel()
    private let userDefaults = UserDefaults.standard
    
    override init() {
        super.init()
    }
    
    // MARK: set & get for Show Weather data
    func setShowWeather(_ isShow: Bool?) {
        userDefaults.setValue(isShow, forKey: SettingOption.showWeather.rawValue)
    }
    
    func getShowWeather() -> Bool? {
        return userDefaults.value(forKey: SettingOption.showWeather.rawValue) as? Bool
    }
    
    // MARK: set & get for Show 5 days weather data
    func setShow5DaysWeather(_ isShow: Bool?) {
        userDefaults.setValue(isShow, forKey: SettingOption.show5DaysWeather.rawValue)
    }
    
    func getShow5DaysWeather() -> Bool? {
        return userDefaults.value(forKey: SettingOption.show5DaysWeather.rawValue) as? Bool
    }

    // MARK: set & get for Show date data
    func setShowDate(_ isShow: Bool?) {
        userDefaults.setValue(isShow, forKey: SettingOption.showDate.rawValue)
    }
    
    func getShowDate() -> Bool? {
        return userDefaults.value(forKey: SettingOption.showDate.rawValue) as? Bool
    }
    
    // MARK: set & get for date format data
    func setDateFormat(_ isShow: Bool?) {
        userDefaults.setValue(isShow, forKey: SettingOption.dateFormat.rawValue)
    }
    
    func getDateFormat() -> String? {
        return userDefaults.value(forKey: SettingOption.dateFormat.rawValue) as? String
    }

    // MARK: set & get for watch face data
    func setWatchFace(_ isShow: Bool?) {
        userDefaults.setValue(isShow, forKey: SettingOption.watchFace.rawValue)
    }
    
    func getWatchFace() -> String? {
        return userDefaults.value(forKey: SettingOption.watchFace.rawValue) as? String
    }
    
    // MARK: set & get for background
    func setBackground(_ color: String?) {
        userDefaults.setValue(color, forKey: SettingOption.background.rawValue)
    }
    
    func getBackground() -> String? {
        return userDefaults.value(forKey: SettingOption.background.rawValue) as? String
    }
}
