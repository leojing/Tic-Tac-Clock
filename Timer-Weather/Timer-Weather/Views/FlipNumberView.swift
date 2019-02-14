//
//  FlipNumberView.swift
//  Timer-Weather
//
//  Created by JINGLUO on 18/6/18.
//  Copyright © 2018 JINGLUO. All rights reserved.
//

import UIKit

@IBDesignable
class FlipNumberView: NibView {
    
    @IBOutlet private weak var separatorView: UIView?
    @IBOutlet private weak var numberImageView: UIImageView?
    @IBOutlet private weak var AImageView: UIImageView?
    @IBOutlet private weak var BImageView: UIImageView?
    @IBOutlet private weak var CImageView: UIImageView?
    
    struct Configuration {
        let background: UIColor?
        let number: String?
        let transitA: String?
        let transitB: String?
        let transitC: String?
        let separatorColor: UIColor?
    }
    
    var configuration: FlipNumberView.Configuration? {
        didSet {
            populateView()
        }
    }
    
    convenience init(configuration: FlipNumberView.Configuration?) {
        self.init()
        self.configuration = configuration
    }
    
    private func populateView() {
        numberImageView?.backgroundColor = backgroundColor ?? .clear
        setUpTransitView(a: UIImage(named: configuration?.transitA ?? ""), b: UIImage(named: configuration?.transitB ?? ""), c: UIImage(named: configuration?.transitC ?? ""))
        separatorView?.backgroundColor = configuration?.separatorColor ?? .clear
    }
    
    @objc func initializeABC() {
        AImageView?.alpha = 0
        BImageView?.alpha = 0
        CImageView?.alpha = 0
    }
    
    func setUpTransitView(a: UIImage?, b: UIImage?, c: UIImage?) {
        AImageView?.image = a
        BImageView?.image = b
        CImageView?.image = c
    }
    
    func rotation(){
        AImageView?.alpha = 1
        BImageView?.alpha = 1
        CImageView?.alpha = 1
        if let b = BImageView {
            rotationFirst(view: b)
        }
        //本文中提到的B，显示13
        if let c = CImageView {
            rotationSecond(view: c)
        }
        //本文中提到的C，显示14
        self.perform(#selector(self.initializeABC), with: nil, afterDelay: 0.9)
        //最后为了过度顺利，提前0.1秒让A/B/C小时
        //initializeABC函数设置A/B/C隐藏
    }
    
    private func rotationFirst(view: UIView){
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
    
    private func rotationSecond(view: UIView) {
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
