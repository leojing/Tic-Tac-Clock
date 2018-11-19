//
//  String+Customise.swift
//  techchallenge_jingluo
//
//  Created by JINGLUO on 27/1/18.
//  Copyright © 2018 JINGLUO. All rights reserved.
//

import Foundation

extension String {
    
    static func fromFloat(_ f: Float?) -> String {
        return "\(String(describing: f ?? 0.0))"
    }
    
    static func fromInt(_ i: Int?) -> String {
        return "\(String(describing: i ?? 0))"
    }
    
    static func fromDouble(_ d: Double?) -> String {
        return "\(String(describing: d ?? 0.00))"
    }
}
