//
//  Date+Customise.swift
//  techchallenge_jingluo
//
//  Created by JINGLUO on 27/1/18.
//  Copyright © 2018 JINGLUO. All rights reserved.
//

import Foundation

extension Date {
    
    func dayOfWeek() -> String? {
        let weekDays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
        let index = Calendar.current.component(.weekday, from: self)
        return weekDays[index - 1]
    }
    
    func timeOfHour() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ha"
        return dateFormatter.string(from: self)
    }
}
