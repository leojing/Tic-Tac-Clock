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

        if UIDevice.current.batteryState == .charging {
            application.isIdleTimerDisabled = true
        }
        
        if let _ = Preferences.sharedInstance.getShowDate() {
        } else {
            Preferences.sharedInstance.setShowDate(false)
        }
        
        if let _ = Preferences.sharedInstance.getShowWeather() {
        } else {
            Preferences.sharedInstance.setShowWeather(true)
        }

        if let _ = Preferences.sharedInstance.getShow5DaysWeather() {
        } else {
            Preferences.sharedInstance.setShow5DaysWeather(true)
        }

        if let _ = Preferences.sharedInstance.getWatchFace() {
        } else {
            Preferences.sharedInstance.setWatchFace(0)
        }

        if let _ = Preferences.sharedInstance.getBackground() {
        } else {
            Preferences.sharedInstance.setBackground("#000000")
        }

        if let _ = Preferences.sharedInstance.getDateFormat() {
        } else {
            Preferences.sharedInstance.setDateFormat("YYYY/MM/dd")
        }

        return true
    }
}

