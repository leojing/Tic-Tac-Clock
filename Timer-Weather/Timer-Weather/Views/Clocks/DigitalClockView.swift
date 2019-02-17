//
//  DigitalClockView.swift
//  Timer-Weather
//
//  Created by JINGLUO on 17/2/19.
//  Copyright © 2019 JINGLUO. All rights reserved.
//

import UIKit

class DigitalClockView: NibView {
    
    @IBOutlet private weak var hourLabel: UILabel?
    @IBOutlet private weak var minLabel: UILabel?

    @IBInspectable var date: Date? {
        didSet {
            guard let date = date else {
                return
            }
            setClockWithDate(date, animated: false)
        }
    }
    
    @IBInspectable var font: UIFont? {
        didSet {
            hourLabel?.font = font
            minLabel?.font = font
        }
    }
}

// MARK: Conform to ClockProtocol

extension DigitalClockView: ClockProtocol {
    
    func setClockWithDate(_ date: Date, animated: Bool) {
        let timer = Date().timeOfCounter()
        var index = timer.index(timer.startIndex, offsetBy: 2)
        hourLabel?.text = String(timer.prefix(upTo: index))
        index = timer.index(timer.endIndex, offsetBy: -2)
        minLabel?.text = ":\(String(timer.suffix(from: index)))"
    }
}
