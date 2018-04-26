//
//  DailyCollectionViewCell.swift
//  Timer-Weather
//
//  Created by JINGLUO on 9/4/18.
//  Copyright © 2018 JINGLUO. All rights reserved.
//

import UIKit

class DailyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static func reuseId() -> String {
        return String(describing: self)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configureCell(_ weather: WeatherDetail?) {
        guard let weather = weather else {
            return
        }
        
        DispatchQueue.main.async {
            self.weatherImageView.image = UIImage(named: "rain")
            self.tempLabel.text = "\(String.fromInt(Int((weather.temperature ?? 0))))℃"
        }
    }
}



