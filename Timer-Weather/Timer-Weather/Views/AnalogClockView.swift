//
//  AnalogClockView.swift
//  Timer-Weather
//
//  Created by JINGLUO on 28/3/18.
//  Copyright © 2018 JINGLUO. All rights reserved.
//

import UIKit

struct HandAngles {
    var hourHandAngle: CGFloat?
    var minuteHandAngle: CGFloat?
    var secondHandAngle: CGFloat?
    var smallSecondHandAngle: CGFloat?
}

class AnalogClockView : UIView {
    
    @IBOutlet weak var hourHand: UIImageView!
    @IBOutlet weak var minuteHand: UIImageView!
    @IBOutlet weak var secondHand: UIImageView!

    fileprivate func calculateHandAnglesForDate(_ date: Date) -> HandAngles {
        var result = HandAngles()
        
        let calender = Calendar(identifier: .gregorian)
        let timeComponents = calender.dateComponents([.hour, .minute, .second], from: date)
        let hour = (timeComponents.hour ?? 0) % 12
        let minute = timeComponents.minute
        let second = timeComponents.second
        let smallSecond = (timeComponents.second ?? 0) % 30
        
        if let minute = minute, let second = second {
            let fractionalHours = hour + minute/60
            result.hourHandAngle = .pi * 2 * CGFloat(fractionalHours/12)
            result.minuteHandAngle = .pi * 2 * CGFloat(minute/60)
            result.secondHandAngle = .pi * 2 * CGFloat(second/60)
            result.smallSecondHandAngle = .pi * 2 * CGFloat(smallSecond/30)
        }
        
        return result
    }
    
    func setTimeToDate(_ date: Date, _ animated: Bool) {
        let theHandAngles = calculateHandAnglesForDate(date)
        if !animated {
            
        }
    }
}
