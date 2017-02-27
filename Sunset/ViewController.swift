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
	let sun = Sun()

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		locationLabel.text = sun.getLocation()
		sunsetLabel.text = sun.getSunset()
		sunriseLabel.text = sun.getSunrise()
		NotificationCenter.default.addObserver(self, selector: #selector(ViewController.reloadData(notification:)), name: Notification.Name("reloadData"), object: nil)
	}
	func reloadData(notification:Notification){
		locationLabel.text = sun.getLocation()
		sunsetLabel.text = sun.getSunset()
		sunriseLabel.text = sun.getSunrise()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

