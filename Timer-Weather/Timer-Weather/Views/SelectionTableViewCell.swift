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
    @IBOutlet weak var clockView: AnalogClockView!
    @IBOutlet weak var flipClockView: FlipClockView!

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
            let bgColor = Preferences.sharedInstance.getBackground()
            self.contentView.backgroundColor = UIColor().hexStringToUIColor(hex: bgColor)
        }
        checkImageView.isHidden = !isSelected
        clockView.isHidden = true
        flipClockView.isHidden = true

        if let content = content {
            contentLabel.text = content
            contentLabel.isHidden = false
        } else {
            contentLabel.isHidden = true
        }
        
        if type == .watchFace {
            if indexPath.row == 8 {
                clockView.isHidden = true
                flipClockView.isHidden = true
            } else if indexPath.row == 9 {
                contentLabel.isHidden = true
                clockView.isHidden = true
                flipClockView.isHidden = false
                flipClockView.setClockWithDate(Date(), animated: false)
            } else if let content = content {
                contentLabel.isHidden = true
                clockView.isHidden = false
                flipClockView.isHidden = true
                clockView.backgroundImageView.image = UIImage(named: content)
            }
        }
    }
}

