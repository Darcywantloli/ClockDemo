//
//  RepeatPageViewController.swift
//  clockTry
//
//  Created by Hung-Ming Chen on 2022/8/11.
//

import UIKit

class RepeatPageViewController: UIViewController {

    @IBOutlet weak var RepeatPageTableView: UITableView!
    
    let weekDay = ["週日", "週一", "週二", "週三", "週四", "週五", "週六"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCell()
    }
    
    func registerCell() {
        RepeatPageTableView.register(UINib(nibName: "RepeatPageTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        RepeatPageTableView.delegate = self
        RepeatPageTableView.dataSource = self
    }
}

extension RepeatPageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weekDay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = RepeatPageTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RepeatPageTableViewCell
        cell.WeekLabel.text = "\(weekDay[indexPath.row])"
        
        if addPageValue.pageValue.repeatDayCheck[indexPath.row] {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tableViewHeigth = RepeatPageTableView.frame.height
        let cellHeight = tableViewHeigth / 7
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        addPageValue.pageValue.repeatDayCheck[indexPath.row] = !addPageValue.pageValue.repeatDayCheck[indexPath.row]
        RepeatPageTableView.reloadData()
    }
}
