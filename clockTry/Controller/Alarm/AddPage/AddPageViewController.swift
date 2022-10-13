//
//  AddPageViewController.swift
//  clockTry
//
//  Created by Hung-Ming Chen on 2022/8/10.
//

import UIKit
import RealmSwift

class AddPageViewController: UIViewController {

    @IBOutlet weak var addPagePickerView: UIPickerView!
    @IBOutlet weak var addPageTableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    
    let numbersOf24 = [Int](0...23)
    let numbersOf60 = [Int](0...59)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationRightButton()
        registerCell()
        
        addPageTableView.isScrollEnabled = true
        addButton.setTitle("儲存", for: .normal)
        
        addPagePickerView.delegate = self
        addPagePickerView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addPageTableView.reloadData()
    }
    
    func registerCell() {
        addPageTableView.register(UINib(nibName: "AddPageLabelCell", bundle: nil), forCellReuseIdentifier: "LabelCell")
        addPageTableView.register(UINib(nibName: "AddPageSwitchCell", bundle: nil), forCellReuseIdentifier: "SwitchCell")
        addPageTableView.delegate = self
        addPageTableView.dataSource = self
    }
    
    @IBAction func saveDataToRealm(_ sender: Any) {
        let realm = try! Realm()
        let inputData = AlarmRealm()
        let cells = realm.objects(AlarmRealm.self)
      
        if addPageValue.pageValue.addStruct {
            inputData.Hour = addPageValue.pageValue.pickHour
            inputData.Minute = addPageValue.pageValue.pickMinute
            inputData.Sunday = addPageValue.pageValue.repeatDayCheck[0]
            inputData.Monday = addPageValue.pageValue.repeatDayCheck[1]
            inputData.Tuesday = addPageValue.pageValue.repeatDayCheck[2]
            inputData.Wednesday = addPageValue.pageValue.repeatDayCheck[3]
            inputData.Thursday = addPageValue.pageValue.repeatDayCheck[4]
            inputData.Friday = addPageValue.pageValue.repeatDayCheck[5]
            inputData.Saturday = addPageValue.pageValue.repeatDayCheck[6]
            inputData.labelText = addPageValue.pageValue.labelText
            inputData.soundSelect = addPageValue.pageValue.soundSelect
            inputData.switchOnOff = addPageValue.pageValue.switchOnOff
            
            try! realm.write {
                realm.add(inputData)
            }
        } else {
            try! realm.write {
                cells[addPageValue.pageValue.selectCell].Hour = addPageValue.pageValue.pickHour
                cells[addPageValue.pageValue.selectCell].Minute = addPageValue.pageValue.pickMinute
                cells[addPageValue.pageValue.selectCell].Sunday = addPageValue.pageValue.repeatDayCheck[0]
                cells[addPageValue.pageValue.selectCell].Monday = addPageValue.pageValue.repeatDayCheck[1]
                cells[addPageValue.pageValue.selectCell].Tuesday = addPageValue.pageValue.repeatDayCheck[2]
                cells[addPageValue.pageValue.selectCell].Wednesday = addPageValue.pageValue.repeatDayCheck[3]
                cells[addPageValue.pageValue.selectCell].Thursday = addPageValue.pageValue.repeatDayCheck[4]
                cells[addPageValue.pageValue.selectCell].Friday = addPageValue.pageValue.repeatDayCheck[5]
                cells[addPageValue.pageValue.selectCell].Saturday = addPageValue.pageValue.repeatDayCheck[6]
                cells[addPageValue.pageValue.selectCell].labelText = addPageValue.pageValue.labelText
                cells[addPageValue.pageValue.selectCell].soundSelect = addPageValue.pageValue.soundSelect
                cells[addPageValue.pageValue.selectCell].switchOnOff = addPageValue.pageValue.switchOnOff
            }
        }
        
        print("fileURL:\(realm.configuration.fileURL!)")
        self.navigationController?.popViewController(animated: true)
    }
    
        
    func navigationRightButton() {
        let rightButton = UIBarButtonItem(title: nil, style: .plain, target: self, action: #selector(deleteAlarm))
        
        rightButton.tintColor = .blue
        rightButton.image = UIImage(systemName: "trash")
        
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func deleteAlarm() {
        let realm = try! Realm()
        let cells = realm.objects(AlarmRealm.self)
        let deleteCell = cells[addPageValue.pageValue.selectCell]
    
        try! realm.write{
            realm.delete(deleteCell)
        }
        
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [cells[addPageValue.pageValue.selectCell].ID])
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func switchAction(_ sender: UISwitch) {
        addPageValue.pageValue.switchOnOff = !addPageValue.pageValue.switchOnOff
    }
}

extension AddPageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = addPageTableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath) as! AddPageLabelCell
            let repeatWeek = addPageValue.pageValue.repeatDayCheck
            
            cell.settingLabel.text = "重複"
            cell.settingLabel.textAlignment = .center
            cell.showLabel.textAlignment = .right
            
            if repeatWeek[0] && repeatWeek[1] && repeatWeek[2] && repeatWeek[3] && repeatWeek[4] && repeatWeek[5] && repeatWeek[6] {
                cell.showLabel.text = "每天"
            } else if !repeatWeek[0] && repeatWeek[1] && repeatWeek[2] && repeatWeek[3] && repeatWeek[4] && repeatWeek[5] && !repeatWeek[6] {
                cell.showLabel.text = "平日"
            } else if repeatWeek[0] && !repeatWeek[1] && !repeatWeek[2] && !repeatWeek[3] && !repeatWeek[4] && !repeatWeek[5] && repeatWeek[6] {
                cell.showLabel.text = "週末"
            } else if !repeatWeek[0] && !repeatWeek[1] && !repeatWeek[2] && !repeatWeek[3] && !repeatWeek[4] && !repeatWeek[5] && !repeatWeek[6] {
                cell.showLabel.text = "永不"
            } else {
                let week = ["日,", "一,", "二,", "三,", "四,", "五,", "六,"]
                var showDay = "每週"
                
                for i in 0...6 {
                    if repeatWeek[i] {
                        showDay.append(week[i])
                    }
                }
                
                showDay.removeLast(1)
                cell.showLabel.text = showDay
            }
            cell.chevronImageView.image = UIImage(systemName: "chevron.right")
            
            return cell
        case 1:
            let cell = addPageTableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath) as! AddPageLabelCell
            
            cell.settingLabel.text = "標籤"
            cell.settingLabel.textAlignment = .center
            cell.showLabel.textAlignment = .right
            cell.showLabel.text = addPageValue.pageValue.labelText
            cell.chevronImageView.image = UIImage(systemName: "chevron.right")
            
            return cell
        case 2:
            let cell = addPageTableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath) as! AddPageLabelCell
            
            cell.settingLabel.text = "鈴聲"
            cell.settingLabel.textAlignment = .center
            cell.showLabel.textAlignment = .right
            cell.showLabel.text = addPageValue.pageValue.soundSource[addPageValue.pageValue.soundSelect]
            cell.chevronImageView.image = UIImage(systemName: "chevron.right")
            
            return cell
        case 3:
            let cell = addPageTableView.dequeueReusableCell(withIdentifier: "SwitchCell", for: indexPath) as! AddPageSwitchCell
            
            cell.settingLabel.text = "啟動"
            cell.settingLabel.textAlignment = .center
            cell.selectionStyle = .none
            if addPageValue.pageValue.switchOnOff {
                cell.settingSwitch.isOn = true
            } else {
                cell.settingSwitch.isOn = false
            }
            cell.settingSwitch.addTarget(self, action: #selector(self.switchAction(_ :)), for: .touchUpInside)
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tableViewHeight = addPageTableView.frame.height
        let cellHeight = tableViewHeight / 4
        
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.navigationController?.pushViewController(RepeatPageViewController(), animated: true)
        case 1:
            self.navigationController?.pushViewController(LabelPageViewController(), animated: true)
        case 2:
            self.navigationController?.pushViewController(SoundPageViewController(), animated: true)
        default:
            return
        }
    }
}

extension AddPageViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return numbersOf24.count
        case 1:
            return numbersOf60.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return numbersOf24[row].description
        case 1:
            return numbersOf60[row].description
        default:
            return "error"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            addPageValue.pageValue.pickHour = numbersOf24[row]
        case 1:
            addPageValue.pageValue.pickMinute = numbersOf60[row]
        default:
            return
        }
    }

}
