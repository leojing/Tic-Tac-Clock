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

@IBDesignable
class AnalogClockView : NibView {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var upperDialBackgroundImageView: UIImageView!
    @IBOutlet weak var bottomDialBackgroundImageView: UIImageView!

    @IBOutlet weak var hourHand: UIImageView!
    @IBOutlet weak var minuteHand: UIImageView!
    @IBOutlet weak var secondHand: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!

    fileprivate var oldHandAngles: HandAngles?
    
    @IBInspectable var date: Date? {
        didSet {
            guard let date = date else {
                return
            }
            setClockWithDate(date, animated: false)
        }
    }
    
    @IBInspectable var watchFace: String? {
        didSet {
            backgroundImageView.image = UIImage(named: watchFace ?? "")
        }
    }
    
    @IBInspectable var isDarkTheme: Bool = true {
        didSet {
            upperDialBackgroundImageView.image = isDarkTheme ? UIImage(named: "upper-dial-light") : UIImage(named: "upper-dial")
            bottomDialBackgroundImageView.image = isDarkTheme ? UIImage(named: "bottom-dial-light") : UIImage(named: "bottom-dial")
            secondHand.image = isDarkTheme ? UIImage(named: "bottom-dial-second-light") : UIImage(named: "bottom-dial-second")
        }
    }
    
    func setClockWithDate(_ date: Date, animated: Bool) {
        dateLabel.text = date.dayOfWeek(Preferences.sharedInstance.getDateFormat())
        
        let theHandAngles = calculateHandAnglesForDate(date)
        if !animated {
            hourHand.transform = CGAffineTransform(rotationAngle: theHandAngles.hourHandAngle!)
            minuteHand.transform = CGAffineTransform(rotationAngle: theHandAngles.minuteHandAngle!)
            secondHand.transform = CGAffineTransform(rotationAngle: theHandAngles.secondHandAngle!)
            return
        }
        
        if let second = theHandAngles.secondHandAngle, let oldSecond = oldHandAngles?.secondHandAngle {
            let big_change = abs(second - oldSecond) > .pi/4
            let duration = big_change ? 0.6 : 0.3
            animateHandView(secondHand, second, CGFloat(duration))
        }
        self.performBlockOnMainQueue({
            if let minute = theHandAngles.minuteHandAngle, let oldMinute = self.oldHandAngles?.minuteHandAngle {
                let big_change = abs(minute - oldMinute) > .pi/4
                let duration = big_change ? 0.6 : 0.3
                self.animateHandView(self.minuteHand, minute, CGFloat(duration))
            }
            
            if let hour = theHandAngles.hourHandAngle, let oldHour = self.oldHandAngles?.hourHandAngle {
                let big_change = abs(hour - oldHour) > .pi/4
                let duration = big_change ? 0.6 : 0.3
                self.animateHandView(self.hourHand, hour, CGFloat(duration))
            }
        }, 0.0)
        
        oldHandAngles = theHandAngles
    }
    
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
            result.hourHandAngle = .pi * 2 * CGFloat(fractionalHours)/12.0
            result.minuteHandAngle = .pi * 2 * CGFloat(minute)/60.0
            result.secondHandAngle = .pi * 2 * CGFloat(second)/60.0
            result.smallSecondHandAngle = .pi * 2 * CGFloat(smallSecond)/30.0
        }
        
        return result
    }

    fileprivate func animateHandView(_ theHandView: UIImageView, _ toAngle: CGFloat, _ duration: CGFloat) {
        var damping = 0.2
        if duration > 0.4 {
            damping = 0.6
        }
        
        UIView.animate(withDuration: TimeInterval(duration), delay: 0, usingSpringWithDamping: CGFloat(damping), initialSpringVelocity: 0.8, options: UIView.AnimationOptions(rawValue: 0), animations: {
            theHandView.transform = CGAffineTransform(rotationAngle: toAngle)
        }, completion: nil)
    }
}
