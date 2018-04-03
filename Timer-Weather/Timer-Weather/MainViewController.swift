//
//  MainViewController.swift
//  Timer-Weather
//
//  Created by JINGLUO on 19/3/18.
//  Copyright © 2018 JINGLUO. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import HGCircularSlider

class MainViewController: UIViewController {

    @IBOutlet weak var digitalTimerView: UIView!
    @IBOutlet weak var digitalTimerLabel: UILabel!
    
    @IBOutlet weak var circleTimerView: UIView!
    @IBOutlet weak var clockView: AnalogClockView!
    
    @IBOutlet weak var weatherView: UIView!
    @IBOutlet weak var daysWeatherTableView: UITableView!
    
    @IBOutlet weak var cityNameLabel: UILabel!

    fileprivate let disposeBag = DisposeBag()
    var viewModel: MainViewModel? {
        didSet {
            setupViewModelBinds()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        viewModel = MainViewModel(APIClient())
    }
    
    fileprivate func setupTableView() {
        daysWeatherTableView.estimatedRowHeight = 30
        daysWeatherTableView.rowHeight = UITableViewAutomaticDimension
        daysWeatherTableView.register(DailyTableViewCell.nib(), forCellReuseIdentifier: DailyTableViewCell.reuseId())
    }

    // MARK: Bind ViewModel
    fileprivate func setupViewModelBinds() {
        
        viewModel?.currentDigitalTime.asObservable()
        .bind(to: self.digitalTimerLabel.rx.text)
        .disposed(by: disposeBag)
        
        viewModel?.currentDate.asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { date in
                self.clockView.setTimeToDate(date, true)
            }, onError: nil, onCompleted: nil, onDisposed: nil)
        .disposed(by: disposeBag)
        
        viewModel?.cityName.asObservable()
        .bind(to: self.cityNameLabel.rx.text)
        .disposed(by: disposeBag)
        
        // MARK: bind Top info view and background theme color by currently weather data
        viewModel?.weather.asObservable()
            .filter{$0 != nil}
            .subscribe(onNext: { w in
                NSLog("Weather info is \(String(describing: w?.currently?.summary))")
            }, onError: { error in
                print(error.localizedDescription)
            }, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
        
        // MARK: bind daily data with dailyTableview
        viewModel?.dailyData.asObservable()
            .bind(to: daysWeatherTableView.rx.items(cellIdentifier: DailyTableViewCell.reuseId(), cellType: DailyTableViewCell.self)) { (row, element, cell) in
                cell.configureCell(element)
            }
            .disposed(by: disposeBag)
        
       // MARK: show error message
        viewModel?.alertMessage.asObservable()
            .filter { $0.count > 0 }
            .subscribe(onNext: { errorMessage in
                self.showAlert(errorMessage)
            }, onError: nil, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
    }
    
    // MARK: Actions
    
    fileprivate func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}

// MARK: - Utilis

extension MainViewController {
    
    fileprivate func getHourDigital(_ date: String) -> CGFloat {
        let offset2Index = date.index(date.startIndex, offsetBy: 2)
        let subStringToHour = String(date[..<offset2Index])
        return CGFloat(Double(subStringToHour) ?? 0)
    }
    
    fileprivate func getMinDigital(_ date: String) -> CGFloat {
        let startIndex = date.index(date.startIndex, offsetBy: 3)
        let offset2Index = date.index(startIndex, offsetBy: 2)
        let subStringToMin = String(date[startIndex..<offset2Index])
        return CGFloat(Double(subStringToMin) ?? 0)
    }
}
