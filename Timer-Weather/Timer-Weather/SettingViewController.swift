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
    }
    
    // MARK: Actions
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func showWeather(_ sender: Any) {
        let isShow = (sender as! UISwitch).isOn
        SettingsViewModel.sharedInstance.setShowWeather(isShow)
    }
    
    @IBAction func show5DaysWeather(_ sender: Any) {
        let isShow = (sender as! UISwitch).isOn
        SettingsViewModel.sharedInstance.setShow5DaysWeather(isShow)
    }
    
    @IBAction func showDate(_ sender: Any) {
        let isShow = (sender as! UISwitch).isOn
        SettingsViewModel.sharedInstance.setShowDate(isShow)
    }

}
