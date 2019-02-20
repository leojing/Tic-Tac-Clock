//
//  FlipClockView.swift
//  Timer-Weather
//
//  Created by JINGLUO on 3/6/18.
//  Copyright © 2018 JINGLUO. All rights reserved.
//

import UIKit

@IBDesignable
class FlipClockView: NibView {
    
    enum Axis: Int {
        case horizontal
        case vertical
    }
    
    @IBOutlet private weak var containerStackView: UIStackView?

    @IBOutlet private weak var number0View: FlipNumberView?
    @IBOutlet private weak var number1View: FlipNumberView?
    @IBOutlet private weak var number2View: FlipNumberView?
    @IBOutlet private weak var number3View: FlipNumberView?
    
    @IBInspectable var axisValue: Int = 0 {
        didSet {
            axis = FlipClockView.Axis(rawValue: axisValue) ?? .horizontal
        }
    }
    
    private var axis: FlipClockView.Axis = .horizontal {
        didSet {
            containerStackView?.axis = NSLayoutConstraint.Axis(rawValue: axis.rawValue) ?? .horizontal
            containerStackView?.layoutIfNeeded()
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


// MARK: - Conform to ClockProtocol

extension FlipClockView: ClockProtocol {
    
    func setClockWithDate(_ date: Date, animated: Bool) {
        let dateString = date.timeOfCounter()
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
        if let first = Preferences.sharedInstance.getFlipNumber(key: .firstNumber), first != hour1 {
            number0View?.configuration = FlipNumberView.Configuration(background: nil, number: flipImageForNumber(hour1), transitA: flipImageForNumberLower(first), transitB: flipImageForNumberUpper(first), transitC: flipImageForNumberLower(hour1), separatorColor: separatorColor)
            number0View?.rotation()
            
            Preferences.sharedInstance.setFlipNumber(hour1, key: .firstNumber)
        } else {
            Preferences.sharedInstance.setFlipNumber(hour1, key: .firstNumber)
            number0View?.configuration = FlipNumberView.Configuration(background: bgColor, number: flipImageForNumber(hour1), transitA: nil, transitB: nil, transitC: nil, separatorColor: separatorColor)
        }
        
        if let second = Preferences.sharedInstance.getFlipNumber(key: .secondNumber), second != hour2 {
            number1View?.configuration = FlipNumberView.Configuration(background: bgColor, number: flipImageForNumber(hour2), transitA: flipImageForNumberLower(second), transitB: flipImageForNumberUpper(second), transitC: flipImageForNumberLower(hour2), separatorColor: separatorColor)
            number1View?.rotation()
            
            Preferences.sharedInstance.setFlipNumber(hour2, key: .secondNumber)
        } else {
            Preferences.sharedInstance.setFlipNumber(hour2, key: .secondNumber)
            number1View?.configuration = FlipNumberView.Configuration(background: bgColor, number: flipImageForNumber(hour2), transitA: nil, transitB: nil, transitC: nil, separatorColor: separatorColor)
        }
        
        if let third = Preferences.sharedInstance.getFlipNumber(key: .thirdNumber), third != min1 {
            number2View?.configuration = FlipNumberView.Configuration(background: bgColor, number: flipImageForNumber(min1), transitA: flipImageForNumberLower(third), transitB: flipImageForNumberUpper(third), transitC: flipImageForNumberLower(min1), separatorColor: separatorColor)
            number2View?.rotation()
            
            Preferences.sharedInstance.setFlipNumber(min1, key: .thirdNumber)
        } else {
            Preferences.sharedInstance.setFlipNumber(min1, key: .thirdNumber)
            number2View?.configuration = FlipNumberView.Configuration(background: bgColor, number: flipImageForNumber(min1), transitA: nil, transitB: nil, transitC: nil, separatorColor: separatorColor)
        }
        
        if let forth = Preferences.sharedInstance.getFlipNumber(key: .forthNumber), forth != min2 {
            number3View?.configuration = FlipNumberView.Configuration(background: bgColor, number: flipImageForNumber(min2), transitA: flipImageForNumberLower(forth), transitB: flipImageForNumberUpper(forth), transitC: flipImageForNumberLower(min2), separatorColor: separatorColor)
            number3View?.rotation()
            
            Preferences.sharedInstance.setFlipNumber(min2, key: .forthNumber)
        } else {
            Preferences.sharedInstance.setFlipNumber(min2, key: .forthNumber)
            number3View?.configuration = FlipNumberView.Configuration(background: bgColor, number: flipImageForNumber(min2), transitA: nil, transitB: nil, transitC: nil, separatorColor: separatorColor)
        }
    }
}
