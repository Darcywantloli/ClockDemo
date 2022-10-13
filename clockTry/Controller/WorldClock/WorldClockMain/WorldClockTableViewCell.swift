//
//  WorldClockTableViewCell.swift
//  clockTry
//
//  Created by Hung-Ming Chen on 2022/8/1.
//

import UIKit

class WorldClockTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        TimeZoneLabel.textAlignment = .left
        TimeZoneLabel.font = TimeZoneLabel.font.withSize(25)
        
        TimeLabel.textAlignment = .right
        TimeLabel.font = TimeLabel.font.withSize(55)
        
        GMTLabel.textAlignment = .left
        GMTLabel.font = GMTLabel.font.withSize(15)
    }

    @IBOutlet weak var TimeZoneLabel: UILabel!
    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var GMTLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
