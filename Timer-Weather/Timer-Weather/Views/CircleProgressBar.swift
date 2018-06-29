//
//  CircleProgressBar.swift
//  Animation
//
//  Created by Slah Layouni on 12/13/17.
//  Copyright © 2017 Layouni. All rights reserved.
//

import UIKit

class CircleProgressBar:UIView {
 
    var fullProgressNumber = 100
    
    open var progress : Int = 0 {
        didSet {
            DispatchQueue.main.async {
                self.percentageLabel.text = (self.progress < self.fullProgressNumber) ? "\(self.progress/60 + 1)'" : "\(self.progress/60)'"
                self.shapeLayer?.strokeEnd = CGFloat(self.progress)/CGFloat(self.fullProgressNumber)
            }
        }
    }
    
    open var trackerColor : UIColor = .clear {
        didSet {
            trackLayer?.strokeColor = trackerColor.cgColor
        }
    }
    
    open var progressColor : UIColor = .clear {
        didSet {
            shapeLayer?.strokeColor = progressColor.cgColor
        }
    }

    open var pulsingColor : UIColor = .clear{
        didSet {
            pulsatingLayer?.strokeColor = pulsingColor.cgColor
        }
    }
    
    open var circleBackgroundColor : UIColor = .clear {
        didSet {
            shapeLayer?.fillColor = circleBackgroundColor.cgColor
        }
    }
    
    open var progressThickness: CGFloat = 3 {
        didSet {
            shapeLayer?.lineWidth = progressThickness
            trackLayer?.lineWidth = progressThickness
        }
    }
    
    
    private func createLayer() -> CAShapeLayer
    {
        let circularPath = UIBezierPath(arcCenter: .zero, radius: self.frame.width/2, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: self.clockWise)
        let shape = CAShapeLayer()
        shape.path = circularPath.cgPath
        shape.strokeColor = UIColor.red.cgColor
        shape.lineWidth = 10
        shape.fillColor = UIColor.clear.cgColor
        shape.lineCap = kCALineCapRound
        shape.position = center
        return shape
    }
    
    private func prepareLayers(){
        shapeLayer = createLayer()
        shapeLayer?.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        shapeLayer?.strokeEnd = 0
        trackLayer = createLayer()
        pulsatingLayer = createLayer()
        shapeLayer?.strokeColor = progressColor.cgColor
        pulsatingLayer?.strokeColor = pulsingColor.cgColor
        trackLayer?.strokeColor = trackerColor.cgColor
        self.layer.addSublayer(pulsatingLayer!)
        self.layer.addSublayer(trackLayer!)
        self.layer.addSublayer(shapeLayer!)
    }
    
    private var shapeLayer:CAShapeLayer?
    private var trackLayer:CAShapeLayer?
    private var pulsatingLayer:CAShapeLayer?
    
    open lazy var percentageLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textAlignment = .center
        label.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 110)
        label.center = self.center
        label.textColor = .white
        return label
    }()
    
    var clockWise:Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.prepareLayers()
        self.addSubview(percentageLabel)
    }
    
    init(frame: CGRect,clockWise: Bool) {
        super.init(frame: frame)
        self.clockWise = clockWise
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animatePulsatingLayer() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = 1.1
        animation.duration = 0.5
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        pulsatingLayer?.add(animation, forKey: "pulsing")
    }
    
    func removeAnimatePulsatingLayer() {
        pulsatingLayer?.removeAllAnimations()
    }
}
