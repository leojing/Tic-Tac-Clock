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
        
//        SettingsViewModel.sharedInstance.resetDefaults()
        
        if let _ = SettingsViewModel.sharedInstance.getShowDate() {
        } else {
            SettingsViewModel.sharedInstance.setShowDate(false)
        }
        
        if let _ = SettingsViewModel.sharedInstance.getShowWeather() {
        } else {
            SettingsViewModel.sharedInstance.setShowWeather(true)
        }

        if let _ = SettingsViewModel.sharedInstance.getShow5DaysWeather() {
        } else {
            SettingsViewModel.sharedInstance.setShow5DaysWeather(true)
        }

        if let _ = SettingsViewModel.sharedInstance.getWatchFace() {
        } else {
            SettingsViewModel.sharedInstance.setWatchFace(0)
        }

        if let _ = SettingsViewModel.sharedInstance.getBackground() {
        } else {
            SettingsViewModel.sharedInstance.setBackground("#000000")
        }

        if let _ = SettingsViewModel.sharedInstance.getDateFormat() {
        } else {
            SettingsViewModel.sharedInstance.setDateFormat("YYYY/MM/dd")
        }

        return true
    }
}

