//
//  AddPageValue.swift
//  clockTry
//
//  Created by Hung-Ming Chen on 2022/9/15.
//

import Foundation

class addPageValue {
    
    static let pageValue = addPageValue()
    
    var addStruct = true
    var selectCell = 0
    var pickHour = 0
    var pickMinute = 0
    var repeatDayCheck = [false, false, false, false, false, false, false]
    var labelText = ""
    var soundSource = ["口哨", "平靜", "活潑", "音效", "音樂盒", "悅耳", "清脆", "網球"]
    var soundSelect = 0
    var switchOnOff = true
    
    private init() {}
}
