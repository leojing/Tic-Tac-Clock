//
//  AppDelegate.swift
//  Timer-Weather
//
//  Created by JINGLUO on 19/3/18.
//  Copyright © 2018 JINGLUO. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        guard let _ = SettingsViewModel.sharedInstance.getShowDate() else {
            SettingsViewModel.sharedInstance.setShowDate(false)
            return false
        }
        
        guard let _ = SettingsViewModel.sharedInstance.getShowWeather() else {
            SettingsViewModel.sharedInstance.setShowWeather(true)
            return false
        }

        guard let _ = SettingsViewModel.sharedInstance.getShow5DaysWeather() else {
            SettingsViewModel.sharedInstance.setShow5DaysWeather(true)
            return false
        }

        return true
    }
}

