//
//  WorldClockViewController.swift
//  clockTry
//
//  Created by Hung-Ming Chen on 2022/7/26.
//

import UIKit

class WorldClockViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddTimeZoneDelegate{
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "世界時鐘"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        DoGCDTimer()
        NavigationRightButton()
        registerCell()
    }
    
    @IBOutlet weak var WorldClockTableView: UITableView!
    
    let TimeForMatter = DateFormatter()
    let MainTimer = DispatchSource.makeTimerSource(flags: [], queue: .global())
    var TimeZones = [String]()

    func AddTimeZone(AddedTimeZones: String) {
        TimeZones.append(AddedTimeZones)
        WorldClockTableView.reloadData()
    }
    
    func registerCell(){
        WorldClockTableView.register(UINib(nibName: "WorldClockTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        WorldClockTableView.dataSource = self
        WorldClockTableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        TimeZones.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = WorldClockTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WorldClockTableViewCell
        
        TimeForMatter.dateFormat = "h:mm a"
        TimeForMatter.timeZone = TimeZone.init(identifier: TimeZones[indexPath.row])
        
        cell.TimeZoneLabel.text = TimeZones[indexPath.row].components(separatedBy: "/").last!
        cell.TimeLabel.text = TimeForMatter.string(from: Date())
        cell.GMTLabel.text = "\((TimeZone(identifier: TimeZones[indexPath.row])?.secondsFromGMT())!/3600) Hours"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            TimeZones.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func NavigationRightButton(){
        let RightButton = UIBarButtonItem(title: nil, style: .plain, target: self, action: #selector(AddWorldClock))
       
        RightButton.tintColor = .blue
        RightButton.image = UIImage(systemName: "plus")
        
        self.navigationItem.rightBarButtonItem = RightButton
    }
    
    @objc func AddWorldClock(){
        let SearchPageVC = SearchPageViewController()
        
        SearchPageVC.ShowTimeZoneDelegate = self
        
        self.navigationController?.pushViewController(SearchPageVC, animated: true)
    }
    
    func DoGCDTimer(){
        MainTimer.schedule(deadline: .now(), repeating: .seconds(10))
        MainTimer.setEventHandler{[self] in
            DispatchQueue.main.async {
                WorldClockTableView.reloadData()
            }
        }
        
        if MainTimer.isCancelled{
            return
        }
        
        MainTimer.resume()
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
