//
//  StopWatchTableViewCell.swift
//  clockTry
//
//  Created by Hung-Ming Chen on 2022/7/11.
//

import UIKit

class StopWatchTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBOutlet weak var lapLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        lapLabel.textAlignment = .center
        lapLabel.font = lapLabel.font.withSize(20)
        
        timeLabel.textAlignment = .center
        timeLabel.font = timeLabel.font.withSize(20)
    }
    
}
