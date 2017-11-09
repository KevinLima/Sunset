//
//  ViewController.swift
//  Sunset
//
//  Created by Kevin Lima on 26-02-17.
//  Copyright © 2017 Kevin Lima. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	@IBOutlet weak var locationLabel: UILabel!
	@IBOutlet weak var sunriseLabel: UILabel!
	@IBOutlet weak var sunsetLabel: UILabel!
	@IBOutlet weak var daylengthLabel: UILabel!
    @IBOutlet weak var settingsButtonOutlet: UIButton!
    let settingsView = SettingsView.instanceFromNib()
    var settingsActive = false
    let sun = Sun()
	

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		reloadData()
		NotificationCenter.default.addObserver(self, selector: #selector(ViewController.reloadData(notification:)), name: Notification.Name("reloadData"), object: nil)
	}
    
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        settingsView.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = NSLayoutConstraint(item: settingsView, attribute: .top, relatedBy: .equal, toItem: view, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        let leadingConstraint = NSLayoutConstraint(item: settingsView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: settingsView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: settingsView, attribute: .bottom, relatedBy: .equal, toItem:settingsButtonOutlet , attribute: .top, multiplier: 1, constant: 0)
        
        self.view.addSubview(settingsView)
        self.view.addConstraints([topConstraint, leadingConstraint, trailingConstraint, bottomConstraint])
    }
	
    @IBAction func settingsButtonAction(_ sender: Any) {
        if settingsActive{
            settingsView.isHidden = true
            settingsActive = false
            settingsButtonOutlet.setTitle("Settings", for: .normal)
        }else{
            settingsView.isHidden = false
            settingsActive = true
            settingsButtonOutlet.setTitle("Back", for: .normal)
        }
    }
    @objc func reloadData(notification:Notification){
		print("Notification recieved")
		reloadData()
	}
	
	func reloadData(){
		DispatchQueue.main.async {
			self.locationLabel.text = self.sun.getLocation()
			self.sunsetLabel.text = self.sun.getSunset()
			self.sunriseLabel.text = self.sun.getSunrise()
			self.daylengthLabel.text = self.sun.getDayLength()
		}
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

