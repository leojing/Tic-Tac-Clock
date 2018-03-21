//
//  DailyTableViewCell.swift
//  techchallenge_jingluo
//
//  Created by JINGLUO on 26/1/18.
//  Copyright © 2018 JINGLUO. All rights reserved.
//

import Foundation
import UIKit
import SwiftIcons

class DailyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    static func reuseId() -> String {
        return String(describing: self)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func layoutSubviews() {
        iconImageView.layoutIfNeeded()
    }
    
    func configureCell(_ weather: WeatherDetail?) {
        guard let weather = weather else {
            return
        }
        
        if let icon = weather.icon, let iconType = ThemeColor.fromDescription(icon)?.convertToIcon() {
            iconImageView.setIcon(icon: iconType, textColor: .white, backgroundColor: .clear, size: nil)
        }
        let date = Date(timeIntervalSince1970: Double(weather.time ?? 0))
        dateLabel.text = date.dayOfWeek()
        highTempLabel.text = "\(String.fromInt(Int((weather.temperatureHigh ?? 0))))℉"
        lowTempLabel.text = "\(String.fromInt(Int((weather.temperatureLow ?? 0))))℉"
    }
}
