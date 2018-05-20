//
//  Date+Customise.swift
//  techchallenge_jingluo
//
//  Created by JINGLUO on 27/1/18.
//  Copyright © 2018 JINGLUO. All rights reserved.
//

import Foundation

extension Date {
    
    func dayOfWeekShort() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.dateFormat = "EE dd"
        return dateFormatter.string(from: self)
    }
    
    func dayOfWeekLong() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, dd MMMM"
        return dateFormatter.string(from: self)
    }
    
    func dayOfWeek(_ format: String?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format ?? "EEEE, dd MMMM"
        return dateFormatter.string(from: self)
    }
    
    func timeOfHour() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: self)
    }
    
    func timeOfCounter() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self)
    }
}
