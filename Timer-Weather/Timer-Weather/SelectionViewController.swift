//
//  SelectionViewController.swift
//  Timer-Weather
//
//  Created by JINGLUO on 21/3/18.
//  Copyright © 2018 JINGLUO. All rights reserved.
//

import UIKit

enum SelectionType: String {
    case dateFormat = "Date Fromat"
    case watchFace = "Watch Face"
    case background = "Background Colour"
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
        tableView.estimatedRowHeight = 30
        tableView.rowHeight = UITableViewAutomaticDimension
        
        if let colors = selectionType?.getbackgroundColors() {
            let selectedIndex = getSelectedIndexPath(selectionType)
            SettingsViewModel.sharedInstance.setBackground(colors[selectedIndex])
        }
        
        self.navigationBar.items?.first?.title = selectionType?.rawValue
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViewsBackgroundColor()
    }
    
    fileprivate func updateViewsBackgroundColor() {
        if let colorString = SettingsViewModel.sharedInstance.getBackground() {
            let bgColor = UIColor().hexStringToUIColor(hex: colorString)
            navigationBar.barTintColor = bgColor
            self.view.backgroundColor = bgColor
        }
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
        if let count = selectionType?.getContentList().count {
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
        cell.configureCell(selectionType, selectionType?.getContentList()[indexPath.row], isSelected: (selectedIndex == indexPath.row))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let type = selectionType else {
            return
        }
    
        switch type {
        case .background:
            if let colors = type.getbackgroundColors() {
                SettingsViewModel.sharedInstance.setBackground(colors[indexPath.row])
            }
            updateViewsBackgroundColor()

        case .dateFormat:
            if let formats = type.getDateFormats() {
                SettingsViewModel.sharedInstance.setDateFormat(formats[indexPath.row])
            }
            
        case .watchFace:
            SettingsViewModel.sharedInstance.setWatchFace(indexPath.row)
        }
        
        let selectedIndex = getSelectedIndexPath(selectionType)
        setSelectedIndexPath(indexPath.row, selectionType)
        tableView.reloadRows(at: [IndexPath(row: selectedIndex, section: 0), indexPath], with: .none)
    }
}

extension SelectionType {
    
    func getContentList() -> [String?] {
        switch self {
        case .background:
            return ["Black", "Red respberry", "Denim blue", "Blue cobalt",
                    "Dark olive", "Rose red", "Ultra violet", "Spicy orange",
                    "Cosmos blue", "Midnight blue", "Red",
                    "Bright orange", "Electric blue", "Soft pink",
                    "Taupe", "Charcoal grey", "Dark aubergine", "Cosmos blue", "Pink fuchsia",
                    "Saddle brown", "Pink", "Purple", "Blue", "Teal blue", "Green"]
            
        case .dateFormat:
            return ["2018/09/08", "2018/09/08, Saturday", "2018-09-08", "2018-09-08, Saturday",
                    "08 Sep 2018", "08 Sep 2018, Saturday", "Sep 08", "Sep 08, Saturday",
                    "09-08", "09-08, Saturday"]
            
        case .watchFace:
            return [nil, "10:10"]
        }
    }
    
    func getbackgroundColors() -> [String]? {
        if self == .background {
            return ["#000000", "#c96167", "#637fa1", "#4c5c77",
                    "#5a574f", "#a44459", "#4b3b7d", "#e37c5a",
                    "#3d4d57", "#4a4d5d", "#a3262a",
                    "#d96646", "#4869a9", "#dda69c",
                    "#888078", "#494844", "#362d39", "#3a4d5b", "#a74f63",
                    "#986448", "#ff2d55", "#5856d6", "#007aff", "#5ac8fa", "#4cd964"]
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
