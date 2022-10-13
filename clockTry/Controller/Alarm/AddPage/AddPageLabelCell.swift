//
//  AddPageLabelCell.swift
//  clockTry
//
//  Created by Hung-Ming Chen on 2022/8/10.
//

import UIKit

class AddPageLabelCell: UITableViewCell {

    @IBOutlet weak var settingLabel: UILabel!
    @IBOutlet weak var showLabel: UILabel!
    @IBOutlet weak var chevronImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
