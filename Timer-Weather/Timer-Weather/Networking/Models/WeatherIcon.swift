//
//  ThemeColor.swift
//  techchallenge_jingluo
//
//  Created by JINGLUO on 27/1/18.
//  Copyright © 2018 JINGLUO. All rights reserved.
//

import Foundation
import UIKit
import SwiftIcons

enum WeatherIcon {
    case rain
    case cloudy
    case partlyCloudyNight
    case wind
    case snow
    case clearDay
    case clearNight
    case sleet
    case fog
    
    static func fromDescription(_ des: String) -> WeatherIcon? {
        switch des {
        case "rain":
            return .rain
            
        case "cloudy", "partly-cloudy-day":
            return .cloudy
            
        case "partly-cloudy-night":
            return .partlyCloudyNight
            
        case "wind":
            return .wind
            
        case "snow":
            return .snow
            
        case "clear-day":
            return .clearDay
            
        case "clear-night":
            return .clearNight
            
        case "sleet":
            return .sleet
            
        case "fog":
            return .fog
            
        default:
            return nil
        }
    }
    
    func convertToColor() -> (UIColor, UIColor) {
        switch self {
        case .rain:
            return (.darkGray, .lightGray)
            
        case .cloudy, .partlyCloudyNight, .sleet:
            return (.gray, .white)
            
        case .snow:
            return (UIColor(red: 175/255, green: 227/255, blue: 254/255, alpha: 1.0), UIColor(red: 238/255, green: 255/255, blue: 248/255, alpha: 1.0))
            
        case .wind:
            return (UIColor(red: 238/255, green: 255/255, blue: 248/255, alpha: 1.0), .lightGray)

        case .clearDay:
            return (.red, .orange)
            
        case .clearNight:
            return (UIColor(red: 102/255, green: 117/255, blue: 121/255, alpha: 1.0), .lightGray)

        case .fog:
            return (UIColor(red: 121/255, green: 113/255, blue: 88/255, alpha: 1.0), .lightGray)
        }
    }
    
    func convertToIcon() -> UIImage {
        switch self {
        case .rain:
            return UIImage(named: "rain")!
            
        case .cloudy:
            return UIImage(named: "cloudy")!
            
        case .partlyCloudyNight:
            return UIImage(named: "cloudy")!
            
        case .wind:
            return UIImage(named: "windy")!
            
        case .snow:
            return UIImage(named: "snowing")!
            
        case .clearDay:
            return UIImage(named: "sunny")!
            
        case .clearNight:
            return UIImage(named: "cloudy")!
            
        case .sleet:
            return UIImage(named: "thunderstorm")!
            
        case .fog:
            return UIImage(named: "cloudy")!
        }
    }

}
