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
        NotificationCenter.default.addObserver(self, selector: #selector(FirstViewController.receiveLocation(notification:)), name: Notification.Name("locationReady"), object: nil)
    }
    override func viewDidDisappear(_ animated: Bool) {
        self.reloadPresentation()
    }
    
    /**
     Receives the notification that theres a new location to be used
     */
    @objc func receiveLocation(notification:Notification){
        reloadPresentation()
    }
    
    func reloadPresentation(){
        if (self.cityLabel != nil){
            if let userCity = UserDefaults.standard.object(forKey: "city") as? String{
                self.cityLabel.text = userCity
            }else{
                self.cityLabel.text = "Loading"
            }
        }
        if (self.countryLabel != nil){
            if let userCountry = UserDefaults.standard.object(forKey: "country") as? String{
                self.countryLabel.text = userCountry
            }else{
                self.countryLabel.text = "Loading"
            }
        }
    }
}
