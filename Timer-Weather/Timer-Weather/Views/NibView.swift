//
//  NibView.swift
//  Timer-Weather
//
//  Created by JINGLUO on 7/2/19.
//  Copyright © 2019 JINGLUO. All rights reserved.
//

import UIKit

class NibView: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        if let loadedView = Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? UIView {
            loadedView.frame = self.bounds
            loadedView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            addSubview(loadedView)
        }
    }
}
