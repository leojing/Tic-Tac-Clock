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
    private var allowRotation = true

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        initialPreferences()
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "AllowRotation"), object: nil, queue: .main) { notification in
            self.allowRotation = true
        }
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "NotAllowRotation"), object: nil, queue: .main) { notification in
            self.allowRotation = false
        }
        
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return allowRotation ? UIInterfaceOrientationMask.all : UIInterfaceOrientationMask.portrait
    }
    
    fileprivate func initialPreferences() {
        
        Preferences.sharedInstance.removeFlipNumbers()
        
        if let _ = Preferences.sharedInstance.getShowWeather() {
        } else {
            Preferences.sharedInstance.setShowWeather(true)
        }
        
        if let _ = Preferences.sharedInstance.getShow5DaysWeather() {
        } else {
            Preferences.sharedInstance.setShow5DaysWeather(true)
        }
        
        if let _ = Preferences.sharedInstance.getShowLocation() {
        } else {
            Preferences.sharedInstance.setShowDate(true)
        }
        
        if let _ = Preferences.sharedInstance.getShowDate() {
        } else {
            Preferences.sharedInstance.setShowDate(false)
        }
        
        if let _ = Preferences.sharedInstance.getDisabelIdleTimer() {
        } else {
            Preferences.sharedInstance.setDisabelIdleTimer(true)
        }
        
        if let _ = Preferences.sharedInstance.getWatchFace() {
        } else {
            Preferences.sharedInstance.setWatchFace(0)
        }
        
        if let _ = Preferences.sharedInstance.getBackground() {
        } else {
            Preferences.sharedInstance.setBackground("#c96167")
        }
        
        if let _ = Preferences.sharedInstance.getDateFormat() {
        } else {
            Preferences.sharedInstance.setDateFormat("YYYY/MM/dd")
        }
        
        if let _ = Preferences.sharedInstance.getIsShowGuideView() {
        } else {
            Preferences.sharedInstance.setIsShowGuideView(true)
        }
    }
}

