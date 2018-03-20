//
//  MainViewController.swift
//  Timer-Weather
//
//  Created by JINGLUO on 19/3/18.
//  Copyright © 2018 JINGLUO. All rights reserved.
//

import UIKit
import RxSwift

class MainViewController: UIViewController {

    @IBOutlet weak var digitialTimerView: UIView!
    @IBOutlet weak var circleTimerView: UIView!
    @IBOutlet weak var weatherView: UIView!
    @IBOutlet weak var daysWeatherTableView: UITableView!
    
    fileprivate let disposeBag = DisposeBag()
    var viewModel: MainViewModel? {
        didSet {
            setupViewModelBinds()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = MainViewModel(APIClient())
    }

    // MARK: Bind ViewModel
    fileprivate func setupViewModelBinds() {
        
//        viewModel?.cityName.asObservable()
//            .bind(to: self.cityLabel.rx.text)
//            .disposed(by: disposeBag)
        viewModel?.cityName.asObservable()
            .filter { $0.count > 0 }
            .subscribe(onNext: { name in
                NSLog("Current city name is \(name)")
            }, onError: nil, onCompleted: nil, onDisposed: nil)
        .disposed(by: disposeBag)
        
        // MARK: bind Top info view and background theme color by currently weather data
        viewModel?.weather.asObservable()
            .filter{$0 != nil}
            .subscribe(onNext: { w in
                NSLog("Weather info is \(String(describing: w?.currently?.summary))")
//                self.updateUIBySelectedIndexPath(self.selectedIndex)
            }, onError: { error in
                print(error.localizedDescription)
            }, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
        
        // MARK: bind daily data with dailyTableview
//        viewModel?.dailyData.asObservable()
//            .bind(to: daysWeatherTableView.rx.items(cellIdentifier: DailyTableViewCell.reuseId(), cellType: DailyTableViewCell.self)) { (row, element, cell) in
//                cell.configureCell(element)
//            }
//            .disposed(by: disposeBag)
        
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

