//
//  ViewController.swift
//  Sunset
//
//  Created by Kevin Lima on 26-02-17.
//  Copyright © 2017 Kevin Lima. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
        
        // Double tap
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        doubleTap.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTap)
	}
    @IBAction func infoButton(_ sender: Any) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "InformationViewController") as UIViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func doubleTapped(){
        NotificationCenter.default.post(name: NSNotification.Name("doubleTapped"), object: nil)
    }
}

