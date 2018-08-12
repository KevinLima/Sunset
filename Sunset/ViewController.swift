//
//  ViewController.swift
//  Sunset
//
//  Created by Kevin Lima on 26-02-17.
//  Copyright © 2017 Kevin Lima. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var twentyFourHourClock = true
	

	override func viewDidLoad() {
		super.viewDidLoad()
        
		
        
        // Double tap
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        doubleTap.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTap)
	}
    
    @objc func doubleTapped(){
        self.twentyFourHourClock = !self.twentyFourHourClock
    }
}

