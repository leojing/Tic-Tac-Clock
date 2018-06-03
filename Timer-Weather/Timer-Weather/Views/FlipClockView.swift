//
//  FlipClockView.swift
//  Timer-Weather
//
//  Created by JINGLUO on 3/6/18.
//  Copyright © 2018 JINGLUO. All rights reserved.
//

import UIKit

class FlipClockView: UIView {
    
    @IBOutlet weak var number0ImageView: UIImageView!
    @IBOutlet weak var number1ImageView: UIImageView!
    @IBOutlet weak var number2ImageView: UIImageView!
    @IBOutlet weak var number3ImageView: UIImageView!

    func setTimeToDate(_ date: Date, _ animated: Bool) {
        let dateString = date.timeOfCounter() ?? ""
        var index1 = dateString.index(dateString.startIndex, offsetBy: 1)
        let hour1 = String(dateString.prefix(upTo: index1))
        var index2 = dateString.index(dateString.startIndex, offsetBy: 2)
        let hour2 = String(dateString[index1..<index2])
        
        index1 = dateString.index(dateString.endIndex, offsetBy: -2)
        index2 = dateString.index(dateString.endIndex, offsetBy: -1)
        let min1 = String(dateString[index1..<index2])
        let min2 = String(dateString.suffix(from: index2))
        
        number0ImageView.image = UIImage(named: flipImageForNumber(hour1))
        number1ImageView.image = UIImage(named: flipImageForNumber(hour2))
        number2ImageView.image = UIImage(named: flipImageForNumber(min1))
        number3ImageView.image = UIImage(named: flipImageForNumber(min2))
    }
    
    fileprivate func flipImageForNumber(_ number: String) -> String {
        return "number-\(number)"
    }
}
