//
//  FlipClockView.swift
//  Timer-Weather
//
//  Created by JINGLUO on 3/6/18.
//  Copyright © 2018 JINGLUO. All rights reserved.
//

import UIKit

enum FlipClockNumbers {
    static let firstNumber = "firstNumber"
    static let secondNumber = "secondNumber"
    static let thirdNumber = "thirdNumber"
    static let forthNumber = "forthNumber"
}

class FlipClockView: UIView {
    
    @IBOutlet weak var number0View: FlipNumberView!
    @IBOutlet weak var number1View: FlipNumberView!
    @IBOutlet weak var number2View: FlipNumberView!
    @IBOutlet weak var number3View: FlipNumberView!

    let userDefault = UserDefaults.standard
    
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
        
        if let first = userDefault.value(forKey: FlipClockNumbers.firstNumber) as? String {
            if first != hour1 {
                let firstImage = UIImage(named: flipImageForNumber(first))!
                let hour1Image = UIImage(named: flipImageForNumber(hour1))!
                number0View.setUpTransitView(a: firstImage, b: firstImage, c: hour1Image)
                number0View.rotation()
                
                number0View.numberImageView.image = hour1Image
                
                userDefault.set(hour1, forKey: FlipClockNumbers.firstNumber)
            }
        } else {
            userDefault.set(hour1, forKey: FlipClockNumbers.firstNumber)
            number0View.numberImageView.image = UIImage(named: flipImageForNumber(hour1))
        }
        
        if let second = userDefault.value(forKey: FlipClockNumbers.secondNumber) as? String {
            if second != hour2 {
                let secondImage = UIImage(named: flipImageForNumber(second))!
                let hour2Image = UIImage(named: flipImageForNumber(hour2))!
                number1View.setUpTransitView(a: secondImage, b: secondImage, c: hour2Image)
                number1View.rotation()

                number1View.numberImageView.image = hour2Image
                
                userDefault.set(hour2, forKey: FlipClockNumbers.secondNumber)
            }
        } else {
            userDefault.set(hour2, forKey: FlipClockNumbers.secondNumber)
            number1View.numberImageView.image = UIImage(named: flipImageForNumber(hour2))
        }
        
        if let third = userDefault.value(forKey: FlipClockNumbers.thirdNumber) as? String {
            if third != min1 {
                let thirdImage = UIImage(named: flipImageForNumber(third))!
                let min1Image = UIImage(named: flipImageForNumber(min1))!
                number2View.setUpTransitView(a: thirdImage, b: thirdImage, c: min1Image)
                number2View.rotation()
                
                number2View.numberImageView.image = min1Image

                userDefault.set(min1, forKey: FlipClockNumbers.thirdNumber)
            }
        } else {
            userDefault.set(min1, forKey: FlipClockNumbers.thirdNumber)
            number2View.numberImageView.image = UIImage(named: flipImageForNumber(min1))
        }
        
        if let forth = userDefault.value(forKey: FlipClockNumbers.forthNumber) as? String {
            if forth != min2 {
                let forthImage = UIImage(named: flipImageForNumber(forth))!
                let min2Image = UIImage(named: flipImageForNumber(min2))!
                number3View.setUpTransitView(a: forthImage, b: forthImage, c: min2Image)
                number3View.rotation()
                
                number3View.numberImageView.image = min2Image

                userDefault.set(min2, forKey: FlipClockNumbers.forthNumber)
            }
        } else {
            userDefault.set(min2, forKey: FlipClockNumbers.forthNumber)
            number3View.numberImageView.image = UIImage(named: flipImageForNumber(min2))
        }
    }
    
    fileprivate func flipImageForNumber(_ number: String) -> String {
        return "number-\(number)"
    }
}
