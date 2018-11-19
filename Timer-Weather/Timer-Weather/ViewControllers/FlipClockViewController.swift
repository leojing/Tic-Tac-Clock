//
//  FlipClockViewController.swift
//  Timer-Weather
//
//  Created by JINGLUO on 1/7/18.
//  Copyright © 2018 JINGLUO. All rights reserved.
//

import UIKit

class FlipClockViewController: BaseViewController {
    
    @IBOutlet weak var portraitFlipClockView: FlipClockView?
    @IBOutlet weak var landscapeFlipClockView: FlipClockView?

    private var rotateDeviceObserver: NSObjectProtocol!
    
    var viewModel: MainViewModel = MainViewModel() {
        didSet {
            setupViewModelBinds()
        }
    }
    
    var isLandscape = false {
        didSet {
            Preferences.sharedInstance.removeFlipNumbers()
            portraitFlipClockView?.isHidden = isLandscape
            landscapeFlipClockView?.isHidden = !isLandscape
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rotateDeviceObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "RotateDevice"), object: nil, queue: .main) { notification in
            let userInfo = notification.userInfo
            let isLandscape = userInfo!["isLandscape"] as! Bool
            self.isLandscape = isLandscape
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(rotateDeviceObserver)
    }

    // MARK: Bind ViewModel
    fileprivate func setupViewModelBinds() {
        
//        viewModel.currentDate.asObservable()
//            .observeOn(MainScheduler.instance)
//            .subscribe(onNext: { date in
//                if self.isLandscape {
//                    self.landscapeFlipClockView?.setTimeToDate(date, false)
//                } else {
//                    self.portraitFlipClockView?.setTimeToDate(date, false)
//                }
//            }, onError: nil, onCompleted: nil, onDisposed: nil)
//            .disposed(by: disposeBag)
    }
}
