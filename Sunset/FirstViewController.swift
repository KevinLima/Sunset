//
//  FirstViewController.swift
//  
//
//  Created by Kevin Lima on 06/08/2018.
//

import UIKit

class FirstViewController: UIViewController {
    public var city = "Loading"
    public var country = "Loading"
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reloadPresentation()
    }
    
    /**
     Receives the notification that theres a new location to be used
     */
    @objc func receiveLocation(notification:Notification){
        print("Present Location notification received")
        if let location = notification.userInfo?["location"] as? [String]{
            self.city = location[0]
            self.country = location[1]
        }
        reloadPresentation()
    }
    
    func reloadPresentation(){
        if (self.cityLabel != nil){
            self.cityLabel.text = self.city
        }
        if (self.countryLabel != nil){
            self.countryLabel.text = self.country
        }
    }
}
