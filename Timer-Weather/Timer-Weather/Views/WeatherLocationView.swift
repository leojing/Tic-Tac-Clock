//
//  WeatherLocationView.swift
//  Timer-Weather
//
//  Created by JINGLUO on 12/2/19.
//  Copyright © 2019 JINGLUO. All rights reserved.
//

import UIKit

class WeatherLocationView: NibView {
    
    @IBOutlet private weak var loadingActivityView: UIActivityIndicatorView?
    @IBOutlet private weak var locationLabel: UILabel?
    @IBOutlet private weak var weatherView: UIStackView?

    struct Configuration {
        let isLoading: Bool
        let isShowLocation: Bool
        let location: String?
        let isShowWeather: Bool
        let weathers: [WeatherDetail]?
    }
    
    var configuration: WeatherLocationView.Configuration? {
        didSet {
            populateView()
        }
    }
    
    private func populateView() {
        (configuration?.isLoading ?? true) ? loadingActivityView?.startAnimating() : loadingActivityView?.stopAnimating()
        
        locationLabel?.isHidden = configuration?.isShowLocation ?? true
        locationLabel?.text = configuration?.location ?? "Not found"
        
        weatherView?.isHidden = configuration?.isShowWeather ?? true
        weatherView?.arrangedSubviews.forEach({ view in
            weatherView?.removeArrangedSubview(view)
        })
        configuration?.weathers?.forEach({ weather in
            guard let weatherView = self.weatherView else {
                return
            }
            weatherView.addArrangedSubview(DailyWeatherView(icon: weather.icon, temperature: String(describing: weather.temperature)))
        })
    }
}
