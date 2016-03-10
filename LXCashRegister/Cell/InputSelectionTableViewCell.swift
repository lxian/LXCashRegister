//
//  InputSelectionTableViewCell.swift
//  LXCashRegister
//
//  Created by XianLi on 10/3/2016.
//  Copyright © 2016 LXIAN. All rights reserved.
//

import UIKit

class InputSelectionTableViewCell: UITableViewCell {
    
    static var preferredReuseIdent = "InputSelectionTableViewCell"
    static var preferredHeight = CGFloat(40)

    @IBOutlet weak var inputFileNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
