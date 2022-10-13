//
//  clockTry.swift
//  clockTry
//
//  Created by Hung-Ming Chen on 2022/6/30.
//

import UIKit
import RealmSwift
import UserNotifications

class AlarmViewController: UIViewController {

    @IBOutlet weak var AlarmTableView: UITableView!
    
    var notificationID: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationRightButton()
        registerCell()
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        self.navigationItem.title = "鬧鐘"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AlarmTableView.reloadData()
    }
    
    func registerCell() {
        AlarmTableView.register(UINib(nibName: "AlarmTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        AlarmTableView.delegate = self
        AlarmTableView.dataSource = self
    }
 

    func navigationRightButton() {
        let rightButton = UIBarButtonItem(title: nil, style: .plain, target: self, action: #selector(addAlarm))
        
        rightButton.tintColor = .blue
        rightButton.image = UIImage(systemName: "plus")
        
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    func createNotificationId(selectRow: Int) {
        let realm = try! Realm()
        let cells = realm.objects(AlarmRealm.self)

        if cells.count > 0 {
            self.notificationID = cells[selectRow].ID
        }
    }
    
    func createNotification(selectRow: Int, repeatDay: Int, weekDay: Bool = false) {
        let realm = try! Realm()
        let cells = realm.objects(AlarmRealm.self)
        let content = UNMutableNotificationContent()
        
        content.title = "Clcok"
        content.body = cells[selectRow].labelText
        content.badge = 0
        content.sound = UNNotificationSound.default
        
        let date = Date()
        let components: Set<Calendar.Component> = weekDay ? ([.weekday, .hour, .minute]) : ([.hour, .minute])
        var dataComponets = Calendar.current.dateComponents(components, from: date)
        
        if weekDay {
            dataComponets.weekday = repeatDay
            dataComponets.hour = cells[selectRow].Hour
            dataComponets.minute = cells[selectRow].Minute
        } else {
            dataComponets.hour = cells[selectRow].Hour
            dataComponets.minute = cells[selectRow].Minute
        }
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dataComponets, repeats: true)
        let request = UNNotificationRequest(identifier: cells[selectRow].ID, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if (error != nil) {
                print("錯誤！")
            }
        }
    }
    
    func createNotification1(selectRow: Int, repeatDay: Int) {
        let realm = try! Realm()
        let cells = realm.objects(AlarmRealm.self)
        let content = UNMutableNotificationContent()
        
        content.title = "Clcok"
        content.body = cells[selectRow].labelText
        content.badge = 0
        content.sound = UNNotificationSound.default
        
        let date = Date()
        
        var dataComponets = Calendar.current.dateComponents([.weekday, .hour, .minute], from: date)
        
        dataComponets.weekday = repeatDay
        dataComponets.hour = cells[selectRow].Hour
        dataComponets.minute = cells[selectRow].Minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dataComponets, repeats: true)
        let request = UNNotificationRequest(identifier: cells[selectRow].ID, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if (error != nil) {
                print("錯誤！")
            }
        }
    }
    
    func createNotification2(selectRow: Int) {
        let realm = try! Realm()
        let cells = realm.objects(AlarmRealm.self)
        let content = UNMutableNotificationContent()
        
        content.title = "Clcok"
        content.body = cells[selectRow].labelText
        content.badge = 0
        content.sound = UNNotificationSound.default
        
        let date = Date()
        
        var dataComponets = Calendar.current.dateComponents([.hour, .minute], from: date)
        
        dataComponets.hour = cells[selectRow].Hour
        dataComponets.minute = cells[selectRow].Minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dataComponets, repeats: true)
        let request = UNNotificationRequest(identifier: cells[selectRow].ID, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if (error != nil) {
                print("錯誤！")
            }
        }
    }
    
    @objc func addAlarm() {
        let addPageVC = AddPageViewController()
        
        addPageValue.pageValue.addStruct = true
        addPageValue.pageValue.repeatDayCheck = [false, false, false, false, false, false, false]
        addPageValue.pageValue.labelText = ""
        addPageValue.pageValue.soundSelect = 0
        addPageValue.pageValue.switchOnOff = true
        
        self.navigationController?.pushViewController(addPageVC, animated: true)
    }
}

extension AlarmViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let realm = try! Realm()
        let cells = realm.objects(AlarmRealm.self)
        return cells.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AlarmTableViewCell
        let realm = try! Realm()
        let cells = realm.objects(AlarmRealm.self)
        let repeatDays = [cells[indexPath.row].Sunday,
                          cells[indexPath.row].Monday,
                          cells[indexPath.row].Tuesday,
                          cells[indexPath.row].Wednesday,
                          cells[indexPath.row].Thursday,
                          cells[indexPath.row].Friday,
                          cells[indexPath.row].Saturday]
        var repeatDayCount = 0
        
        cell.tag = indexPath.row
        cell.timeLabel.text = String(format: "%2d:%02d", arguments: [cells[indexPath.row].Hour, cells[indexPath.row].Minute])
        cell.timeLabel.font = cell.timeLabel.font.withSize(60)
        cell.soundLabel.text = addPageValue.pageValue.soundSource[cells[indexPath.row].soundSelect]
        if cells[indexPath.row].switchOnOff {
            cell.onOffSwitch.isOn = true
            createNotificationId(selectRow: indexPath.row)
            for i in 1...7 {
                if repeatDays[i-1] {
                    createNotification1(selectRow: indexPath.row, repeatDay: i)
                    repeatDayCount += 1
                }
            }
            if repeatDayCount == 0 {
                createNotification2(selectRow: indexPath.row)
            }
        } else {
            cell.onOffSwitch.isOn = false
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let realm = try! Realm()
        let cells = realm.objects(AlarmRealm.self)
        
        addPageValue.pageValue.addStruct = false
        addPageValue.pageValue.selectCell = indexPath.row
        addPageValue.pageValue.repeatDayCheck = [cells[indexPath.row].Sunday,
                                                 cells[indexPath.row].Monday,
                                                 cells[indexPath.row].Tuesday,
                                                 cells[indexPath.row].Wednesday,
                                                 cells[indexPath.row].Thursday,
                                                 cells[indexPath.row].Friday,
                                                 cells[indexPath.row].Saturday]
        addPageValue.pageValue.labelText = cells[indexPath.row].labelText
        addPageValue.pageValue.soundSelect = cells[indexPath.row].soundSelect
        addPageValue.pageValue.switchOnOff = cells[indexPath.row].switchOnOff
        
        self.navigationController?.pushViewController(AddPageViewController(), animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return AlarmTableView.frame.height / 5
    }
}
