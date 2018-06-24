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
                let lowerFirstImage = UIImage(named: flipImageForNumberLower(first))!
                let upperFirstImage = UIImage(named: flipImageForNumberUpper(first))!
                let hour1LowerImage = UIImage(named: flipImageForNumberLower(hour1))!
                number0View.setUpTransitView(a: lowerFirstImage, b: upperFirstImage, c: hour1LowerImage)
                number0View.rotation()
                
                number0View.numberImageView.image = UIImage(named: flipImageForNumber(hour1))
                
                userDefault.set(hour1, forKey: FlipClockNumbers.firstNumber)
            }
        } else {
            userDefault.set(hour1, forKey: FlipClockNumbers.firstNumber)
            number0View.numberImageView.image = UIImage(named: flipImageForNumber(hour1))
        }
        
        if let second = userDefault.value(forKey: FlipClockNumbers.secondNumber) as? String {
            if second != hour2 {
                let lowerSecondImage = UIImage(named: flipImageForNumberLower(second))!
                let upperSecondImage = UIImage(named: flipImageForNumberUpper(second))!
                let hour2LowerImage = UIImage(named: flipImageForNumberLower(hour2))!
                number1View.setUpTransitView(a: lowerSecondImage, b: upperSecondImage, c: hour2LowerImage)
                number1View.rotation()

                number1View.numberImageView.image = UIImage(named: flipImageForNumber(hour2))!
                
                userDefault.set(hour2, forKey: FlipClockNumbers.secondNumber)
            }
        } else {
            userDefault.set(hour2, forKey: FlipClockNumbers.secondNumber)
            number1View.numberImageView.image = UIImage(named: flipImageForNumber(hour2))
        }
        
        if let third = userDefault.value(forKey: FlipClockNumbers.thirdNumber) as? String {
            if third != min1 {
                let lowerThirdImage = UIImage(named: flipImageForNumberLower(third))!
                let upperThirdImage = UIImage(named: flipImageForNumberUpper(third))!
                let min1LowerImage = UIImage(named: flipImageForNumberLower(min1))!
                number2View.setUpTransitView(a: lowerThirdImage, b: upperThirdImage, c: min1LowerImage)
                number2View.rotation()
                
                number2View.numberImageView.image = UIImage(named: flipImageForNumber(min1))!

                userDefault.set(min1, forKey: FlipClockNumbers.thirdNumber)
            }
        } else {
            userDefault.set(min1, forKey: FlipClockNumbers.thirdNumber)
            number2View.numberImageView.image = UIImage(named: flipImageForNumber(min1))
        }
        
        if let forth = userDefault.value(forKey: FlipClockNumbers.forthNumber) as? String {
            if forth != min2 {
                let lowerForthImage = UIImage(named: flipImageForNumberLower(forth))!
                let upperForthImage = UIImage(named: flipImageForNumberUpper(forth))!
                let min2LowerImage = UIImage(named: flipImageForNumberLower(min2))!
                number3View.setUpTransitView(a: lowerForthImage, b: upperForthImage, c: min2LowerImage)
                number3View.rotation()
                
                number3View.numberImageView.image = UIImage(named: flipImageForNumber(min2))!

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
    
    fileprivate func flipImageForNumberLower(_ number: String) -> String {
        return "Number \(number) Lower"
    }
    
    fileprivate func flipImageForNumberUpper(_ number: String) -> String {
        return "Number \(number) Upper"
    }
}
