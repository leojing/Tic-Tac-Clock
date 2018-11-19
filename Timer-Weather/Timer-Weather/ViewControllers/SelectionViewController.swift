//
//  SelectionViewController.swift
//  Timer-Weather
//
//  Created by JINGLUO on 21/3/18.
//  Copyright © 2018 JINGLUO. All rights reserved.
//

import UIKit

enum SelectionType: String {
    case dateFormat = "Date Format"
    case watchFace = "Watch Face"
    case background = "Background Color"
}

class SelectionViewController: BaseViewController {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    
    var selectionType: SelectionType?
    private let userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        
        if let colors = selectionType?.getbackgroundColors() {
            let selectedIndex = getSelectedIndexPath(selectionType)
            Preferences.sharedInstance.setBackground(colors[selectedIndex])
        }
        
        if let type = selectionType {
            switch type {
            case .dateFormat:
                self.navigationBar.items?.first?.title = Localizable.dateFormat

            case .watchFace:
                Preferences.sharedInstance.removeFlipNumbers()
                self.navigationBar.items?.first?.title = Localizable.watchFace

            case .background:
                self.navigationBar.items?.first?.title = Localizable.backgroundColor
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViewsBackgroundColor()
    }
    
    fileprivate func updateViewsBackgroundColor() {
        let colorString = Preferences.sharedInstance.getBackground()
        let bgColor = UIColor().hexStringToUIColor(hex: colorString)
        navigationBar.barTintColor = bgColor
        self.view.backgroundColor = bgColor
    }
    
    // MARK: set & get for selected index of data
    
    func setSelectedIndexPath(_ index: Int, _ selectiontype: SelectionType?) {
        userDefaults.setValue(index, forKey: "index of \(selectiontype.debugDescription)")
    }
    
    func getSelectedIndexPath( _ selectiontype: SelectionType?) -> Int {
        if let index = userDefaults.value(forKey: "index of \(selectiontype.debugDescription)") {
            return index as! Int
        }
        return 0
    }

    // MARK: Actions
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension SelectionViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = selectionType?.getContentList()?.count {
            return count
        }
        return 0
    }
}

extension SelectionViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectionTableViewCell.self.reuseId()) as! SelectionTableViewCell
        
        cell.indexPath = indexPath
        let selectedIndex = getSelectedIndexPath(selectionType)
        if let list = selectionType?.getContentList() {
            cell.configureCell(selectionType, list[indexPath.row], isSelected: (selectedIndex == indexPath.row))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let type = selectionType else {
            return
        }
    
        switch type {
        case .background:
            if let colors = type.getbackgroundColors() {
                Preferences.sharedInstance.setBackground(colors[indexPath.row])
            }
            updateViewsBackgroundColor()

        case .dateFormat:
            if let formats = type.getDateFormats() {
                Preferences.sharedInstance.setDateFormat(formats[indexPath.row])
            }
            
        case .watchFace:
            Preferences.sharedInstance.setWatchFace(indexPath.row)
        }
        
        let selectedIndex = getSelectedIndexPath(selectionType)
        setSelectedIndexPath(indexPath.row, selectionType)
        tableView.reloadRows(at: [IndexPath(row: selectedIndex, section: 0), indexPath], with: .none)
    }
}

extension SelectionType {
    
    func getContentList() -> [String?]? {
        switch self {
        case .background:
            return ["Black", "Red respberry", "Denim blue", "Blue cobalt",
                    "Dark olive", "Rose red", "Ultra violet", "Spicy orange",
                    "Cosmos blue", "Midnight blue", "Red",
                    "Bright orange", "Electric blue", "Soft pink",
                    "Taupe", "Charcoal grey", "Dark aubergine", "Cosmos blue", "Pink fuchsia",
                    "Saddle brown", "Pink", "Purple", "Blue", "Teal blue", "Green",
                    "2017", "2016", "2015", "2014", "2013",
                    "2012", "2011", "2010"]
            
        case .dateFormat:
            return getCurrentDateWithFormat()
            
        case .watchFace:
            return ["chronography-black", "chronography-blue", "chronography-brown", "chronography-green", "chronography-grey", "chronography-light-blue", "chronography-light-grey", "chronography-light-yellow", Date().timeOfCounter() ?? "09:28", Date().timeOfCounter() ?? "09:28"]
        }
    }
    
    private func getCurrentDateWithFormat() -> [String]? {
        let date = Date()
        let formats = getDateFormats()
        return formats?.map { format in
                return date.dayOfWeek(format)
            }
    }
    
    func getbackgroundColors() -> [String]? {
        if self == .background {
            return ["#000000", "#c96167", "#637fa1", "#4c5c77",
                    "#5a574f", "#a44459", "#4b3b7d", "#e37c5a",
                    "#3d4d57", "#4a4d5d", "#a3262a",
                    "#d96646", "#4869a9", "#dda69c",
                    "#888078", "#494844", "#362d39", "#3a4d5b", "#a74f63",
                    "#986448", "#ff2d55", "#5856d6", "#007aff", "#5ac8fa", "#4cd964",
                    "#88b04b", "#92A8D1", "#955251", "#B565A7", "#009B77",
                    "#d3543b", "#cb6586", "#64b6ac"]
        }
        return nil
    }
    
    func getDateFormats() -> [String]? {
        if self == .dateFormat {
            return ["YYYY/MM/dd", "YYYY/MM/dd, EEEE", "YYYY-MM-dd", "YYYY-MM-dd, EEEE",
                    "dd MMM YYYY", "dd MMM YYYY, EEEE", "MMM dd", "MMM dd, EEEE",
                    "MM-dd", "MM-dd, EEEE"]
        }
        return nil
    }
}
