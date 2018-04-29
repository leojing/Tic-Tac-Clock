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
    case background = "Background"
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
            SettingsViewModel.sharedInstance.setBackground(colors[selectedIndex.row])
        }
        
        self.navigationBar.items?.first?.title = selectionType?.rawValue
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let colorString = SettingsViewModel.sharedInstance.getBackground() {
            let bgColor = UIColor().hexStringToUIColor(hex: colorString)
            navigationBar.barTintColor = bgColor
            self.view.backgroundColor = bgColor
        }
    }
    
    // MARK: set & get for selected index of data
    
    func setSelectedIndexPath(_ index: IndexPath, _ selectiontype: SelectionType?) {
        userDefaults.setValue(index, forKey: "index of \(selectiontype.debugDescription)")
    }
    
    func getSelectedIndexPath( _ selectiontype: SelectionType?) -> IndexPath {
        if let index = userDefaults.value(forKey: "index of \(selectiontype.debugDescription)") {
            return index as! IndexPath
        }
        return IndexPath(row: 0, section: 0)
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
        cell.configureCell(selectionType, selectionType?.getContentList()[indexPath.row], isSelected: (selectedIndex == indexPath))
        
        return cell
    }
}

extension SelectionType {
    
    func getContentList() -> [String?] {
        switch self {
        case .background:
            return ["Lemonade", "Respberry", "Denim Blue", "White", "Blue cobalt",
                    "Dark Olive", "Rose Red", "Ultra violet", "Flash", "Spicy orange",
                    "Cosmos blue", "Midnight blue", "Pink sand", "Black", "Red",
                    "Bright Orange", "Spring yellow", "Electric blue", "Soft pink",
                    "Taupe", "Charcoal grey", "Dark aubergine", "Cosmos blue", "Pink fuchsia",
                    "Midnight blue - 2", "Saddle brown", "black - 2"]
            
        case .dateFormat:
            return ["2018/09/08", "2018/09/08, Saturday", "2018-09-08", "2018-09-08, Saturday",
                    "08 Sep 2018", "08 Sep 2018, Saturday", "Sep 08", "Sep 08, Saturday",
                    "09-08", "09-08, Saturday"]
            
        case .watchFace:
            return [nil, "10\n:10"]
        }
    }
    
    func getbackgroundColors() -> [String]? {
        if self == .background {
            return [/*"#efe389"*/"F6E652", "#c96167", "#637fa1", "#f6f5f3", "#4c5c77", "#5a574f",
                    "#a44459", "#4b3b7d", "#fbf87f", "#e37c5a", "#3d4d57", "#4a4d5d",
                    "#dac9c7", "#404143", "#a3262a", "#d96646", "#e4d162", "#4869a9",
                    "#dda69c", "#888078", "#494844", "#362d39", "#3a4d5b", "#a74f63",
                    "#3f4659", "#986448", "#363636"]
        }
        return nil
    }
}
