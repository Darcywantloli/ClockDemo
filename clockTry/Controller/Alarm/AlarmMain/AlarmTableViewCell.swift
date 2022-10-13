//
//  clockTableViewCell.swift
//  clockTry
//
//  Created by Hung-Ming Chen on 2022/6/30.
//

import UIKit
import RealmSwift
import UserNotifications

class AlarmTableViewCell: UITableViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var soundLabel: UILabel!
    @IBOutlet weak var onOffSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func onOff(_ sender: Any) {
        let realm = try! Realm()
        let cells = realm.objects(AlarmRealm.self)
        try! realm.write {
            cells[tag].switchOnOff = !cells[tag].switchOnOff
        }
        let repeatDays = [cells[tag].Sunday,
                          cells[tag].Monday,
                          cells[tag].Tuesday,
                          cells[tag].Wednesday,
                          cells[tag].Thursday,
                          cells[tag].Friday,
                          cells[tag].Saturday]
        var repeatDayCount = 0
        
        let alarmVC = AlarmViewController()
        
        if onOffSwitch.isOn {
            alarmVC.createNotificationId(selectRow: tag)
            for i in 1...7 {
                if repeatDays[i-1] {
                    alarmVC.createNotification1(selectRow: tag, repeatDay: i)
                    repeatDayCount += 1
                }
            }
            if repeatDayCount == 0 {
                alarmVC.createNotification2(selectRow: tag)
            }
        } else {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [cells[tag].ID])
        }
    }
}
