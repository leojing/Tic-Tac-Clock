//
//  UIView+performBlockAfterDelay.swift
//  Timer-Weather
//
//  Created by JINGLUO on 3/4/18.
//  Copyright © 2018 JINGLUO. All rights reserved.
//

import UIKit

extension UIView {
    
    func performBlockOnMainQueue(_ complection: @escaping (()->()), _ afterDelay: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + afterDelay) {
            complection()
        }
    }
}
