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

protocol SettingViewControllerDelegate {
    func showWeather(_ isShow: Bool)
    func show7DaysWeather(_ isShow: Bool)
    func showDate(_ isShow: Bool)
}

class SettingViewController: UITableViewController {
    
    var delegate: SettingViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Actions
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func showWeatherAction(_ sender: UISwitch) {
        delegate?.showWeather(sender.isOn)
    }
    
    @IBAction func show7DaysWeatherAction(_ sender: UISwitch) {
        delegate?.show7DaysWeather(sender.isOn)
    }
    
    @IBAction func showDateAction(_ sender: UISwitch) {
        delegate?.showDate(sender.isOn)
    }

}
