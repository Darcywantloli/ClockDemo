//
//  SoundPageViewController.swift
//  clockTry
//
//  Created by Hung-Ming Chen on 2022/8/16.
//

import UIKit

class SoundPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        registerCell()
    }
    
    @IBOutlet weak var soundPageTableView: UITableView!
    
    func registerCell(){
        soundPageTableView.register(UINib(nibName: "SoundPageTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        soundPageTableView.delegate = self
        soundPageTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        addPageValue.pageValue.soundSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = soundPageTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SoundPageTableViewCell
        
        cell.SoundLabel.text = addPageValue.pageValue.soundSource[indexPath.row]
        
        if addPageValue.pageValue.soundSelect == indexPath.row {
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        addPageValue.pageValue.soundSelect = indexPath.row
        
        soundPageTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return soundPageTableView.frame.height / 10
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
