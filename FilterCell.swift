//
//  FilterCell.swift
//  DownToEat
//
//  Created by Thuy Nguyen on 4/23/16.
//  Copyright © 2016 GrabABite. All rights reserved.
//

import UIKit

@objc protocol FilterCellDelegate{
    optional func filterCell(filterCell: FilterCell, didChangeValue value:Bool)
}

class FilterCell: UITableViewCell {
    
    @IBOutlet weak var onSwitch: UISwitch!
    @IBOutlet weak var filterLabel: UILabel!
    weak var delegate: FilterCellDelegate?
	var config = Config.sharedInstance
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        onSwitch.addTarget(self, action: #selector(FilterCell.switchValueChange), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func switchValueChange(){
        delegate?.filterCell?(self, didChangeValue: onSwitch.on)
    }
}

