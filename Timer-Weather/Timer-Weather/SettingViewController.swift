//
//  SettingViewController.swift
//  Timer-Weather
//
//  Created by JINGLUO on 21/3/18.
//  Copyright © 2018 JINGLUO. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SettingViewController: UITableViewController {
    
    @IBOutlet weak var showWeatherSwitch: UISwitch!
    @IBOutlet weak var show5DaysWeatherSwitch: UISwitch!
    @IBOutlet weak var showDateSwitch: UISwitch!
    
    fileprivate let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let isShowWeather = SettingsViewModel.sharedInstance.getShowWeather() {
            showWeatherSwitch.isOn = isShowWeather
        }
        if let isShow5DaysWeather = SettingsViewModel.sharedInstance.getShow5DaysWeather() {
            show5DaysWeatherSwitch.isOn = isShow5DaysWeather
        }
        if let isShowDate = SettingsViewModel.sharedInstance.getShowDate() {
            showDateSwitch.isOn = isShowDate
        }
        
        showWeatherSwitch.rx.isOn.asObservable()
            .subscribe(onNext: { isOn in
                SettingsViewModel.sharedInstance.setShowWeather(isOn)
                if !isOn {
                    self.show5DaysWeatherSwitch.isOn = false
                    SettingsViewModel.sharedInstance.setShow5DaysWeather(false)
                }
            }, onError: nil, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)

        show5DaysWeatherSwitch.rx.isOn.asObservable()
            .subscribe(onNext: { isOn in
                SettingsViewModel.sharedInstance.setShow5DaysWeather(isOn)
                if isOn {
                    self.showWeatherSwitch.isOn = true
                    SettingsViewModel.sharedInstance.setShowWeather(true)
                }
            }, onError: nil, onCompleted: nil, onDisposed: nil)
        .disposed(by: disposeBag)
        
        showDateSwitch.rx.isOn.asObservable()
            .subscribe(onNext: { isOn in
                SettingsViewModel.sharedInstance.setShowDate(isOn)
            }, onError: nil, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
    }
    
    // MARK: Actions
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
//
//    @IBAction func showWeather(_ sender: Any) {
//        let isShow = (sender as! UISwitch).isOn
//
//        if !isShow {
//            show5DaysWeatherSwitch.isOn = false
//        }
//    }
//
//    @IBAction func show5DaysWeather(_ sender: Any) {
//        let isShow = (sender as! UISwitch).isOn
//        SettingsViewModel.sharedInstance.setShow5DaysWeather(isShow)
//    }
//
//    @IBAction func showDate(_ sender: Any) {
//        let isShow = (sender as! UISwitch).isOn
//        SettingsViewModel.sharedInstance.setShowDate(isShow)
//    }

}
