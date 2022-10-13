//
//  SearchPageViewController.swift
//  clockTry
//
//  Created by Hung-Ming Chen on 2022/7/30.
//

import UIKit

class SearchPageViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {

    var TimeZones = [String]()
    var ShowTimeZoneDelegate: AddTimeZoneDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TimeZones = NSTimeZone.knownTimeZoneNames
        
        SearchPageSearchBar.delegate = self
        SearchPageSearchBar.placeholder = "選擇時區...."
        SearchPageSearchBar.showsCancelButton = true
        
        registerCell()
    }
    
    @IBOutlet weak var SearchPageSearchBar: UISearchBar!
    @IBOutlet weak var SearchPageTableView: UITableView!
    
    func registerCell(){
        SearchPageTableView.register(UINib(nibName: "SearchPageTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        SearchPageTableView.dataSource = self
        SearchPageTableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        TimeZones.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SearchPageTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SearchPageTableViewCell
        
        cell.TimesZoneLabel.text = "\(TimeZones[indexPath.row])"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ShowTimeZoneDelegate?.AddTimeZone(AddedTimeZones: TimeZones[indexPath.row])
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if SearchPageSearchBar.text != ""{
            TimeZones = NSTimeZone.knownTimeZoneNames.filter({$0.localizedCaseInsensitiveContains(SearchPageSearchBar.text!)})
        }else{
            TimeZones = NSTimeZone.knownTimeZoneNames
        }
        
        SearchPageTableView.reloadData()
    }
}
protocol AddTimeZoneDelegate {
    func AddTimeZone(AddedTimeZones: String)
}
