//
//  AlarmRealm.swift
//  clockTry
//
//  Created by Hung-Ming Chen on 2022/8/16.
//

import RealmSwift
import Foundation

class AlarmRealm: Object {

    @objc dynamic var ID = UUID().uuidString
    @objc dynamic var Hour: Int = 0
    @objc dynamic var Minute: Int = 0
    @objc dynamic var Sunday: Bool = false
    @objc dynamic var Monday: Bool = false
    @objc dynamic var Tuesday: Bool = false
    @objc dynamic var Wednesday: Bool = false
    @objc dynamic var Thursday: Bool = false
    @objc dynamic var Friday: Bool = false
    @objc dynamic var Saturday: Bool = false
    @objc dynamic var labelText: String = ""
    @objc dynamic var soundSelect: Int = 0
    @objc dynamic var switchOnOff: Bool = true
    
    override static func primaryKey() -> String? {
        return "ID"
    }
}
