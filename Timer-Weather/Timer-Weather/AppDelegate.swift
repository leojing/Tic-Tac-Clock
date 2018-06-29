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
        
        Preferences.sharedInstance.removeFlipNumbers()
        
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
}

