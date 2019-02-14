//
//  DailyWeatherView.swift
//  Timer-Weather
//
//  Created by JINGLUO on 13/2/19.
//  Copyright © 2019 JINGLUO. All rights reserved.
//

import UIKit

@IBDesignable
class DailyWeatherView: NibView {
    
    @IBOutlet weak var weatherImageView: UIImageView?
    @IBOutlet weak var tempLabel: UILabel?
    
    @IBInspectable var weatherIcon: String? {
        didSet {
            weatherImageView?.image = UIImage(named: weatherIcon ?? "")
        }
    }
    
    @IBInspectable var temperature: String? {
        didSet {
            tempLabel?.text = temperature
        }
    }
    
    convenience init(icon: String?, temperature: String?) {
        self.init()
        weatherIcon = icon
        self.temperature = temperature
    }
}
