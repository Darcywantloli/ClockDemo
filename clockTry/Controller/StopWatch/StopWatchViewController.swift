//
//  stopWatchTry.swift
//  clockTry
//
//  Created by Hung-Ming Chen on 2022/7/6.
//

import UIKit

class StopWatchViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        regisiterCell()
        
        lapButton.isEnabled = false
        lapButton.setTitle("記錄", for: .normal)
        lapButton.setTitleColor(.lightGray, for: .normal)
        
        startLapButton.setTitle("開始", for: .normal)
        startLapButton.setTitleColor(.green, for: .normal)
        
        stopWatchLabel.textAlignment = .center
        stopWatchLabel.font = stopWatchLabel.font.withSize(50)
        stopWatchLabel.text = "00:00:00:00"
    }

    @IBOutlet weak var stopWatchLabel: UILabel!
    @IBOutlet weak var startLapButton: UIButton!
    @IBOutlet weak var lapButton: UIButton!
    @IBOutlet weak var lapTableView: UITableView!
    
    var startStauts = true
    var lapStauts = false
    var milliSeconds = 0
    var timer = Timer()
    var stopWatchs = [String]()
    
    @IBAction func startOrStop(_ sender: Any) {
        if startStauts {
            startStauts = false
            lapStauts = true
            
            startLapButton.setTitle("Pause", for: .normal)
            startLapButton.setTitleColor(.red, for: .normal)
            
            lapButton.setTitle("Lap", for: .normal)
            lapButton.setTitleColor(.black, for: .normal)
            lapButton.isEnabled = true
            
            timer = Timer.scheduledTimer(timeInterval: TimeInterval(0.01), target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
            RunLoop.current.add(timer, forMode: .common)
        }else{
            startStauts = true
            lapStauts = false
            
            startLapButton.setTitle("Start", for: .normal)
            startLapButton.setTitleColor(.green, for: .normal)
            
            lapButton.setTitle("Reset", for: .normal)
            lapButton.setTitleColor(.black, for: .normal)
            
            timer.invalidate()
        }
    }
    
    @IBAction func lapOrReset(_ sender: Any) {
        if lapStauts{
            stopWatchs.insert(stopWatchLabel.text!, at: 0)
            lapTableView.reloadData()
        }else{
            stopWatchs.removeAll()
            lapTableView.reloadData()
            
            milliSeconds = 0
            calcuMilSec = 0
            calcuSec = 0
            calcuMin = 0
            calcuHor = 0
            
            stopWatchLabel.text = "00:00:00:00"
            
            startStauts = true
            lapStauts = false
            
            lapButton.setTitle("Lap", for: .normal)
            lapButton.setTitleColor(.black, for: .normal)
            lapButton.isEnabled = false
        }
    }
    
    var calcuMilSec = 0
    var calcuSec = 0
    var calcuMin = 0
    var calcuHor = 0
    
    @objc func countDown(){
        milliSeconds += 1
        
        calcuMilSec = milliSeconds % 100
        calcuSec = (milliSeconds / 100) % 60
        calcuMin = (milliSeconds / 6000) % 60
        calcuHor = (milliSeconds / 360000) % 24
        
        stopWatchLabel.text = String(format: "%02d:%02d:%02d.%02d", arguments: [calcuHor, calcuMin, calcuSec, calcuMilSec])
    }
    
    func regisiterCell(){
        lapTableView.register(UINib(nibName: "StopWatchTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        lapTableView.dataSource = self
        lapTableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        stopWatchs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! StopWatchTableViewCell
        
        cell.lapLabel.text = "Lap \(stopWatchs.count - indexPath.row)"
        cell.timeLabel.text = "\(stopWatchs[indexPath.row])"
        
        return cell
    }
//
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

    
    

