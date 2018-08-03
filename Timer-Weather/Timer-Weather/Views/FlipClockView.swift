//
//  FlipClockView.swift
//  Timer-Weather
//
//  Created by JINGLUO on 3/6/18.
//  Copyright © 2018 JINGLUO. All rights reserved.
//

import UIKit

class FlipClockView: UIView {
    
    @IBOutlet weak var number0View: FlipNumberView!
    @IBOutlet weak var number1View: FlipNumberView!
    @IBOutlet weak var number2View: FlipNumberView!
    @IBOutlet weak var number3View: FlipNumberView!
    
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
        
        let separatorColor = UIColor().hexStringToUIColor(hex: Preferences.sharedInstance.getBackground())
        let bgColor = UIColor().hexStringToUIColor(hex: Preferences.sharedInstance.getBackground(), r: 20, g: 10, b: 0, alpha: 1.0)
        if let first = Preferences.sharedInstance.getFlipNumber(key: .firstNumber) {
            if first != hour1 {
                let lowerFirstImage = UIImage(named: flipImageForNumberLower(first))!
                let upperFirstImage = UIImage(named: flipImageForNumberUpper(first))!
                let hour1LowerImage = UIImage(named: flipImageForNumberLower(hour1))!
                number0View.setUpTransitView(a: lowerFirstImage, b: upperFirstImage, c: hour1LowerImage)
                number0View.rotation()
                
                number0View.numberImageView.image = UIImage(named: flipImageForNumber(hour1))
                
                Preferences.sharedInstance.setFlipNumber(hour1, key: .firstNumber)
            }
        } else {
            Preferences.sharedInstance.setFlipNumber(hour1, key: .firstNumber)
            number0View.numberImageView.image = UIImage(named: flipImageForNumber(hour1))
            number0View.backgroundColor = bgColor
            number0View.separatorView.backgroundColor = separatorColor
        }
        
        if let second = Preferences.sharedInstance.getFlipNumber(key: .secondNumber) {
            if second != hour2 {
                let lowerSecondImage = UIImage(named: flipImageForNumberLower(second))!
                let upperSecondImage = UIImage(named: flipImageForNumberUpper(second))!
                let hour2LowerImage = UIImage(named: flipImageForNumberLower(hour2))!
                number1View.setUpTransitView(a: lowerSecondImage, b: upperSecondImage, c: hour2LowerImage)
                number1View.rotation()

                number1View.numberImageView.image = UIImage(named: flipImageForNumber(hour2))!
                
                Preferences.sharedInstance.setFlipNumber(hour2, key: .secondNumber)
            }
        } else {
            Preferences.sharedInstance.setFlipNumber(hour2, key: .secondNumber)
            number1View.numberImageView.image = UIImage(named: flipImageForNumber(hour2))
            number1View.backgroundColor = bgColor
            number1View.separatorView.backgroundColor = separatorColor
        }
        
        if let third = Preferences.sharedInstance.getFlipNumber(key: .thirdNumber) {
            if third != min1 {
                let lowerThirdImage = UIImage(named: flipImageForNumberLower(third))!
                let upperThirdImage = UIImage(named: flipImageForNumberUpper(third))!
                let min1LowerImage = UIImage(named: flipImageForNumberLower(min1))!
                number2View.setUpTransitView(a: lowerThirdImage, b: upperThirdImage, c: min1LowerImage)
                number2View.rotation()
                
                number2View.numberImageView.image = UIImage(named: flipImageForNumber(min1))!

                Preferences.sharedInstance.setFlipNumber(min1, key: .thirdNumber)
            }
        } else {
            Preferences.sharedInstance.setFlipNumber(min1, key: .thirdNumber)
            number2View.numberImageView.image = UIImage(named: flipImageForNumber(min1))
            number2View.backgroundColor = bgColor
            number2View.separatorView.backgroundColor = separatorColor
        }
        
        if let forth = Preferences.sharedInstance.getFlipNumber(key: .forthNumber) {
            if forth != min2 {
                let lowerForthImage = UIImage(named: flipImageForNumberLower(forth))!
                let upperForthImage = UIImage(named: flipImageForNumberUpper(forth))!
                let min2LowerImage = UIImage(named: flipImageForNumberLower(min2))!
                number3View.setUpTransitView(a: lowerForthImage, b: upperForthImage, c: min2LowerImage)
                number3View.rotation()
                
                number3View.numberImageView.image = UIImage(named: flipImageForNumber(min2))!

                Preferences.sharedInstance.setFlipNumber(min2, key: .forthNumber)
            }
        } else {
            Preferences.sharedInstance.setFlipNumber(min2, key: .forthNumber)
            number3View.numberImageView.image = UIImage(named: flipImageForNumber(min2))
            number3View.backgroundColor = bgColor
            number3View.separatorView.backgroundColor = separatorColor
        }
    }
    
    fileprivate func flipImageForNumber(_ number: String) -> String {
        return "Number \(number)"
    }
    
    fileprivate func flipImageForNumberLower(_ number: String) -> String {
        return "number \(number)-bottom"
    }
    
    fileprivate func flipImageForNumberUpper(_ number: String) -> String {
        return "number \(number)-top"
    }
}
