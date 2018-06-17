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
    
    @IBOutlet weak var number0ImageView: UIImageView!
    @IBOutlet weak var number1ImageView: UIImageView!
    @IBOutlet weak var number2ImageView: UIImageView!
    @IBOutlet weak var number3ImageView: UIImageView!

    @IBOutlet weak var A0ImageView: UIImageView!
    @IBOutlet weak var B0ImageView: UIImageView!
    @IBOutlet weak var C0ImageView: UIImageView!
    
    @IBOutlet weak var A1ImageView: UIImageView!
    @IBOutlet weak var B1ImageView: UIImageView!
    @IBOutlet weak var C1ImageView: UIImageView!
    
    @IBOutlet weak var A2ImageView: UIImageView!
    @IBOutlet weak var B2ImageView: UIImageView!
    @IBOutlet weak var C2ImageView: UIImageView!
    
    @IBOutlet weak var A3ImageView: UIImageView!
    @IBOutlet weak var B3ImageView: UIImageView!
    @IBOutlet weak var C3ImageView: UIImageView!

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
                A0ImageView.image = UIImage(named: flipImageForNumber(first))
                B0ImageView.image = UIImage(named: flipImageForNumber(first))
                C0ImageView.image = UIImage(named: flipImageForNumber(hour1))
                rotation(A: A0ImageView, B: B0ImageView, C: C0ImageView)
                
                number0ImageView.image = UIImage(named: flipImageForNumber(hour1))
                
                userDefault.set(hour1, forKey: FlipClockNumbers.firstNumber)
            }
        } else {
            userDefault.set(hour1, forKey: FlipClockNumbers.firstNumber)
            number0ImageView.image = UIImage(named: flipImageForNumber(hour1))
        }
        
        if let second = userDefault.value(forKey: FlipClockNumbers.secondNumber) as? String {
            if second != hour2 {
                A1ImageView.image = UIImage(named: flipImageForNumber(second))
                B1ImageView.image = UIImage(named: flipImageForNumber(second))
                C1ImageView.image = UIImage(named: flipImageForNumber(hour2))
                rotation(A: A1ImageView, B: B1ImageView, C: C1ImageView)
                
                number1ImageView.image = UIImage(named: flipImageForNumber(hour2))
                
                userDefault.set(hour2, forKey: FlipClockNumbers.secondNumber)
            }
        } else {
            userDefault.set(hour2, forKey: FlipClockNumbers.secondNumber)
            number1ImageView.image = UIImage(named: flipImageForNumber(hour2))
        }
        
        if let third = userDefault.value(forKey: FlipClockNumbers.thirdNumber) as? String {
            if third != min1 {
                A2ImageView.image = UIImage(named: flipImageForNumber(third))
                B2ImageView.image = UIImage(named: flipImageForNumber(third))
                C2ImageView.image = UIImage(named: flipImageForNumber(min1))
                rotation(A: A2ImageView, B: B2ImageView, C: C2ImageView)
                
                number2ImageView.image = UIImage(named: flipImageForNumber(min1))
                
                userDefault.set(min1, forKey: FlipClockNumbers.thirdNumber)
            }
        } else {
            userDefault.set(min1, forKey: FlipClockNumbers.thirdNumber)
            number2ImageView.image = UIImage(named: flipImageForNumber(min1))
        }
        
        if let forth = userDefault.value(forKey: FlipClockNumbers.forthNumber) as? String {
            if forth != min2 {
                A3ImageView.image = UIImage(named: flipImageForNumber(forth))
                B3ImageView.image = UIImage(named: flipImageForNumber(forth))
                C3ImageView.image = UIImage(named: flipImageForNumber(min2))
                rotation(A: A3ImageView, B: B3ImageView, C: C3ImageView)
                
                number3ImageView.image = UIImage(named: flipImageForNumber(min2))
                
                userDefault.set(min2, forKey: FlipClockNumbers.forthNumber)
            }
        } else {
            userDefault.set(min2, forKey: FlipClockNumbers.forthNumber)
            number3ImageView.image = UIImage(named: flipImageForNumber(min2))
        }
    }
    
    fileprivate func flipImageForNumber(_ number: String) -> String {
        return "number-\(number)"
    }
    
    @objc func initializeABC(views: [UIView]) {
        views[0].alpha = 0
        views[1].alpha = 0
        views[2].alpha = 0
    }
    
    func rotation(A:UIView, B:UIView, C:UIView){
        A.alpha = 1
        B.alpha = 1
        C.alpha = 1
        rotationFirst(view: B)
        //本文中提到的B，显示13
        rotationSecond(view: C)
        //本文中提到的C，显示14
        self.perform(#selector(self.initializeABC), with: [A, B, C], afterDelay: 0.9)
        //最后为了过度顺利，提前0.1秒让A/B/C小时
        //initializeABC函数设置A/B/C隐藏
    }
    
    func rotationFirst(view:UIView){
        //旧值标签，先出来
        let animation = CABasicAnimation(keyPath: "transform.rotation.x")
        animation.fromValue = (-10/360)*Double.pi
        animation.toValue = (-355/360)*Double.pi
        animation.duration = 1.0
        animation.repeatCount = 0
        animation.delegate = self as? CAAnimationDelegate
        view.layer.add(animation, forKey: "rotationSecond")
        view.alpha = 1
    }
    
    func rotationSecond(view:UIView) {
        //新值标签，后
        let animation = CABasicAnimation(keyPath: "transform.rotation.x")
        animation.fromValue = (355/360) * Double.pi
        animation.toValue = (10/360) * Double.pi
        animation.duration = 1.0
        animation.repeatCount = 0
        animation.delegate = self as? CAAnimationDelegate
        view.layer.add(animation, forKey: "rotationFirst")
        view.alpha = 1
    }
}
