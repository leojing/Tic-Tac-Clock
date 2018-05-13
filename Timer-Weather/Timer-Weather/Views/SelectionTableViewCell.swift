//
//  SelectionTableViewCell.swift
//  Timer-Weather
//
//  Created by JINGLUO on 29/4/18.
//  Copyright © 2018 JINGLUO. All rights reserved.
//

import UIKit

class SelectionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var checkImageView: UIImageView!
    @IBOutlet weak var colockImageView: UIImageView!
    
    var indexPath = IndexPath()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static func reuseId() -> String {
        return String(describing: self)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configureCell(_ type: SelectionType?, _ content: String?, isSelected: Bool) {
        if type == .background, let colors = type?.getbackgroundColors() {
            contentView.backgroundColor = UIColor().hexStringToUIColor(hex: colors[indexPath.row])
        } else {
            if let bgColor = Preferences.sharedInstance.getBackground() {
                self.contentView.backgroundColor = UIColor().hexStringToUIColor(hex: bgColor)
            }
        }
        checkImageView.isHidden = !isSelected
        if let content = content {
            contentLabel.text = content
            contentLabel.isHidden = false
        } else {
            contentLabel.isHidden = true
        }
        colockImageView.isHidden = !(type == .watchFace && indexPath.row == 0)
    }
}

