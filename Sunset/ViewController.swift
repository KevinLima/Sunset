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

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		let sun = Sun()
		locationLabel.text = sun.getLocation()
		sunsetLabel.text = sun.getSunset()
		sunriseLabel.text = sun.getSunrise()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

