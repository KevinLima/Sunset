//
//  SecondViewController.swift
//  
//
//  Created by Kevin Lima on 06/08/2018.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var dataKeys = ["Sunset",
                    "Sunrise",
                    "Solar noon",
                    "Civil twilight begin",
                    "Civil twilight end",
                    "Nautical twilight begin",
                    "Nautical twilight end",
                    "Astronomical twilight begin",
                    "Astronomical twilight end"]
    
    var dataValues = [Date]()
    var twentyFourHourClock = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(SecondViewController.reloadData(notification:)), name: Notification.Name("reloadData"), object: nil)
        self.displayData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataKeys.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reusableCell = tableView.dequeueReusableCell(withIdentifier: "reusableCell", for: indexPath)
        if self.dataValues.isEmpty{
            reusableCell.textLabel?.text = "Row \(indexPath.row)"
        }else{
            reusableCell.textLabel?.text = self.dataKeys[indexPath.row]
            
            let dateFormatter = DateFormatter()
            
            dateFormatter.dateFormat = "HH:mm"
            if !self.twentyFourHourClock{
                dateFormatter.dateFormat = "h:mm a"
            }
            
            reusableCell.detailTextLabel?.text = dateFormatter.string(from: self.dataValues[indexPath.row])
        }
        return reusableCell
    }
    
    @objc func reloadData(notification:Notification){
        print("Reload data notification recieved")
        self.displayData()
    }
    
    func displayData(){
        if let sunProfile = UserDefaults.standard.object(forKey: "sunProfileDates") as? [Date]{
            self.dataValues = sunProfile
        }
        self.tableView.reloadData()
    }
}
